package recfun
import common._

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  def p = {
    println("Pascal's Triangle")
    for (row <- 0 to 20) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  /**
   * Exercise 1
   */
  def pascal(c: Int, r: Int): Int = 
    if (r == 0 || c % r == 0) 1 else pascal(c-1,r-1) + pascal(c,r-1)

  /**
   * Exercise 2
   */
  def balance(chars: List[Char]): Boolean = {
    def loop(count: Int, chars: List[Char]): Boolean =
      if (count < 0 || chars.isEmpty && count > 0) false
      else if (chars.isEmpty && count == 0) true
      else if (chars.head == '(') loop(count + 1, chars.tail)
      else if (chars.head == ')') loop(count - 1, chars.tail)
      else loop(count, chars.tail)
    loop(0, chars)
  }

  /**
   * Exercise 3
   */
  def countChange(money: Int, coins: List[Int]): Int = ???
}
