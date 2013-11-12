// functions are objects of speciall classes

package scala
trait Function1[A,B] {
  def apply(x: A): B
}


// anonymous function objects
//
(x: Int) => x * x


// equivalent OO definition
//
 
class AnonFun extends Function1[Int, Int] {
  def apply(x: Int) = x * x
  new AnonFun
}

// anonymous class syntax
//
new Function[Int, Int] {
  def apply(x: Int) = x * x
}

// function calls
//
val f = (x: Int) => x * x
f(7)

// translation
//
val f = new Function1[Int, Int] {
  def apply(x: Int) = x * x
}

f.apply(7)

// methods (anything defined by def) is not a function value
// but is converted to one when used in place of a function
//
def f(x: Int): Boolean = ...

(x: Int) => f(x)

// object as a function
//

object List {
  def apply[T](x1: T, x2: T): List[T] = new Cons(x1, new Cons(x2, new Nil))
  def apply[T]() = new Nil
}

// primitives as classes
//
package idealized.scala
abstract class Boolean {
  def ifThenElse[T](t: => T, e: => T): T

  def && (x: => Boolean): Boolean = ifThenElse(x, false)
  def || (x: => Boolean): Boolean = ifThenElse(true, x)
  def unary_!: Boolean            = ifThenElse(false, true)

  def == (x: Boolean): Boolean    = ifThenElse(x, x.unary_!)
  def != (x: Boolean): Boolean    = ifThenElse(x.unary_!, x)
  def <  (x: Boolean): Boolean    = ifThenElse(false, x)
}

object true extends Boolean {
  def ifThenElse[T](t: => T, e: => T) = t
}

object false extends Boolean {
  def ifThenElse[T](t: => T, e: => T) = e
}

// can primitive types be built from nothing? Yes, Peano numbers!
//

abstract class Nat {
  def isZero: Boolean
  def predecessor: Nat
  def successor: Nat
  def + (that: Nat): Nat
  def - (that: Nat): Nat
}

object Zero extends Nat {
  def isZero = true
  def predecessor = throw new Error("0.prdecessor")
  def successor = new Succ(this) 
  def + (that: Nat) = that
  def - (that: Nat) = if (that.isZero) this else throw new Error("negative number")
}

class Succ(n: Nat) extends Nat {
  def isZero = false
  def predecessor = n
  def successor = new Succ(this)
  def + (that: Nat) = new Succ(n + that)
  def - (that: Nat) = if (that.isZero) this else (n - that.predecessor) 
}

// subtyping and generics
//

// subtypes
def assertAllPos[S <: IntSet](r: S): S = ...

// supertypes
[S >: NonEmpty]

// both
[S >: NonEmpty <: IntSet]

// covariant types cause issues if they are mutable, they are not supported in Scala, 
// generics can be used instead 
//
NonEmpty <: IntSet
List[NonEmpty] <: List[IntSet]

// Illustrating issue with Java's covariance. For this reason, Java must also hold 
// on to type information during runtime.
//
NonEmpty[] a = new NonEmpty[]{new NonEmpty(1, Empty, Empty)}
IntSet[] b = a
b[0] = Empty      // <= runtime error
NonEmpty s = a[o]

// Declaring type variance in Scala
//
class [+A] {}  // covariant
class [-A] {}  // contravariant
class [A] {}   // nonvariant

// Functions are contravariant in their argument types and covariant in their result type.
//
package scala
trait Function1[-T, +U] {
  def apply(x: T): U
}


// Back to lists
//

trait List[+T] {
  def isEmpty: Boolean
  def head: T
  def tail: List[T]
  def prepend [U >: T] (elem: U): List[U] = new Cons(elem, this)
}

class Cons[T](val head: T, val tail: List[T]) extends List[T] {
  def isEmpty = false
}

object Nil extends List[Nothing] {
  def isEmpty = true
  def head: Nothing = throw new NoSuchElementException("Nil.head")
  def tail: Nothing = throw new NoSuchElementException("Nil.head") 
}

object test {
  val x: List[String] = Nil
  def f(xs: List[NonEmpty], x: Empty) = xs prepend x
}

// Decomposition
//

// As we add subclasses, the number of methods grows exponentially.
//

trait Expr {
  def isNumber: Boolean
  def isSum: Boolean
  def numValue: Int
  def leftOp: Expr
  def rightOp: Expr
}

class Number(n: Int) extends Expr {
  def isNumber: Boolean = true
  def isSum: Boolean = false
  def numValue: Int = n
  def leftOp: Expr = throw new Error("Number.leftOp")
  def rightOp: Expr = throw new Error("Number.rightOp")
}

class Sum(e1: Expr, e2: Expr) extends Expr {
  def isNumber: Boolean = false
  def isSum: Boolean = true
  def numValue: Int = throw new Error("Sum.numValue") 
  def leftOp: Expr = e1
  def rightOp: Expr = e2
}

class Prod(e1: Expr, e2: Expr) extends Expr
class Var(x: string) extends Expr

def eval(e: Expr): Int = {
  if (e.isNumber) e.numValue
  else if (e.isSum) eval(e.leftOp) + eval(e.rightOp)
  else throw new Error("Unknown expression " + e)
}

// Is this better? What if we need to add a method such as 'show'?
// Every class must be touched and have it's own implementation. 
// What if a method needs more than a single subtree? Such as simplify?
// OO Decomposition won't work well for that.

trait Expr {
  def eval: Int
}

class Number(n: Int) extends Expr {
  def eval: Int = n
}

class Sum(e1: Expr, e2: Expr) extends Expr {
  def eval: Int = e1.eval + e2.eval
}

// Pattern Matching and Case Classes
//

trait Expr
case class Number(n: Int) extends Expr
case class Sum(e1: Expr, e2: Expr) extends Expr

// the case keyword implicityly defines companion objects used to 
// construct objects of the given class 

object Number {
  def apply(n: Int) = new Number(n)
}

object Sum {
  def apply(e1: Expr, e2: Expr) = new Sum(e1, e2)
}

// pattern matching

def eval(e: Expr): Int = e match {
  case Number(n) => n
  case Sum(e1, e2) => eval(e1) + eval(e2)
}

def show(e: Expr): String = e match {
  case Number(n) => n.toString
  case Sum(e1, e2) => "(" + show(e1) + " + " + show(e2) + ")"
}

// is OO or case matching decomposition preferable? It depends on 
// what's added more often, subclasses or methods.

// Lists, immutable, linked (not contiguous)
//

val fruit = List("apples", "oranges", "pears")
val nums  = List(1,2,3,4)
val empty = List()

// cons

val fruit = "apple" :: ("oranges" :: ("pears" :: Nil))

// all : ops associate to the right and take right hand operands

val nums = 1 :: 2 :: 3 :: 4 :: Nil

// equivalent to

Nil.::(4).::(3).::(2).::(1)

if (true) println("Alex")

// insertion sort
//

def isort(xs: List[Int]): List[Int] = xs match {
  case List() => List()
  case y :: ys => insert(y, isort(ys))
}

def insert(x: Int, xs: List[Int]): List[Int] = xs match {
  case List()  => List(x)
  case y :: ys => if (x <= y) x :: xs else y :: insert(x, ys)
}
