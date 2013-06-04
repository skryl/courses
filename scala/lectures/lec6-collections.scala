// Vectors (immutable, type of Seq)
// arrays up to 32 items, log(32) trees for more items

val nums = Vector(1,2,3,-88)
val people = Vector("Bob", "James", "Peter")

// instead of cons

Vector(1,2,3) :+ 4
4 +: Vector(1,2,3) 

// Arrays and Strings (from Java, not Seq but act as such)

val xs = Array(1,2,3,44)
xs map (x => x * 2)

val s = "Hello World"
s filter (c => c.isUpper)

// Range

val r: Range = 1 until 5 // => (1...5)
val r2: Range = 1 to 5    // => (1..5)
1 to 10 by 3             // => (1,4,7,10)
6 to 1 by -2             // => (6,4,2)

// Seq methods

s exists (c => c.isUpper)  // => true
s forall (c => c.isUpper)  // => false

val pairs = List(1,2,3) zip s  // => ((1,H),(2,e),(3,l))
pairs unzip                // => ((1,2,3), ('Hel'))

s flatMap (c => List('.', c)) // => ".H.e.l.l.o. .W.o.r.l.d"
xs.sum                     // => 50
xs.max                     // => 44

// all combos of numbers 1..M and 1..N

(1 to 10) flatMap (x => (1 to 10) map ((x,_)))

def scalarProduct(xs: Vector[Double], ys: Vector[Double]): Double =
  (xs zip ys).map(xy => xy._1 * xy._2).sum

// or shorthand pattern match

def scalarProduct(xs: Vector[Double], ys: Vector[Double]): Double =
  (xs zip ys).map { case (x, y) => { x * y } }.sum

import scala.math._

def isPrime(n: Int): Boolean = (2 to sqrt(n).toInt) forall (f => n % f > 0)

// Combinatorial search and for-comprehensions
//

// prime pairs

val n = 10
(1 until n) flatMap (i =>
  (1 until i) map (j => (i,j)) ) filter (pair => 
     isPrime(pair._1 + pair._2 ))

// for expressions

case class Person(name: String, age: Int)

// names of people over 20

val persons = Vector(Person("a", 10), Person("b",21))

for (p <- persons if p.age > 20) yield p.name

// equivalent to

persons filter (p => p.age > 20) map (p => p.name)

// syntax - for ( s ) yield e - for { s } yield e

// prime pairs using for

for {
  i <- 1 until n
  j <- 1 until i
  if isPrime(i + j)
} yield (i,j)

// scalar product using for

def scalarProduct(xs: Vector[Double], ys: Vector[Double]): Double =
  (for ( (i,j) <- xs zip ys ) yield (i * j)).sum

// Sets

val fruit = Set("apple", "banana", "pear")
val s = (1 to 6).toSet

s contains 5     // => true

// n-queens

def queens(n: Int): Set[List[Int]] = {
  def isSafe(col: Int, queens: List[Int]): Boolean = {
    val row = queens.length
    val queensWithRow = (row - 1 to 0 by -1) zip queens
    queensWithRow forall {
      case (r,c) => col != c && math.abs(col - c) != row - r
    }
  }

  def placeQueens(k: Int): Set[List[Int]] = { 
    if (k == 0) Set(List())
    else 
      for {
        queens <- placeQueens(k-1)
        col    <- 0 until n
        if isSafe(col, queens)
      } yield col :: queens
  }
  placeQueens(n)
}

// queries with for

case class Book(title: String, authors: List[String])

val books: List[Book] = Set(
  Book(title = "SICP", authors = List("Abelson, Harald", "Sussman, Gerald")),
  Book(title = "Intro to FP", authors = List("Bird, Richard", "Wadler, Phil")),
  Book(title = "Effective Java", authors = List("Bloch, Joshua")),
  Book(title = "Java Puzzlers", authors = List("Bloch, Joshua", "Gafter, Neal")),
  Book(title = "Programming in Scala", authors = List("Odersky, Martin", "Spoon, Lex", "Venners, Bill"))
  )

for (b <- books; a <- b.authors if a startsWith "Bird,") yield b.title
for (b <- books if (b.title indexOf "Program") >= 0) yield b.title

// all authors who have written at least 2 books

for {
  b1 <- books
  b2 <- books
  if b1.title < b2.title
  a1 <- b1.authors
  a2 <- b2.authors
  if a1 == a2
} yield a1


// higher order list functions in terms of for

