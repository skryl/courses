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

// Problem 13: Sum 100 50-digit BigInts (first 10 digits)
// Ans: 5537376230...
//
val nums = """
37107287533902102798797998220837590246510135740250
46376937677490009712648124896970078050417018260538
74324986199524741059474233309513058123726617309629
91942213363574161572522430563301811072406154908250
23067588207539346171171980310421047513778063246676
89261670696623633820136378418383684178734361726757
28112879812849979408065481931592621691275889832738
44274228917432520321923589422876796487670272189318
47451445736001306439091167216856844588711603153276
70386486105843025439939619828917593665686757934951
62176457141856560629502157223196586755079324193331
64906352462741904929101432445813822663347944758178
92575867718337217661963751590579239728245598838407
58203565325359399008402633568948830189458628227828
80181199384826282014278194139940567587151170094390
35398664372827112653829987240784473053190104293586
86515506006295864861532075273371959191420517255829
71693888707715466499115593487603532921714970056938
54370070576826684624621495650076471787294438377604
53282654108756828443191190634694037855217779295145
36123272525000296071075082563815656710885258350721
45876576172410976447339110607218265236877223636045
17423706905851860660448207621209813287860733969412
81142660418086830619328460811191061556940512689692
51934325451728388641918047049293215058642563049483
62467221648435076201727918039944693004732956340691
15732444386908125794514089057706229429197107928209
55037687525678773091862540744969844508330393682126
18336384825330154686196124348767681297534375946515
80386287592878490201521685554828717201219257766954
78182833757993103614740356856449095527097864797581
16726320100436897842553539920931837441497806860984
48403098129077791799088218795327364475675590848030
87086987551392711854517078544161852424320693150332
59959406895756536782107074926966537676326235447210
69793950679652694742597709739166693763042633987085
41052684708299085211399427365734116182760315001271
65378607361501080857009149939512557028198746004375
35829035317434717326932123578154982629742552737307
94953759765105305946966067683156574377167401875275
88902802571733229619176668713819931811048770190271
25267680276078003013678680992525463401061632866526
36270218540497705585629946580636237993140746255962
24074486908231174977792365466257246923322810917141
91430288197103288597806669760892938638285025333403
34413065578016127815921815005561868836468420090470
23053081172816430487623791969842487255036638784583
11487696932154902810424020138335124462181441773470
63783299490636259666498587618221225225512486764533
67720186971698544312419572409913959008952310058822
95548255300263520781532296796249481641953868218774
76085327132285723110424803456124867697064507995236
37774242535411291684276865538926205024910326572967
23701913275725675285653248258265463092207058596522
29798860272258331913126375147341994889534765745501
18495701454879288984856827726077713721403798879715
38298203783031473527721580348144513491373226651381
34829543829199918180278916522431027392251122869539
40957953066405232632538044100059654939159879593635
29746152185502371307642255121183693803580388584903
41698116222072977186158236678424689157993532961922
62467957194401269043877107275048102390895523597457
23189706772547915061505504953922979530901129967519
86188088225875314529584099251203829009407770775672
11306739708304724483816533873502340845647058077308
82959174767140363198008187129011875491310547126581
97623331044818386269515456334926366572897563400500
42846280183517070527831839425882145521227251250327
55121603546981200581762165212827652751691296897789
32238195734329339946437501907836945765883352399886
75506164965184775180738168837861091527357929701337
62177842752192623401942399639168044983993173312731
32924185707147349566916674687634660915035914677504
99518671430235219628894890102423325116913619626622
73267460800591547471830798392868535206946944540724
76841822524674417161514036427982273348055556214818
97142617910342598647204516893989422179826088076852
87783646182799346313767754307809363333018982642090
10848802521674670883215120185883543223812876952786
71329612474782464538636993009049310363619763878039
62184073572399794223406235393808339651327408011116
66627891981488087797941876876144230030984490851411
60661826293682836764744779239180335110989069790714
85786944089552990653640447425576083659976645795096
66024396409905389607120198219976047599490197230297
64913982680032973156037120041377903785566085089252
16730939319872750275468906903707539413042652315011
94809377245048795150954100921645863754710598436791
78639167021187492431995700641917969777599028300699
15368713711936614952811305876380278410754449733078
40789923115535562561142322423255033685442488917353
44889911501440648020369068063960672322193204149535
41503128880339536053299340368006977710650566631954
81234880673210146739058568557934581403627822703280
82616570773948327592232845941706525094512325230608
22918802058777319719839450180888072429661980811197
77158542502016545090413245809786882778948721859617
72107838435069186155435662884062257473692284509516
20849603980134001723930671666823555245252804609722
53503534226472524250874054075591789781264330331690
""".trim.split("\n") map (BigInt(_)) 

