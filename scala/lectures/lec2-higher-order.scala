// specific function
//
def sumInts(a: Int, b: Int): Int = 
  if (a > b) 0 else a + sumInts(a + 1, b)

// generic higher order function
//

def id(x: Int): Int = x
def cube(x: Int): Int = x * x * x
def fact(x: Int): Int = if (x == 0) 1 else x * fact(x - 1)

def sum_f(f: Int => Int, a: Int, b: Int): Int = 
  if (a > b) 0 else f(a) + sum_f(f, a + 1, b)

// function literals (anonymous functions)
//
(x: Int) => x * x * x
sum_f(x => x * x, 1, 5)

// tail recursive sum
//
def sum_t(f: Int => Int, a: Int, b: Int): Int = {
  def loop(acc: Int, a: Int): Int = {
    if (a > b) acc 
    else loop(acc + f(a), a + 1) 
  }
  loop(0, a)
}

// currying
//
def sum_c(f: Int => Int): (Int, Int) => Int = {
  def sumF(a: Int, b: Int): Int = 
    if (a > b) 0 else f(a) + sumF(a + 1, b)
  sumF
}

sum (cube) (1,10) // => 3025

// special syntax for functions that return functions
//
def sum(f: Int => Int)(a: Int, b: Int): Int = 
  if (a > b) 0 else f(a) + sum(f)(a + 1, b)


def product(f: Int => Int)(a: Int, b: Int): Int =
  if (a > b) 1 else f(a) * product(f)(a + 1, b)

def fact_p(n: Int): Int = product(id)(1, n)

// generic function which supports any mult, add, etc
//
def mapReduce(f: Int => Int, combine: (Int, Int) => Int, zero: Int)(a: Int, b: Int): Int =
  if (a > b) zero else combine(f(a), mapReduce(f, combine, zero)(a + 1, b))

// finding fixed points
//
import math.abs

object exercise {
  val tolerance = 0.0001
  def isCloseENough(x: Double, y: Double) =
    abs((x - y) / x) / x < tolerance
  def fixedPoint(f: Double => Double)(firstGuess: Double) = {
    def iterate(guess: Double): Double = {
      val next = f(guess)
      if (isCloseENough(guess, next)) next
      else iterate(next)
    }
    iterate(firstGuess)
  }
}

import exercise._

// def sqrt(x: Double) = fixedPoint(y => x / y)(1.0) // => infinte loop (does not converge, see graph)
def sqrt(x: Double) = fixedPoint(y => (y + x/y) / 2)(1.0)

def averageDamp(f: Double => Double)(x: Double) = (x + f(x)) / 2

def sqrt_d(x: Double) = fixedPoint(averageDamp(y => x / y))(1.0)

// data structures
//

class Rational(x: Int, y: Int) {
  require( y > 0, "denominator must be positive" )

  def this(x: Int) = this(x, 1)

  private def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)
  private val g = gcd(x, y)
  def numer = x / g
  def denom = y / g

  def unary_- : Rational = new Rational(-numer, denom)

  def +(that: Rational) =
    new Rational(
      numer * that.denom + that.numer * denom,
      denom * that.denom)

  def -(that: Rational) = this + -that

  def mul(that: Rational) = 
    new Rational(numer * that.numer, denom * that.denom)

  def < (that: Rational) = numer * that.denom < that.numer * denom

  def max(that: Rational) = if (this < that) that else this

  override def toString = numer + "/" + denom
}

// all single parameter methods can be used as infix operators
//
val r = new Rational(1,2)
val x = new Rational(1,3)
r add x
