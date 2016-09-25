:load bench.scala
import Bench._
import java.util.Random

// Linear time randomized ith order selection using modified Quicksort
//
def partition_fast(a: Array[Int], start: Int, end: Int, pivot: Int): Int = {
  def swap(i1: Int, i2: Int) {
    val tmp = a(i1)
    a(i1) = a(i2)
    a(i2) = tmp
  }

  swap(start, pivot)
  var pvt_idx = start
  val pvt_val = a(start)
  for ( idx <- (start+1 to end) ) {
    if (a(idx) < pvt_val) {
      if (idx - pvt_idx > 1) {
        pvt_idx += 1
        swap(idx, pvt_idx)
      } else pvt_idx += 1
    }
  }
  swap(start, pvt_idx)
  pvt_idx
}

def select(a: Array[Int], i: Int): Int = {
  val rand = new Random
  def sel(a: Array[Int], start: Int, end: Int, i: Int): Int = {
    if (end - start < 1) {
      println(a.toList.slice(start, end+1))
      a(start)
    }
    else {
      val pivot = start + rand.nextInt(end - start + 1)
      val pvt_idx = partition_fast(a, start, end, pivot)

      println(a.toList.slice(start, end+1))
      println(pvt_idx-start)

      if (pvt_idx == i) a(pvt_idx)
      else if (pvt_idx > i) sel(a, start, pvt_idx-1, i)
      else sel(a, pvt_idx+1, end, i)
    }
  }
  sel(a.clone, 0, a.length-1, i)
}
