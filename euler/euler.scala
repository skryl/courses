// Problem 1: Multiples of 3 and 5
// Ans: 233168
//
def multiples_3_and_5 =
  (for (x <- (1 until 1000) if x % 3 == 0 || x % 5 == 0) yield x).sum

// Problem 2: Even Fibonacci Numbers
// Ans: 4613732
//
def even_fib:Int= {
  var cache:Map[Int, Int] = Map()

  def fib(n:Int):Int= {
    if (n == 1 || n == 2) n else cache get n match {
      case Some(f) => f
      case None    => {
        val f = fib(n - 1) + fib(n - 2)
        cache = cache + (n -> f)
        return f
      }
    }
  }

  (for { 
    x <- (1 to 32)
    val f = fib(x)
    if f % 2 == 0
  } yield f).sum
}
  
// Problem 3: Largest Prime Factor of 600851475143
// Ans: 6857
//
import math._

def factor(n:BigInt):List[BigInt] = {
  def sqrt(number : BigInt) = {
      def next(n : BigInt, i : BigInt) : BigInt = (n + i/n) >> 1

      val one = BigInt(1)

      var n = one
      var n1 = next(n, number)
      
      while ((n1 - n).abs > one) {
        n = n1
        n1 = next(n, number)
      }
       
      while (n1 * n1 > number) {
        n1 -= one
      }
      n1
    }

  def isPrime(n:BigInt):Boolean = (2 to sqrt(n).toInt) forall (n % _ > 0)

  if (isPrime(n)) List(n) else {
    val f = (2 to sqrt(n).toInt).find(f => isPrime(f) && (n % f == 0)).get
    val rest = factor(n / f)
    f :: rest
  }
}

// Problem 4: Largest Palindrome Made from Prod of 2 3-digit Numbers
// Ans: 906609
//

def palindrome = 
  (for {
    x <- (100 to 999)
    y <- (100 to 999)
    val prod = (x * y)
    val str = prod.toString
    if str == str.reverse
  } yield (prod)).max

  
// Problem 5: Smallest integer divisible by all numbers from 1 to 20
// Ans: 232792560
//
def smallest_div_20 = {
  def div_20(n:Int):Boolean = (2 to 20) forall (n % _ == 0)
  def find_num(n:Int):Int = if (div_20(n)) n else find_num(n + 1)
  find_num(1)
}

// Problem 6: Sum of Squares - Square of Sum
// Ans: 25164150
//
def square_sum(n:Int):Int = {
  val square_sum = pow((1 to n).sum,2).toInt
  val sum_squares = (1 to n).map(x => x*x).sum
  square_sum - sum_squares
}

// Problem 7: 10_001 prime
// Ans: 104743
//


def prime_10_001:Int = {

  def isPrime(n:Int):Boolean = (2 to sqrt(n).toInt) forall (n % _ > 0)

  def next_prime(n:Int):Int = {
    val next = n + 1
    if (isPrime(next)) next else next_prime(next)  
  }

  def find_primes(primes:List[Int]):List[Int] = {
    if (primes.size == 10001) primes else 
      find_primes(next_prime(primes.head) :: primes)
  }

  find_primes(List(2)).head
}

// Problem 8: Largest Product of 5 consecutive digits
// Ans: 40824
//

val digits = """
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
""".trim.replaceAll("\n","")

def largest_sum_5 = {
  (digits.sliding(5) map (nums => (nums map (_.toString.toInt)).product)).max
}

// Problem 9: Pythagorean Triplet equal to 1000
// Ans: 200 * 375 * 425 = 31875000
//
def triplet(sum:Int):List[(Int,Int,Int)] =
  (for {
    a <- (1 to sum)
    b <- (1 to (sum - a))
    c <- (1 to (sum - a - b))
    if (a*a + b*b == c*c) && 
       (a + b + c == sum) &&
       (a < b && b < c)
  } yield (a,b,c)).toList

// Problem 10: Sum of all primes < 2 million
// Ans: 142913828922
//
def sum_primes_million:Int = {

  def isPrime(n:Int):Boolean = (2 to sqrt(n).toInt) forall (n % _ > 0)

  def next_prime(n:Int):Int = {
    val next = n + 1
    if (isPrime(next)) next else next_prime(next)  
  }

  def find_primes(primes:List[Int]):List[Int] = {
    val next = next_prime(primes.head)
    if (next > 2000000) primes else find_primes(next :: primes)
  }

  find_primes(List(2)).sum
}

// Problem 11: Largest Product in a Grid
// Ans: 70600674
//
val rows = """
08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48
""".trim.split("\n") map (_.split(' ') map (_.toInt))

def largest_product:Int = {

  def yflip(grid: Array[Array[Int]]): Array[Array[Int]] =
    (grid map (_.reverse))

  def xflip(grid: Array[Array[Int]]): Array[Array[Int]] =
    ((grid transpose) map (_.reverse)) transpose

  def xyflip(grid: Array[Array[Int]]): Array[Array[Int]] = 
    xflip(yflip(grid))

  val diag_coords = (0 until 20).map (x => (0 to x).map (y => (x-y,y)))

  def diags(grid: Array[Array[Int]]): Array[Array[Int]] = 
    (diag_coords map (d => (d map (c => grid(c._2)(c._1))).toArray)).toArray

  val columns = rows.transpose
  val left_diags = (diags(rows).take(19) ++ diags(xyflip(rows)))
  val right_diags = (diags(yflip(rows)).take(19) ++ diags(xflip(rows))) 

  (List(rows, columns, left_diags, right_diags) map 
    (rot => (rot map (r => (r.sliding(4) map (_.product)).max)).max)).max
}


// Problem 12: First Triangle Number with 500 divisors
// Ans: 76576500
//
import math._

def triangle_num = {
  var cache:Map[Int, Int] = Map()

  def tnum(n:Int):Int = {
    if (n == 1) n else cache get n match {
      case Some(f) => f
      case None    => {
        val t = n + tnum(n - 1)
        cache = cache + (n -> t)
        return t
      }
    }
  }

  def isPrime(n:Int):Boolean = (2 to sqrt(n).toInt) forall (n % _ > 0)
  
  def factor(n:Int):List[Int] = {
    if (isPrime(n)) List(n) else {
      val f = (2 to sqrt(n).toInt).find(f => isPrime(f) && (n % f == 0)).get
      val rest = factor(n / f)
      (f :: rest).sorted
    }
  }

  def numDivs(n:Int):Int = ((factor(n).groupBy (x => x)).values map (_.size + 1)).product

  def find_tnum(n:Int):Int = {
    val tn = tnum(n)
    if (numDivs(tn) > 500) tn else find_tnum(n + 1)
  }

  find_tnum(1)
}

// Problem 13: 























