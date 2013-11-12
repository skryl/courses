// Case Classes Review
//

// Json example

{ 
  "firstName": "John",
  "lastName": "Smith",
  "address": {
    "street": "21 Jump Street"
    "state": "NY"
    "postalCode": 10021
  },
  "phoneNumbers": [
    {"type": "home", "number": "212 444-1234"}
    {"type": "work", "number": "212 555-1234"}
  ]
}

abstract class JSON
case class JSeq (elems: List[JSON])           extends JSON
case class JObj (bindings: Map[String, JSON]) extends JSON
case class JNum (num: Double)                 extends JSON
case class JStr (str: String)                 extends JSON
case class JBool(b: Boolean)                  extends JSON
case object JNull                             extends JSON

val data = JObj(Map(
  "firstName" -> JStr("John"),
  "lastName"  -> JStr("Smith"),
  "address"   -> JObj(Map(
    "street" -> JStr("21 Jump Street"),
    "state"  -> JStr("NY"),
    "postalCode" -> JNum(10021) 
  )),
  "phoneNumbers" -> JSeq(List(
    JObj(Map("type" -> JStr("home"), "number" -> JStr("212 444-1234"))),
    JObj(Map("type" -> JStr("work"), "number" -> JStr("212 555-1234")))
  )) ))

def show(json: JSON): String = json match {
  case JSeq(elems) => "[" + (elems map show mkString ",") + "]"
  case JObj(bindings) =>
    val assocs = bindings map {
      case (key,value) => "\"" + key + "\": " + show(value) }
    "{" + (assocs mkString ",") + "}"
  case JNum(num) => num.toString
  case JStr(str) => '\"' + str + '\"'
  case JBool(b)  => b.toString
  case JNull     => "null"
}

// what type is this expression?
{ case (key, value) => key + ": " + value }

// functions in Scala are traits
//
trait Function1[-A, +R] {
  def apply(x: A): R
}

// so the above pattern match block expands to
//
new Function1[JBinding, String] {
  def apply(x: JBinding) = x match {
    case (key, value) => key + ": " + show(value)
  }
}

// one nice aspect of functions as Traits is that they can be subclassed
//
trait Map[Key, Value] extends (Key => Value)

// sequences are functions from Int indices to values
//
trait Seq[Elem] extends (Int => Elem)

// thats why we can write
//
elems(i) 


{ case "ping" => "pong" }  // won't type check

val f: String => String = { case "ping" => "pong" }

f("ping")
f("abc") // match error

// can we check if an arg is applicable?
//

val f: PartialFunction[String, String] = { case "ping" => "pong" }

f.isDefinedAt("abc")
f.isDefinedAt("ping")

trait PartialFunction[-A, +R] extends Function1[-A, +R] {
  def apply(x: A): R
  def isDefinedAt(x: A): Boolean
}

// expansion to PartialFunction works differently

new PartialFunction[String, String] {
  def apply(x: String) = x match {
    case "ping" => "pong"
  }
  def isDefinedAt(x: String) = x match {
    case "ping" => true
    _ => false
  }
}

// Collections Review

// all share a common set of general methods
// - map
// - flatMap
// - filter
// - foldLeft
// - foldRight
// ...

abstract class List[+T] {
  def map[U](f: T => U): List[U] = this match {
    case x :: xs => f(x) :: xs.map(f)
    case Nil => Nil
  }

  def flatMap[U](f: T => List[U]): List[U] = this match {
    case x :: xs => f(x) ++ xs.map(f)
    case Nil => Nil
  }

  def filter(f: T => Boolean): List[T] = this match {
    case x :: xs => 
      if (p(x)) x :: xs.filter(p) else xs.filter(p)
    case Nil => Nil
  }
}

// For Expressions Review

// can use pattern matching in for expressions
//
val data: List[JSON] =
  for {
    JObj(bindings) <- data
    JSeq(phones) = bindings("phoneNumbers")
    ...
  } yield ...


// for expressions only require a map, flatMap, withFilter for the type
//

trait Generator[+T] { def generate: T }

val integers = new Generator[Int] {
  val rand = new java.util.Random
  def tenerate = rand.nextInt()
}

val booleans = new Generator[Boolean] {
  def generate = integers.generate > 0
}

val pairs = new Generator[(Int, Int)] {
  def generate = (integers.generate, integers.generate)
}

// cumbersome, we keep needing anonymous classes

val booleans = for (x <- integers) yield x > 0

// expanded to

integers map (x => x> 0)

def pairs[T,U](t: Generator[T], u: Generator[U]) = for {
  x <- t
  y <- u
} yield (x, y)

// expands to

t flatMap (x => u map (y => (x, y)))

trait Generator[+T] {
  self => // an alias for "this"

  def generate: T

  def map[S](f: T => S): Generator[S] = new Generator[S] {
    def generate = f(self.generate)
  }

  def flatMap[S](f: T => Generator[S]): Generator[S] = new Generator[S] {
    def generate = f(self.generate).generate
  }

}

// Monads - data structures that map and flatMap
//

trait M[T] {
  def flatMap[U](f: T => M[U]): M[U]
}

def unit[T](x: T): M[T]


