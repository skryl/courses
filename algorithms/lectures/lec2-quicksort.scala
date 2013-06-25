:load bench.scala
import Bench._
import java.util.Random

// Quicksort
//

def partition(pivot: Int, l: List[Int]): (List[Int], List[Int]) = {
  l.foldLeft((List[Int](), List[Int]())) { case ((left, right), v) =>
    if (v <= pivot) (v :: left, right) else (left, v :: right)
  }
}

def quicksort(l: List[Int]): List[Int] = {
  if (l.size <= 1) l
  else {
    val pivot = l(0)
    val (left, right) = partition(pivot, l.tail)
    quicksort(left) ++ (pivot :: quicksort(right))
  }
}

// In-Place Quicksort
//

def partition_fast(a: Array[Int], start: Int, end: Int): Int = {
  def swap(i1: Int, i2: Int) {
    var tmp = a(i1)
    a(i1) = a(i2)
    a(i2) = tmp
  }

  var pvt_idx = start
  val pivot = a(start)
  for ( idx <- (start+1 to end) ) {
    if (a(idx) < pivot) {
      if (idx - pvt_idx > 1) {
        pvt_idx += 1
        swap(idx, pvt_idx)
      } else pvt_idx += 1
    }
  }
  swap(start, pvt_idx)
  pvt_idx
}

def quicksort_fast(a: Array[Int]): Array[Int] = {
  def qs(a: Array[Int], start: Int, end: Int): Array[Int] = {
    if (end - start <= 1) a
    else {
      val pvt_idx = partition_fast(a, start, end)
      qs(a, start, pvt_idx)
      qs(a, pvt_idx+1, end)
    }
  }
  qs(a.clone, 0, a.length-1)
}

// Mergesort
//


def merge(l1: List[Int], l2: List[Int]): List[Int] = {
  def merge_rec(merged: List[Int], l1: List[Int], l2: List[Int]): List[Int] = (l1, l2) match {
    case (xs, Nil )    => merged.reverse ++ xs
    case (Nil, ys)     => merged.reverse ++ ys
    case (x :: xs, y :: ys) => if (x < y) merge_rec(x :: merged, xs, l2) else merge_rec(y :: merged, l1, ys)
  }
  merge_rec(List(), l1, l2)
}

def mergesort(l: List[Int]): List[Int] = l match {
  case x :: Nil => l
  case x :: xs  => {
    val (left, right) = l.splitAt(l.length / 2)
    merge(mergesort(left), mergesort(right))
  }
}

// Comparison
//

def randList(maxlen: Int): List[Int]= {
  val r = new Random
  val len = r.nextInt(maxlen)

  if (len == 0) randList(maxlen)
  else {
    val num = List.fill(len)(0).map(i => r.nextInt(maxlen))
    if (num.length > 0) num else randList(maxlen)
  }
}

def bench(size: Int) {
  val l = randList(size)
  val a = l.toArray

  println("mergesort:")
  time { for (n <- (1 to 1)) { mergesort(l) } }
  println("quicksort:")
  time { for (n <- (1 to 1)) { quicksort(l) } }
  println("quicksort fast:")
  time { for (n <- (1 to 1)) { quicksort_fast(a) } }
  println("scala sort:")
  time { for (n <- (1 to 1)) { l.sorted } }
}

bench(1000000)
