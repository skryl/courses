// Integer Multiplication
// Input: 2 n-digit numbers x and y
// Output: x * y
//

def multiply_classic(a: String, b: String): String = {

  def toList(n: String): List[Int] = n.toList.map(_.toString.toInt)

  def mult(a: List[Int], b: List[Int]): List[List[Int]] = 
    for ((bDig, i) <- b.reverse.zipWithIndex) yield {
      val partial = a.foldRight((0, List.fill(i)(0))){ 
        case (aDig, (carry, partial)) => { 
          val r = aDig * bDig + carry
          (r / 10, r % 10 :: partial) 
        }
      }; List.fill(b.length - i)(0) ++ (partial._1 :: partial._2)
    }

  def add(a: List[Int], b: List[Int]): List[Int] = {
    a.zip(b).foldRight((0, List[Int]())){ 
      case ((aDig, bDig), (carry, ans)) => { 
        val r = aDig + bDig + carry
        (r / 10, (r % 10) :: ans) 
      }
    }._2
  }

  mult(toList(a), toList(b)).reduceLeft((a, part) => 
    add(a, part)
  ).dropWhile(_ == 0).mkString
}

// Recursive Multiplication
//
def rec_multiply(a: String, b: String): String = {
  
}

// Karatsuba Multiplication
//

val a = "1234567890123456789012345678901234567890"
val b = "1234567890123456789012345678901234567890"

val a = "123"
val b = "123"

time { for (n <- (1 to 1000)) { multiply_classic(a,b) } }
time { for (n <- (1 to 1000)) { BigInt(a) * BigInt(b) } }

def time[A](a: => A) = {
  val now = System.nanoTime
  val result = a
  val micros = (System.nanoTime - now) / 1000
  println("%d microseconds".format(micros))
  result
}

// Merge Sort (Good intro to Divide and Conquer)
// 
