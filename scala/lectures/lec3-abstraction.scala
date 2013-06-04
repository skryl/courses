// Persistent data structures
//

abstract class IntSet {
  def incl(x: Int): IntSet
  def contains(x: Int): Boolean
  def union(other: IntSet): IntSet
}

class NonEmpty(elem: Int, left: IntSet, right: IntSet) extends IntSet {
  def contains(x: Int): Boolean = 
    if (x < elem) left contains x
    else if (x > elem) right contains x
    else true

  def incl(x: Int): IntSet =
    if (x < elem) new NonEmpty(elem, left incl x, right)
    else if (x > elem) new NonEmpty(elem, left, right incl x)
    else this

  def union(other: IntSet): IntSet = 
    ((left union right) union other) incl elem

  override def toString = "{" + left + elem + right + "}"
}

object Empty extends IntSet {
  def contains(x: Int): Boolean = false
  def incl(x: Int): IntSet = new NonEmpty(x, Empty, Empty)
  def union(other: IntSet): IntSet = other

  override def toString = "."
}


val t1 = new NonEmpty(3, Empty, Empty)
val t2 = t1 incl 4

// Packages
//

// import class from package
//
import package.MyClass

// import all from package
//
import package._

// import > 1 class
//
import package.{Class1, Class2}

// auto imported
//
import scala._
import java.lang._
import scala.Predef._

// modules / traits
//

trait Planar {
  def height: Int
  def width: Int
  def surface: Int = height * width
}

// class Square extends Shape with Planar with Movable

// null and implicit conversions
//

val x = null

val y: String = x // => OK

val x: Int = null // => error

if (true) 1 else false // => AnyVal

// Polymorphism
//

// type specific list

trait IntList
class Cons(val head: Int, val tail: IntList) extends IntList
class Nil extends IntList

// general list


trait List[T] {
  def isEmpty: Boolean
  def head: T
  def tail: List[T]
}

class Cons[T](val head: T, val tail: List[T]) extends List[T] {
  def isEmpty = false
}

class Nil[T] extends List[T] {
  def isEmpty = true
  def head: Nothing = throw new NoSuchElementException("Nil.head")
  def tail: Nothing = throw new NoSuchElementException("Nil.head") 
}

// function type params

def singleton[T](elem: T) = new Cons[T](elem, new Nil[T])

singleton[Int](1)
singleton(1) // => inferred type

singleton[Boolean](true)
singleton(true) // => inferred type

def nth[T](n: Int, l: List[T]): T = {
  if (l.isEmpty) throw new IndexOutOfBoundsException
  else if (n == 0) l.head
  else nth(n - 1, l.tail)
}