def mapFun[T, U](xs: List[T], f: T => U): List[U] =
  for (x <- xs) yield f(x)

def flatMapFun[T, U](xs: List[T], f: T => Iterable[U]): List[U] =
  for (x <- xs; y <- f(x)) yield y

def filterFun[T](xs: List[T], p: T => Boolean): List[T] =
  for (x <- xs if p(x)) yield x

// implementation of for in terms of map, flatMap, filter

for (x <- e1) yield e2

// is translated to

e1.map(x => e2)

// second form

for (x <- e1 if f; s) yield e2

// rewritten to

for (x <- e2.withFilter(x => f); s) yield e2

// last form

for (x <- e1; y <- e2; s) yield e3

// rewritten to

e1.flatMap(x => for (y <- e2; s) yield e3)

// example

for {
  i <- 1 until n
  j <- 1 until i
  if isPrime(i + j)
} yield (i,j)

// translates to

(1 until n) flatMap (i =>
  (1 until i).withFilter(j => isPrime(i+j))
    .map(j => (i,j)))

// example 2

for (b <- books; a <- b.authors if a startsWith "Bird") yield b.title

// translates to

books.flatMap (b =>
  b.authors.withFilter(a => a startsWith "Bird")
    .map(c => b.title))

// for expression syntax can be used on any type with map, flatMap, filter

// Maps (iterables and functions)

val romanNumerals = Map("I" -> 1, "V" -> 5, "X" -> 10)
val capitals = Map("US" -> "Washington", "Switzerland" -> "Bern")

capitals("US")          // => "Washington
capitals("Andorra")     // => NoSuchElementException!
capitals get "Andorra"  // => Option[String] = None
capitals get "US"       // => Option[String] = Some("Washington")

// option values

trait Option[+A]
case class Some[+A](value: A) extends Option[A]
object None extends Option[Nothing]

def showCapital(country: String) = capitals.get(country) match {
  case Some(capital) => capital
  case None          => "missing!"
}

// ordering

val fruit = List("apple", "pear", "orange", "pineapple")
fruit sortWith (_.length < _.length)
fruit.sorted
fruit groupBy (_.head)

// Maps as total functions

val cap1 = capitals withDefaultValue "<unknown>" 
cap1("Andorra")       // => <unknown>

// polynomial ops

class Poly(val terms0: Map[Int, Double]) {
  def this(bindings: (Int, Double)*) = this(bindings.toMap)
  val terms = terms0 withDefaultValue 0.0

  def + (other: Poly) =
    new Poly((other.terms foldLeft terms)(addTerm))

  def addTerm(terms: Map[Int, Double], term: (Int, Double)) = {
    val (exp, coeff) = term
    terms + (exp -> (coeff + terms(exp)))
  }

  // def + (other: Poly) = new Poly(terms ++ (other.terms map adjust))

  // def adjust(term: (Int, Double)): (Int, Double) = {
  //   val (exp, coeff) = term
  //   (exp, coeff + terms(exp))
  // }

  override def toString = 
    (for ((exp, coeff) <- terms.toList.sorted.reverse) yield coeff+"x^"+exp) mkString " + "
}


val p1 = new Poly(1 -> 2.0, 3 -> 4.0, 5 -> 6.2)
val p2 = new Poly(0 -> 3.0, 3 -> 7.0)
p1 + p2

// phone mnemonics

import scala.io.Source

val in = Source.fromURL("http://lamp.epfl.ch/files/content/sites/lamp/files/teaching/progfun/linuxwords.txt")
val words = in.getLines.toList filter (word => word forall (chr => chr.isLetter))

val mnem = Map('2' -> "ABC", '3' -> "DEF", '4' -> "GHI", '5' -> "JKL", '6' -> "MNO", 
               '7' -> "PQRS", '8' -> "TUV", '9' -> "WXYZ")

val charCode: Map[Char, Char] = 
  for ((num, chars) <- mnem; c <- chars) yield (c -> num)

def wordCode(word: String): String = 
  word.toUpperCase map charCode

val wordsForNum: Map[String, Seq[String]] = 
  (words.toList groupBy wordCode) withDefaultValue Seq()

def encode(number: String): Set[List[String]] = {
  if (number.isEmpty) Set(List())
  else {
    for {
      split <- (1 to number.length)
      (first, rest) = number.splitAt(split)
      word   <- wordsForNum(first)
      others <- encode(rest)
    } yield word :: others
  }.toSet
}
