import scala.annotation.tailrec

// Toy BigInt Implementation
//
object BigInteger {

  private def toList(n: String): List[Int] = n.toList.map(_.toString.toInt)

  private def _add(a: List[Int], b: List[Int]): List[Int] = {
    def adder(a: Int, b: Int, carry: Int): (Int, Int) = {
      val s = a + b + carry
      (s % 10, s / 10)
    }

    @tailrec def recAdd(a: List[Int], b: List[Int], sum: List[Int], carry: Int): List[Int] = { 
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

  private def _sub(a: List[Int], b: List[Int]): List[Int] = {
    @tailrec def compare(a: List[Int], b: List[Int], comp: Int): Int = (a,b) match {
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

    @tailrec def recSub(a: List[Int], b: List[Int], sum: List[Int], carry: Int): List[Int] = { 
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

  private def _cross_mul(a: List[Int], b: List[Int]): List[Int] = {
    (for (bDig <- b.reverse) yield {
      val partial = a.foldRight((List[Int](), 0)){ 
        case (aDig, (partial, carry)) => { 
          val r = aDig * bDig + carry
          (r % 10 :: partial, r / 10) 
        }
      }
      partial._2 :: partial._1
    }).reduceLeft((a, part) => _add(a, part))
  }

  private def _rec_mul(a: List[Int], b: List[Int]): List[Int]= {
    def split(n: List[Int]) = n.splitAt(n.length / 2)

    def padRight(n: List[Int], length: Int) = {
      if (n.length == 0) n
      else n.padTo(n.length + length, 0) 
    }

    // Polynomial Multiplication
    //
    def mult_reg(a1: List[Int], a2: List[Int], b1: List[Int], b2: List[Int]) = {
      val z0 = padRight(mult(a1, b1), a2.length + b2.length)
      val z1 = padRight(mult(a1, b2), a2.length)
      val z2 = padRight(mult(a2, b1), b2.length)
      val z3 = mult(a2, b2)
      // println(s"${z0.mkString} + ${z1.mkString} + ${z2.mkString} + ${z3.mkString}")
      _add(_add(z0, z1), _add(z2, z3))
    }

    // Karatsuba Multiplication
    // FIXME: failed tests
    def mult_karats(a1: List[Int], a2: List[Int], b1: List[Int], b2: List[Int]) = {
      val z0 = mult(a1, b1)
      val z1 = mult(a2, b2)
      val z2 = _sub(_sub(mult(_add(a1,a2), _add(b1,b2)), z0), z1)
      _add(_add(padRight(z2, a2.length + b2.length), z0), padRight(z1, a1.length))
    }

    def mult(a: List[Int], b: List[Int]): List[Int] = {
      (a,b) match {
        case (x :: Nil, y :: Nil) => toList((x * y).toString)
        case (x :: Nil, y :: ys) => {
          val (b1, b2) = split(b)
          _add(padRight(mult(a, b1), b2.length), mult(a, b2))
        }
        case (x :: xs, y :: Nil) => mult(b, a)
        case (x :: xs, y :: ys) => {
          val (a1, a2) = split(a)
          val (b1, b2) = split(b)
          mult_karats(a1, a2, b1, b2)
        }
      }
    }

    mult(a, b)
  }

  // Interface
  //
  def add(a: String, b: String): String = _add(toList(a), toList(b)).mkString 
  def sub(a: String, b: String): String = _sub(toList(a), toList(b)).mkString
  // FIXME: failed tests
  def cross_mul(a: String, b: String): String = _cross_mul(toList(a), toList(b)).mkString
  def rec_mul(a: String, b: String): String = _rec_mul(toList(a), toList(b)).mkString
}

import BigInteger._
import java.util.Random

def big_add(a: String, b: String): String = (BigInt(a) + BigInt(b)).toString
def big_sub(a: String, b: String): String = (BigInt(a) - BigInt(b)).abs.toString
def big_mul(a: String, b: String): String = (BigInt(a) * BigInt(b)).toString

def rand_bigint(maxlen: Int): String = {
  val r = new Random
  val len = r.nextInt(maxlen)

  if (len == 0) rand_bigint(maxlen)
  else {
    val num = List.fill(len)(0).map(i => r.nextInt(10)).dropWhile(_ == 0)
    if (num.length > 0) num.mkString else rand_bigint(maxlen)
  }
}

def time[A](a: => A) = {
  val now = System.nanoTime
  val result = a
  val micros = (System.nanoTime - now) / 1000
  println("%d microseconds".format(micros))
  result
}

def test {
  for { i <- 0 to 10000 } {
    val a = rand_bigint(50)
    val b = rand_bigint(50)
    val t = rec_mul(a,b)
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
  val a = rand_bigint(50)
  val b = rand_bigint(50)
  println("time1:")
  time { for (n <- (1 to 1000)) { rec_mul(a,b) } }
  println("time2:")
  time { for (n <- (1 to 1000)) { big_mul(a,b) } }
}

test
bench
