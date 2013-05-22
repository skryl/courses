// random numbers

import java.util.Random
val rand = new Random
rand.nextInt

// random values

trait Generator[+T] {
  def generate: T
}

val integers = new Generator[Int] {
  def generate = scala.util.Random.nextInt()
}

val booleans = new Generator[Boolean] {
  def generate = integers.generate >= 0
}

val pairs = new Generator[(Int, Int)] {
  def generate = (integers.generate, integers.generate)
}

// why not for comp? need map and flatMap

trait Generator[+T] {
  self => // an alias for 'this'

  def generate: T

  def flatMap[S](f: T => Generator[S]): Generator[S] = new Generator[S]{
    def generate = f(self.generate).generate
  }

  def map[S](f: T => S): Generator[S] = new Generator[S]{
    def generate = f(self.generate)
  }
}

implicit def integers: Generator[Int] = new Generator[Int] {
  def generate = scala.util.Random.nextInt()
}

implicit def choose(lo: Int, hi: Int): Generator[Int] = new Generator[Int] {
  def generate = scala.util.Random.nextInt(hi - lo) + lo
}

implicit def single[T](x: T): Generator[T] = new Generator[T] {
  def generate = x
}

implicit def booleans: Generator[Boolean] = integers.map(_ >= 0)

implicit def pairs[T, U](implicit t: Generator[T], u: Generator[U]): Generator[(T,U)] = 
  for {
    x <- t
    y <- u
  } yield (x,y)

// random testing

def test[T](g: Generator[T], numTimes: Int = 100)(test: T => Boolean): Unit = {
  for (i <- 0 until numTimes) {
    val value = g.generate
    assert(test(value), "test failed for " + value)
  }
  println("passed " + numTimes + " tests ")
}

test(lists[Int]) {(xs: List[Int]) =>
  xs.reverse == xs
}

// async processing and futures







