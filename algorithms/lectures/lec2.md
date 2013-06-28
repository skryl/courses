The Master Method
--------------------------------------------------------------------------------

## Assumptions
* All sub-problems have equal size

## Recurrence Relationship (for amount of work done by T(n))
* T(n) <= constant (for all sufficiently small n)
* T(n) <= aT(n/b) + O(n^d) (for all larger n)
  - first part is the amount of work done per subproblem
  - second part is the amount of work done to combine sub results
  - a is the number of recursive calls (>= 1)
  - b is the input size shrinkage factor (> 1)
  - d is the exponent in running time of "combine step"

## The Master Theorem
* T(n) is ... 
  1. O(n^d * log(n)) if = a = b^d
  2. O(n^d) if a < b^d
  3. O(n^(logb(a)) if a > b^d

### Merge Sort Example
* a, b, d = 2, 2, 1
* T(n) = nlog(n)

### Binary Search Example
* a, b, d = 1, 2, 0
* T(n) = log(n)

### Recursive Multiplication Example
* a, b, d = 4, 2, 1
* T(n) = n^log2(4) = n^2

### Karatsuba Multiplication Example
* a, b, d = 3, 2, 1
* T(n) = n^log2(3) = n^1.59

### Strassen's Matrix Multiply Example
* a, b, d = 7, 2, 2
* T(n) = n^log2(7) = n^2.81

## Proof
* At level j=0,1,2...logb(n) of a recurrence, there are a^j subproblems, each of size n/b^j
* Work at a Single Level <= a^j * (c * n/b^j ^ d) = cn^d * (a/b^d)^j
* Total Work <= cn^d * Sum(0..logb(n))[(a/b^d)^j]
  - a = rate of subproblem proliferation (RSP)
  - b^d = rate of work shrinkage         (RWS)

1. RSP = RWS -> Same amount of work at each level (Merge Sort) [O(n^d * log(n))]
2. RSP < RWS -> less work at each level, most work at the root [O(n^d)]
3. RSP > RWS -> more work at each level, most work at the leaves [O(# leaves = a * logb(n)]

QuickSort
--------------------------------------------------------------------------------
* Key Idea is "partitioning around a pivot"
  - the pivot ends up in it's rightful sorted position

* Why Partition?
  - It's linear (O(n)) with no extra memory (in place)
  - reduces the problem size (Divide and Conquer)
