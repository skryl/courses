:load bench.scala
import scala.annotation.tailrec
import java.util.Random
import Bench._

// Toy BigInt Implementation
//
object BigInteger {

  type BI = List[Int]
  private def toList(n: String): BI = n.toList.map(_.toString.toInt)

  private def _add(a: BI, b: BI): BI = {
    def adder(a: Int, b: Int, carry: Int): (Int, Int) = {
      val s = a + b + carry
      (s % 10, s / 10)
    }

    @tailrec def recAdd(a: BI, b: BI, sum: BI, carry: Int): BI = { 
      (a,b) match {
        case (x :: xs, y :: ys) => {
          val (s, c) = adder(x, y, carry)
          recAdd(xs, ys, s :: sum, c) }
        case (x :: xs, Nil) => {
          val (s, c) = adder(x, 0, carry)
          recAdd(xs, Nil, s :: sum, c) }
        case (Nil, y :: ys) => {
          val (s, c) = adder(0, y, carry)
          recAdd(Nil, ys, s :: sum, c) }
        case (Nil, Nil) => if (carry > 0) 1 :: sum else sum
      }
    }
    recAdd(a.reverse, b.reverse, List(), 0)
  }

  private def _sub(a: BI, b: BI): BI = {

    @tailrec def compare(a: BI, b: BI, comp: Int): Int = (a,b) match {
      case (Nil, Nil)  => comp
      case (Nil, y :: ys) => -1
      case (x :: xs, Nil) => 1
      case (x :: xs, y :: ys) => {
        val comp1 = x.compareTo(y)
        if (comp1 == 0) compare(xs, ys, comp) 
        else compare(xs, ys, comp1) 
      }
    }

    def subtractor(a: Int, b: Int, carry: Int): (Int, Int) = {
      val t = (a - carry) - b
      val c = if (t < 0) 1 else 0
      val s = if (t < 0) 10 + t else t
      (s, c)
    }

    @tailrec def recSub(a: BI, b: BI, sum: BI, carry: Int): BI = { 
      (a,b) match {
        case (x :: xs, y :: ys) => {  
          val (s, c) = subtractor(x, y, carry)
          recSub(xs, ys, s :: sum, c) } 
        case (x :: xs, Nil) => {
          val (s, c) = subtractor(x, 0, carry)
          recSub(xs, Nil, s :: sum, c) } 
        case (Nil, Nil) => sum
      }
    }

    val (a_rev, b_rev) = (a.reverse, b.reverse)
    val comp = compare(a_rev, b_rev, 0)
    val ans = if (comp < 0) recSub(b_rev, a_rev, List(), 0)
              else recSub(a_rev, b_rev, List(), 0)

    ans.dropWhile(_ == 0)
  }

  private def _cross_mul(a: BI, b: BI): BI = {
    def shift(n: BI, i: Int): BI = n ++ List.fill(i)(0)

    val parts = for (bDig <- b.reverse) yield {
      val partial = a.foldRight((List[Int](), 0)){ 
        case (aDig, (partial, carry)) => { 
          val r = aDig * bDig + carry
          (r % 10 :: partial, r / 10) 
        }
      }
      partial._2 :: partial._1
    }

    parts.zipWithIndex.map{ case (p, i) => shift(p, i)}.reduceLeft(
      (a: BI, p: BI) => _add(a, p)
    ).dropWhile(_ == 0)
  }

  private def _rec_mul(a: BI, b: BI, karats: Boolean = true): BI= {
    def split(n: BI, len: Int) = n.splitAt(n.length - (len / 2))

    def padRight(n: BI, length: Int) = {
      val num = if (n.length == 0) n else n.padTo(n.length + length, 0) 
      num.dropWhile(_ == 0)
    }

    // Polynomial Multiplication
    //
    def mult_reg(a1: BI, a2: BI, b1: BI, b2: BI): BI = {
      val z0 = padRight(mult(a1, b1), a2.length + b2.length)
      val z1 = padRight(mult(a1, b2), a2.length)
      val z2 = padRight(mult(a2, b1), b2.length)
      val z3 = mult(a2, b2)
      _add(_add(z0, z1), _add(z2, z3))
    }

    // Karatsuba Multiplication
    //
    def mult_karats(a1: BI, a2: BI, b1: BI, b2: BI): BI = {
      val z0 = mult(a1, b1)
      val z1 = mult(a2, b2)
      val z2 = _sub(_sub(mult(_add(a1,a2), _add(b1,b2)), z0), z1)
      _add(_add(padRight(z0, a2.length + b2.length), padRight(z2, a2.length)), z1)
    }

    def mult(a: BI, b: BI): BI = {
      (a,b) match {
        case (x :: Nil, y :: Nil) => toList((x * y).toString)
        case (x :: Nil, y :: ys) => {
          val (b1, b2) = split(b, b.length)
          _add(padRight(mult(a, b1), b2.length), mult(a, b2))
        }
        case (x :: xs, y :: Nil) => mult(b, a)
        case (x :: xs, y :: ys) => {
          val m = a.length min b.length
          val (a1, a2) = split(a, m)
          val (b1, b2) = split(b, m)
          if (karats) mult_karats(a1, a2, b1, b2) 
            else mult_reg(a1, a2, b1, b2)
        }
      }
    }

    mult(a, b)
  }

  // Interface
  //
  def add(a: String, b: String): String = _add(toList(a), toList(b)).mkString 
  def sub(a: String, b: String): String = _sub(toList(a), toList(b)).mkString
  def cross_mul(a: String, b: String): String = _cross_mul(toList(a), toList(b)).mkString
  def rec_mulr(a: String, b: String): String = _rec_mul(toList(a), toList(b), false).mkString
  def rec_mulk(a: String, b: String): String = _rec_mul(toList(a), toList(b), true).mkString
}

import BigInteger._

def big_add(a: String, b: String): String = (BigInt(a) + BigInt(b)).toString
def big_sub(a: String, b: String): String = (BigInt(a) - BigInt(b)).abs.toString
def big_mul(a: String, b: String): String = (BigInt(a) * BigInt(b)).toString

def randBigint(maxlen: Int): String = {
  val r = new Random
  val len = r.nextInt(maxlen)

  if (len == 0) randBigint(maxlen)
  else {
    val num = List.fill(len)(0).map(i => r.nextInt(10)).dropWhile(_ == 0)
    if (num.length > 0) num.mkString else randBigint(maxlen)
  }
}

def test {
  for { i <- 0 to 10000 } {
    val a = randBigint(5)
    val b = randBigint(5)
    val t = cross_mul(a,b)
    val r = big_mul(a,b)

    if (r != t) {
      println(s"a = ${a}\nb = ${b}")
      println(s"r = ${r}\nt = ${t}")
      error("not equal")
    }
  }
  println("tests: PASS!")
}

def bench {
  val a = randBigint(1000)
  val b = randBigint(1000)
  println(s"a = ${a}\nb = ${b}")

  println("time1:")
  time { for (n <- (1 to 100)) { big_mul(a,b) } }
  println("time2:")
  time { for (n <- (1 to 100)) { rec_mulk(a,b) } }
  println("time3:")
  time { for (n <- (1 to 100)) { rec_mulr(a,b) } }
  println("time4:")
  time { for (n <- (1 to 100)) { cross_mul(a,b) } }
}

// test
bench
