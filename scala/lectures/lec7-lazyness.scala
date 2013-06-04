// Streams
//

val xs = Stream.cons(1, Stream.cons(2, Stream.empty))
Stream(1,2,3)
(1 to 1000).toStream

def streamRange(lo: Int, hi: Int): Stream[Int] = { 
  if (lo >= hi) Stream.empty
  else Stream.cons(lo, streamRange(lo + 1, hi))
}

// vs list equivalent

def listRange(lo: Int, hi: Int): List[Int] = {
  if (lo >= hi) Nil
  else lo :: listRange(lo + 1, hi)
}

// list to stream
//
def toStream(l: List[Int]): Stream[Int] = {
  if (l.isEmpty) Stream.empty
  else l.head #:: toStream(l.tail)
}

// ops on lazy collections are also lazy
//
def map[T](s: Stream[Int])(f:Int => T): Stream[T] = {
  if (s.isEmpty) Stream.empty
  else f(s.head) #:: map(s.tail)(f)
}

def filter[T](s: Stream[Int])(f:Int => Boolean): Stream[Int] = {
  if (s.isEmpty) Stream.empty
  else {
    if (f(s.head)) s.head #:: filter(s.tail)(f) else filter(s.tail)(f)
  }
}

// :: operator always produces a List
x #:: xs = Stream.cons(x, xs)

// implementation

trait Stream[+A] extends Seq[A] {
  def isEmpty: Boolean
  def head: A
  def tail = tl
}

// cons tl parameter is a 'by name' parameter
//
object Stream {

  def cons[T](hd: T, tl: => Stream[T]) = new Stream[T] {
    def isEmpty = false
    def head = hd
    def tail = tl
  }

  val empty = new Stream[Nothing] {
    def isEmpty = true
    def head = throw new NoSuchElementException("empty.head")
    def tail = throw new NoSuchElementException("empty.tail")
  }

}

// lazy evaluation

// value is recomputed on subsequent calls
//
def x = 1 + 2

// value is reused on subsequent calls
//
lazy val x = expr

// prints: xzyz
//
def expr = {
  val x = { print("x"); 1 }
  lazy val y = { print("y"); 2 }
  def z = { print("z"); 3 }
  z + y + x + z + y + x
}

// using lazy evaluation we can make Stream.cons more efficient by 
// caching all tail values
//
def cons[T](hd: T, tl: => Stream[T]) = new Stream[T] {
  def head = hd
  lazy val tail = tl
  ...
}

// infinite sequences

def from(n: Int): Stream[Int] = n #:: from(n+1)

// all naturals

val nats = from(0)

val m4s = nats map (_*4)

m4s.take(100).toList

// Sieve of Eratosthenes (calculating primes)

def sieve(s: Stream[Int]): Stream[Int] = 
  s.head #:: sieve(s.tail filter (_ % s.head != 0))

val primes = sieve(from(2))

// back to square roots
//
def sqrtStream(x: Double): Stream[Double] = {
  def improve(guess: Double) = (guess + x / guess) / 2
  lazy val guesses: Stream[Double] = 1 #:: (guesses map improve)
  guesses
}

// the water pouring problem
//

class Pouring(capacity: Vector[Int]) {

  // state

  type State = Vector[Int]
  val initialState = capacity map (x => 0)

  // moves
  
  trait Move {
    def change(state: State): State
  }

  case class Empty(glass: Int) extends Move {
    def change(state: State): State = state updated (glass, 0)
  }

  case class Fill(glass: Int) extends Move {
    def change(state: State): State = state updated (glass, capacity(glass))
  }

  case class Pour(from: Int, to: Int) extends Move {
    def change(state: State): State = {
      val amount = state(from) min (capacity(to) - state(to))
      state updated (from, state(from) - amount) updated (to, state(to) + amount)  
    }
  }

  val glasses = 0 until capacity.length

  val moves = 
    (for (g <- glasses) yield Empty(g)) ++
    (for (g <- glasses) yield Fill(g)) ++
    (for (from <- glasses; to <- glasses if from != to) yield Pour(from,to))

  // paths
  
  class Path(history: List[Move], val endState: State) {
    def extend(move: Move) = new Path(move :: history, move change endState)
    override def toString = (history.reverse mkString " ") + "--> " + endState
  }

  val initialPath = new Path(Nil, initialState)

  def from(paths: Set[Path], explored: Set[State]): Stream[Set[Path]] = {
    if (paths.isEmpty) Stream.empty
    else {
      val more = for {
        path <- paths
        next <- moves map path.extend
        if !(explored contains next.endState)
      } yield next
      paths #:: from(more, explored ++ (more map (_.endState)))
    }
  }

  val pathSets = from(Set(initialPath), Set(initialState))

  def solution(target: Int): Stream[Path] = {
    for {
      pathSet <- pathSets
      path <- pathSet
      if path.endState contains target
    } yield path
  }

}

val s = List(1,2,3).toStream

object test {
  val problem = new Pouring(Vector(4,9))
  problem.solution(6)
}


