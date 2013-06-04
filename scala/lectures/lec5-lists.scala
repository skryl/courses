// lists

val l1 = List(1,2,3)

l1.length  // => 3
l1.head    // => 1
l1.tail    // => (2,3)
l1.init    // => (1,2)
l1.last    // => 3
l1.take(2) // => (1,2)
l1.drop(1) // => (2,3)
l1(2)      // => 3

val l2 = List(4,5,6)

l1 ++ l2         // => (1,2,3,4,5,6) // concat
l1 ::: l2        // => (1,2,3,4,5,6) // concat
l1.reverse       // => (3,2,1)
l1.updated(0, 4) // => (4,2,3)
l1.indexOf(2)    // => 1
l1.contains(1)   // => true

def last[T](xs: List[T]): T = xs match {
  case List()  => throw new Error("last of empty")
  case List(x) => x
  case y :: ys => last(ys)
}

def init[T](xs: List[T]): List[T] = xs match {
  case List()  => throw new Error("init of empty")
  case List(x) => List()
  case y :: ys => y :: init(ys)
}

def concat[T](xs: List[T], ys: List[T]): List[T] = xs match {
  case List()  => ys
  case z :: zs => z :: concat(zs, ys)
}

def reverse[T](xs: List[T]): List[T] = xs match {
  case List()  => xs
  case y :: ys =>  reverse(ys) ++ List(y)
}

def removeAt[T](n: Int, xs: List[T]): List[T] = {
  if (n == 0) xs.tail
  else xs.head :: removeAt(n - 1, xs.tail)
}

// or
//
def removeAt[T](n: Int, xs: List[T]): List[T] = (xs take n) ::: (xs drop (n + 1))

def flatten(xs: List[Any]): List[Any] = xs match {
  case Nil              => Nil
  case Nil :: xs        => flatten(xs)
  case (z :: zs) :: ys  => flatten(z :: zs) ::: flatten(ys)
  case x :: xs          => x :: flatten(xs)
}

// pairs and tuples

List(1,2,3,4,5,6).splitAt(3) // => ((1,2,3,(4,5,6) // pair

val pair = ("answer", 42)

// pattern matching

val (label, value) = pair

label  // => answer
value  // => 42

scala.Tuple2(1,2)

scala.Tuple3('a', 1, 0.4)

// tuple class
//
case class Tuple2[T1, T2](_1: +T1, _2: +T2) {
  override def toString = "(" + _1 + "," + _2 + ")"
}

pair._1
pair._2

// merge sort
//


// linear merge
//
def lmerge(xs: List[Int], ys: List[Int]): List[Int] = xs match {
  case Nil      => ys
  case x :: xs1 => ys match {
    case Nil      => xs
    case y :: ys1 => if (x < y) x :: lmerge(xs1, ys) else y :: lmerge(xs, ys1)
  }
}

// tupple matching (linear) merge
//
def tmerge[T](xs: List[T], ys: List[T])(lt: (T,T) => Boolean): List[T] = (xs, ys) match {
  case (Nil, ys) => ys
  case (xs, Nil) => xs
  case (x :: xs1, y :: ys1) =>
    if (lt(x,y)) x :: tmerge(xs1, ys)(lt) else y :: tmerge(xs, ys1)(lt)
}

// fast merge
//
def insert(x: Int, xs: List[Int]): List[Int] = {
  val n = xs.length / 2
  if (n == 0) xs match {
    case Nil     => List(x)
    case List(y) => if (x < y) List(x,y) else List(y,x)
  }
  else {
    val (fst, snd) = xs splitAt n
    if (x < snd.head) insert(x, fst) ++ snd else fst ++ insert(x, snd)
  }
}

def bimerge(xs: List[Int], ys: List[Int]): List[Int] = xs match {
  case Nil      => ys
  case x :: xs  => bimerge(xs, insert(x, ys))
}

// sort
//
def msort[T](xs: List[T])(lt: (T,T) => Boolean): List[T] = {
  val n = xs.length / 2
  if (n == 0) xs
  else {
    val (fst, snd) = xs splitAt n
    tmerge(msort(fst)(lt), msort(snd)(lt))(lt)
  }
}

// orderings and implicit parameters
//

scala.math.Ordering[T]

import math.Ordering

def msort[T](xs: List[T])(implicit ord: Ordering[T]): List[T] = {
  val n = xs.length / 2
  if (n == 0) xs
  else {
    def merge[T](xs: List[T], ys: List[T]): List[T] = (xs, ys) match {
      case (Nil, ys) => ys
      case (xs, Nil) => xs
      case (x :: xs1, y :: ys1) =>
        if (ord.lt(x,y)) x :: merge(xs1, ys) else y :: merge(xs, ys1)
    }
    val (fst, snd) = xs splitAt n
    merge(msort(fst), msort(snd))
  }
}

