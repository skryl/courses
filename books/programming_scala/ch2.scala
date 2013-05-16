// immutable variables
//
val array: Array[String] = new Array(5)
array = new Array      // => Error: reassignment to val
array(0) = "Hello"     // => OK

var stockPrice:Double = 100.0
stockPrice = 10.0      // => OK

// methods
//
object StringUtil {
  def joiner(strings: List[String], separator: String): String =
    strings.mkString(separator)

  def joiner(strings: List[String]): String = joiner(strings, " ")
}

// default args

object StringUtil {
  def joiner(strings: List[String], separator: String = " "): String =
    strings.mkString(separator)
}

import StringUtil._

// named arguments and method invocation

println(joiner(List("Programming", "Scala")))
println(joiner(strings = List("Programming", "Scala")))
println(joiner(List("Programming", "Scala"), ", "))
println(joiner(strings = List("Programming", "Scala"), separator = ", "))
println(joiner(separator = ", ", strings = List("Programming", "Scala")))
println(joiner(strings = List("Programming", "Scala"), ", "))

// nested methods

def factorial(i: Int): Int = {
  def fact(i: Int, acc: Int): Int = {
    if (i <= 1) acc else fact(i - 1, i * acc)
  }

  fact(i, 1)
}

// type inference

import java.util.Map
import java.util.HashMap

val intToStringMap: Map[Integer, String] = new HashMap
val intToStringMap2 = new HashMap[Integer, String]

// wtf?

def double(i: Int) { 2 * i }
println(double(2))

def double(i: Int) = { 2 * i } // need '=' sign

// Floating Point

0.
0.0
3e5

// Char Literals

'a'
'\u0041'
'\n'
'\012'

// String Literals

"Programming\nScala"
"He exclaimed, \"Scala is great!\""
"""
  first line
  second line
  third line
"""

// Symbol Literals

'a
Symbol(" another symbol ")

// Tuples
val t = ("Abc", 1, 2.3)
println(t)
println(t._1)
println(t._2)
println(t._3)

// Option, Some, None

def putsVal(v: Option[Int]): Unit = println(v.getOrElse("Null"))
putsVal(Some(1))
putsVal(None)

// imports

import java.awt._
import java.io.File
import java.io.File._
import java.util.{Map, HashMap}

def writeAboutBigInteger() = {
  import java.math.BigInteger.{
    ONE => _,
    TEN,
    ZERO => JAVAZERO
  }
  println("TEN: " + TEN)
  println("ZERO: " + JAVAZERO)
}

writeAboutBigInteger()

// relative imports

import scala.collection.mutable._
import collection.immutable._
import _root_.scala.collection.jcl._
package scala.actors {
  import remote._
}

// Abstract Types

import java.io._

abstract class BulkReader {
  type In
  val source: In
  def read: String
}

class StringBulkReader(val source: String) extends BulkReader {
  type In = String
  def read = source
}

class FileBulkReader(val source: File) extends BulkReader {
  type In = File
  def read = {
    val in = new BufferedInputStream(new FileInputStream(source))
    val numBytes = in.available()
    val bytes = new Array[Byte](numBytes)
    in.read(bytes, 0, numBytes)
    new String(bytes)
  }
}
