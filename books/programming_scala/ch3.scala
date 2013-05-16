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

