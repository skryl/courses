// Square root using Newton's Method
//
def sqrt(x: Double): Double = {

  def newton(guess: Double): Double = 
    if (isGoodEnough(guess)) guess
    else newton(improve(guess))

  def isGoodEnough(num: Double) = 
    ((num * num) - x).abs / x < 0.01

  def improve(num: Double) = 
    (num + (x/num))/2

  newton(1)
}


// gcd using Euclid's method
//
def gcd(a: Int, b: Int): Int = 
  if (b==0) a else gcd(b, a % b)


// factorial
//
def factorial(n: Int): Int = 
  if (n == 0) 1 else n * factorial(n - 1)


// tail recursive factorial
//
def factorial(n: Int): Int= {
  def loop(acc: Int, n: Int): Int =
    if (n == 0) acc
    else loop(acc * n, n - 1)
  loop(1,n)
}