nums.sum

// Problem 14: Longest Collatz Sequence starting < 1 million
// Ans: 837799
//
def longest_collatz:(Int,Int) = {

  var longest = (1,1)
  var cache:Map[BigInt, Int] = Map()

  def collatz(len: Int, n: BigInt): Int = {
    if (n == 1) len + 1
    else cache get n match {
      case Some(l)    => l + len
      case None       => {
        if (n % 2 == 0) collatz(len + 1, n/2)
        else            collatz(len + 1, 3*n + 1)
      }
    }
  }

  def cached_collatz(n: BigInt): Int = {
    def update_cache(len: Int) = cache get n match {
      case None => { cache = cache + (n -> len); true }
      case _    => true
    }

    val len = collatz(0, n)
    update_cache(len)
    len
  }

  (1 until 1000000).foreach (i => {
    val clen = cached_collatz(i)
    if (clen > longest._2) longest = (i, clen)
  })

  longest
}
               
// Problem 15: Lattice Paths
// Ans: 137846528820
// 

def lattice_paths(r:Int, c:Int):Long = {
  var cache:Map[(Int,Int),Long] = Map()

  def count_paths(r:Int, c:Int):Long = {
    cache get (r,c) match {
      case Some(n) => n
      case None    => {
        val num_paths = 
          if (r == 0 && c == 0) 1
          else if (r == 0) count_paths(r, c - 1)
          else if (c == 0) count_paths(r - 1, c) 
          else count_paths(r - 1, c) + count_paths(r, c - 1)
        cache = cache + ((r,c) -> num_paths)
        num_paths
      }
    }
  }

  count_paths(r,c)
}

// Problem 16: Power Digit Sum
// Ans: 1366
//
def sum_digs:Int = {
  def pow(n:BigInt, p:Int):BigInt = {
    (1 until p).foldLeft(n) ((a,x) => a * n)
  }
  (pow(2,1000).toString map (_.toString.toInt)).sum
}

// Problem 17: Number Letter Counts
// Ans:
//

// Problem 18: Maximum Path Sum
// Ans: 1074
//
val input= """
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
""".trim.split("\n").toList.map(_.split(" ").toList.map(_.toInt))

abstract class Node

case class NonEmpty(elem: Int, left: Node, right: Node) extends Node {
  override def toString = ""
}

object Empty extends Node {
  override def toString = ""
}

def build_tree(tree: List[List[Int]]):NonEmpty = {
  val rev_tree = tree.reverse
  val leafs = rev_tree.head.map (new NonEmpty(_, Empty, Empty)) 

  def make_tree(inputs: List[List[Int]], nodes: List[NonEmpty]):NonEmpty = nodes match {
    case List(n)  => n
    case x :: xs  => { 
      val data = nodes.sliding(2).toList.zip(inputs.head).map{
        case (leafs, elem) => new NonEmpty(elem, leafs(0), leafs(1)) }                                       
      make_tree(inputs.tail, data) 
    }
  }

  make_tree(rev_tree.tail, leafs)
}

val t = build_tree(input)

def find_largest(tree: Node):Int = {
  val cache = collection.mutable.Map[Node, Int]()
  var hitcount = 0

  def sum_tree(root: Node):Int = cache get root match {
    case Some(s) => { 
      hitcount += 1
      println("hit: " + hitcount)
      s 
    }
    case None => { 
      val sum = root match {
        case Empty    => 0
        case NonEmpty(elem, left, right) => {
          val left_sum = elem + sum_tree(left)
          val right_sum = elem + sum_tree(right)
          if (left_sum > right_sum) left_sum else right_sum
        }
      }
      cache(root) = sum
      sum
    }
  }

  sum_tree(tree)
}


// Problem 67: Large Maximal Path Sum
// Ans:
//
import scala.io.Source
val in = Source.fromURL("http://projecteuler.net/project/triangle.txt")
val input = in.getLines.toList.map(_.split(" ").toList.map(_.toInt)).take(30)
val t = build_tree(input)
find_largest(t)