val nums = List(2, -4, 5, 7, 1)
val fruits = List("apple", "pineapple", "orange", "banana")

// without implicit orderings
//
msort(nums)(Ordering.Int)
msort(fruits)(Ordering.String)

// with implicit orderings (matching type must be defined on companion object of implicit param)
//
msort(nums)
msort(fruits)

// higher order list functions
//

// modification

def scaleList(xs: List[Double], factor: Double): List[Double] = xs match {
  case Nil     => xs
  case y :: ys => y * factor :: scaleList(ys, factor)
}

abstract class List[T] {
  def map[U](f: T => U): List[U] = this match {
    case Nil     => this
    case x :: xs => f(x) :: xs.map(f)
  }
}

def scaleList(xs: List[Double]), factor: Double) =
  xs map (x => x * factor)

def squareList(xs: List[Double]), factor: Double) =
  xs map (x => x * x)

// filtering

def posElems(xs: List[Int]): List[Int] = xs match {
  case Nil      => Nil
  case y :: ys  => if (y > 0) y :: posElems(ys) else posElems(ys)
}

abstract class List[T] {
  def filter(p: T => Boolean): List[T] = this match {
    case Nil     => this
    case x :: xs => if (p(x)) x :: xs.filter(p) else xs.filter(p)
  }
}

def posElems(xs: List[Int]): List[Int] =
  xs filter (x => x > 0)


// other filtering

val nums = List(2, -4, 5, 7, 1)
val fruits = List("apple", "pineapple", "orange", "banana")

nums filter (x => x > 0)      // => (2,5,7,1)
nums filterNot (x => x > 0)   // => (-4)
nums partition (x => x > 0)   // => ((2,5,7,1),(-4))

nums takeWhile (x => x > 0)   // => (2)
nums dropWhile (x => x > 0)   // => (-4,5,7,1)
nums span (x => x > 0)        // => ((2),(-4,5,7,1))

def pack[T](xs: List[T]): List[List[T]] = xs match {
  case Nil       => Nil
  case x :: xs1  => 
    val (first, rest) = xs span (y => y == x)
    first :: pack(rest)
}

def encode[T](xs: List[T]): List[(T,Int)] = pack(xs).map(x => (x(1),x.length) )

// reduction

def sum(xs: List[Int]): Int = xs match {
  case Nil      => 0
  case y :: ys  => y + sum(ys)
}

abstract class List[T] {
  def reduceLeft(op: (T, T) => T): T = this match {
    case Nil     => throw new Error("Nil.reduceLeft")
    case x :: xs => (xs foldLeft x)(op)
  }

  def foldLeft[U](z: U)(op: (U, T) => U): U = this match {
    case Nil     => z
    case x :: xs => (xs foldLeft op(z, x))(op)
  }

  def reduceRight(op: (T, T) => T): T = this match {
    case Nil      => throw new Error("Nil.reduceLeft")
    case x :: Nil => x
    case x :: xs  => op(x, xs reduceRight(op))
  }

  def foldRight[U](z: U)(op: (U, T) => U): U = this match {
    case Nil     => z
    case x :: xs => op(x, (xs foldRight z)(op))
  }
}

// reduceLeft

def sum(xs: List[Int]) = (0 :: xs) reduceLeft ((x, y) => x + y)
def product(xs: List[Int]) = (1 :: xs) reduceLeft ((x, y) => x + y)

// shorter anon functions

def sum(xs: List[Int]) = (0 :: xs) reduceLeft (_ + _)
def product(xs: List[Int]) = (1 :: xs) reduceLeft (_ * _)

// foldLeft (more general reduction)
//

def sum(xs: List[Int]) = (xs foldLeft 0) (_ + _)
def product(xs: List[Int]) = (xs foldLeft 1) (_ + _)

def concat[T](xs: List[T], ys: List[T]): List[T] =
  (xs foldRight ys) (_ :: _)

def concat[T](xs: List[T], ys: List[T]): List[T] =
  (xs foldLeft ys) (_ :: _)                          // => ERROR

def mapFun[T, U](xs: List[T], f: T => U): List[U] =
  (xs foldRight List[U]())(f(_) :: _)

def lengthFun[T](xs: List[T]): Int =
  (xs foldRight 0) ((x, a) => a + 1)
