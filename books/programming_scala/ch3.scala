// method invocation

List(1,2,3).size
List(1,2,3) size
List(1,2,3).size() // => ERROR
"hello".length()
"hello".length

def isEven(n: Int) = (n % 2) == 0
List(1,2,3,4) filter isEven foreach println

// left associative methods

val list = List('b', 'c', 'd')
'a' :: list
list.::('a')
'a' :: list ++ List('e', 'f')

// DSLs

"nerd finder" should {
  "identify nerds from a list" in {
    val actors = List("Bob", "John", "Klark")
    val finder = new NerdFinder(actors)
    finder.findNerds mustEqual List("John")
  }
}

// conditionals

if (2 + 2 == 5) {
  println("Hello from 1984.")
} else if (2 + 2 == 3) {
  println("Hello from Remedial Math class?")
} else {
  println("Hello from a non-Orwellian future.")
}

// conditionals are expressions

val isTrue = if (2 + 2 == 5) false else true
println(isTrue)

val something = if (2 + 2 == 4) 10

// for comprehensions

val breeds = List("Doberman", "Yorkshire Terrier", "Dachsund", "Scottish Terrier")

for (breed <- breeds) 
  println(breed)

for (breed <- breeds
      if breed.contains("Terrier")) 
  println(breed)

for (breed <- breeds
      if breed.contains("Terrier"); 
      if !breed.startsWith("Yorkshire")) 
  println(breed)

// no semicolons with curly braces

val filteredBreeds = for {
      breed <- breeds
      if breed.contains("Terrier") 
      if !breed.startsWith("Yorkshire")
} yield breed

for {
  breed <- breeds
  upcaseBreed = breed.toUpperCase()
} println(upcaseBreed)

// looping constructs

import java.util.Calendar

def isFridayThirteen(cal: Calendar): Boolean = {
  cal.get(Calendar.DAY_OF_WEEK) == Calendar.FRIDAY && cal.get(Calendar.DAY_OF_MONTH) == 13
}

while(!isFridayThirteen(Calendar.getInstance())) {
  println("Today isn't Friday the 13th. Lame.")
}

// do while

var count = 0

do {
  count += 1
  println(count)
} while (count < 10)

// generators

for (i <- 1 to 10) println(i)

// patern matching

val bools = List(true, false)

for (bool <- bools) {
  bool match {
    case true  => println("heads")
    case false => println("tails")
    case _     => println("well thats rare!")
  }
}

// types

val sundries = List(23, "Hello", 8.5, 'q')

for (sundry <- sundries) {
  sundry match {
    case i: Int    => println("Int")
    case s: String => println("String")
    case f: Double => println("Double")
    case other     => println("something else")
  }
}

// sequences

for (l <- List(List(1,3,5,7), List(2,4,6,8), List())) {
  l match {
    case List(_, 3, _, _) => println("second element is 3")
    case List(_*)         => println("any other list")
  }
}

def processList(l: List[Any]): Unit = l match {
  case head :: tail =>
    println(format("%s ", head))
    processList(tail)
  case Nil => println("")
}

for (l <- List(List(1,3,5,7), List(2,4,6,8), List())) {
  print("List: ")
  processList(l)
}

// tuples (and guards)

val tupA = ("Good", "Morning!")
val tupB = ("Guten", "Tag!")

for (tup <- List(tupA, tupB)) {
  tup match {
    case (thingOne, thingTwo) if thingOne == "Good" =>
      println("A two-tuple starting with 'Good'")
    case (thingOne, thingTwo) =>
      println("This has two things: " + thingOne + " and " + thingTwo)
  }
}

// case classes

case class Person(name: String, age: Int)

val alice = new Person("Alice", 25)
val bob = new Person("Bob", 32)
val charlie = new Person("Charlie", 30)

for (person <- List(alice, bob, charlie)) {
  person match {
    case Person("Alice", 25) => println("Hi Alice!")
    case Person("Bob", 32) => println("Hi Bob!")
    case Person(name, age) =>
      println("Who are you, " + age + " year-old person named " + name + "?")
  }
}

// regexes

val BookExtractorRE = """Book: title=([^,]+),\s+authors=(.+)""".r
val MagazineExtractorRE = """Magazine: title=([^,]+),\s+issue=(.+)""".r

val catalog = List(
  "Book: title=Programming Scala, authors=Dean Wampler, Alex Payne", "Magazine: title=The New Yorker, issue=January 2009",
  "Book: title=War and Peace, authors=Leo Tolstoy",
  "Magazine: title=The Atlantic, issue=February 2009",
  "BadData: text=Who put this here??"
)

for (item <- catalog) { item match {
  case BookExtractorRE(title, authors) =>
    println("Book \"" + title + "\", written by " + authors)
  case MagazineExtractorRE(title, issue) => println("Magazine \"" + title + "\", issue " + issue)
  case entry => println("Unrecognized entry: " + entry) }
}

// binding variables

class Role
case object Manager extends Role
case object Developer extends Role

case class Person(name: String, age: Int, role: Role)

val alice = new Person("Alice", 25, Developer)
val bob = new Person("Bob", 32, Manager)
val charlie = new Person("Charlie", 32, Developer)

for (item <- Map(1 -> alice, 2 -> bob, 3 -> charlie)) {
  item match {
    case (id, p @ Person(_, _, Manager)) => println(format ("%s is overpaid.\n", p))
    case (id, p @ Person(_, _, _)) => println(format ("%s is underpaid.\n", p))
  }
}

for (item <- Map(1 -> alice, 2 -> bob, 3 -> charlie)) {
  item match {
    case (id, p: Person) => p.role match {
      case Manager => println(format("%s is overpaid.\n", p))
      case _ => println(format("%s is underpaid.\n", p))
    }
  }
}

// try, catch and finally

import java.util.Calendar

val later = null
val now = Calendar.getInstance()

try {
  now.compareTo(later)
} catch {
  case e: NullPointerException => println("One was null!")
  case unknown => println("Unknown exception " + unknown)
} finally {
  println("It all worked out.")
}
