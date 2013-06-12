:load bench.scala
import java.util.Random
import Bench._
import Math._

// Merge Sort
//
def merge(l1: List[Int], l2: List[Int]): List[Int] = (l1, l2) match {
  case (xs, Nil )    => xs
  case (Nil, ys)     => ys
  case (x :: xs, y :: ys) => if (x < y) x :: merge(xs, l2) else y :: merge(l1, ys)
}

def sort(l: List[Int]): List[Int] = l match {
  case x :: Nil => l
  case x :: xs  => {
    val (left, right) = l.splitAt(l.length / 2)
    merge(sort(left), sort(right))
  }
}

// Count List Inversions
//
// piggyback on merge sort to get n(logN) complexity
//
def mergeAndCount(l1: List[Int], l2: List[Int], count: Int): (List[Int], Int) = (l1, l2) match {
  case (xs, Nil )    => (xs, count)
  case (Nil, ys)     => (ys, count)
  case (x :: xs, y :: ys) => {
    if (x < y) { 
      val (m, c) = mergeAndCount(xs, l2, count) 
      (x :: m, c)
    }
    else { 
      val (m, c) = mergeAndCount(l1, ys, count + l1.size)
      (y :: m, c)
    }
  }
}

def count(l: List[Int]): (List[Int], Int) = l match {
  case x :: Nil => (l, 0)
  case x :: xs  => {
    val (left, right) = l.splitAt(l.length / 2)
    val (l_sorted, l_count) = count(left) 
    val (r_sorted, r_count) = count(right)
    mergeAndCount(l_sorted, r_sorted, l_count + r_count)
  }
}                                    

// 1-d closest points
//
def closest1d(points: List[Int]): List[Int] = {
  sort(points).sliding(2).reduce { (smallest, pair) => 
    if ((pair(1) - pair(0)) < (smallest(1) - smallest(0))) pair else smallest 
  }
}

// 2-d closest points
//

type Point = (Int, Int)

def sqr(x: Int): Int = x * x

def dist(p1: Point, p2: Point): Double = (p1, p2) match {
  case ((x1, y1), (x2, y2)) => sqrt(sqr(x2 - x1) + sqr(y2 - y1))
}

def closestSplit(sorted_x: List[Point], sorted_y: List[Point], delta: Double): Double = {
  def findMin(points: List[Point], delta: Double): Double = points match {
    case Nil      => delta
    case p1 :: ps => findMin(ps, ps.foldLeft(delta) ((delta, p2) => delta min dist(p2, p1)))
  }

  val median_x = sorted_x(sorted_x.length / 2)._1
  val (min_x, max_x) = (median_x - delta, median_x + delta)
  val filtered_y = sorted_y.filter{ case (x,y) => (x >= min_x) && (x <= max_x)  }

  findMin(filtered_y, delta)
}

def closestFast(points: List[Point]): Double = points match {
  case p1 :: p2 :: Nil => 
    dist(p1, p2)
  case p1 :: p2 :: p3 :: Nil => 
    dist(p1, p2) min dist(p1, p3) min dist(p2, p3)
  case _            => {
    val sorted_x = points.sortBy{ case (x, y) => x }
    val sorted_y = points.sortBy{ case (x, y) => y }

    val (left, right) = sorted_x.splitAt(sorted_x.size / 2)
    // println(s"left: ${left}")
    // println(s"right: ${right}")

    val delta_l = closestFast(left)
    val delta_r = closestFast(right)
    // println(s"left: ${delta_l}")
    // println(s"right: ${delta_r}")

    val delta_min = closestSplit(sorted_x, sorted_y, delta_l min delta_r)
    // println(s"min: ${delta_min}")

    delta_min
  }
}

def closestSlow(points: List[Point]): Double = {
  (for {
    p1 <- points
    p2 <- points
    if p1 != p2
  } yield dist(p1,p2)).min
}

def randPoints(maxlen: Int): List[(Int, Int)] = {
  val r = new Random
  val len = r.nextInt(maxlen)

  val points = List.fill(len)((0,0)).map(p => (r.nextInt(len), r.nextInt(len))).distinct
  if (points.length < 2) randPoints(maxlen) else points
}

def test {
  for { i <- 0 to 10000 } {
    val p = randPoints(100)
    println(s"p = ${p}")
    val r = closestSlow(p)
    val t = closestFast(p)

    if (r != t) {
      println(s"p = ${p}")
      println(s"r = ${r}\nt = ${t}")
      error("not equal")
    }
  }
  println("tests: PASS!")
}

def bench {
  val p = randPoints(100)
  println(s"p = ${p}")

  println("time1:")
  time { for (n <- (1 to 10000)) { closestSlow(p) } }
  println("time2:")
  time { for (n <- (1 to 10000)) { closestFast(p) } }
}

test
bench
