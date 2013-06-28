Lower Bound for Comparison Based Sorting
----------------------------------------
* Theorem: every comparison-based sorting algorithm has worst-case running time
  O(nlogn) or worse
* Comparison Based: accesses input array elements only via comparisons
* Examples: Mergesort, Quicksort, HeapSort, etc
* Non-Examples: BucketSort, CountingSort, RadixSort

# Proof Idea
* consider input arrays containing {1,2,3,...n} in some order, n! such inputs
* suppose algorithm makes =< k comparisons to correctly sort the n! inputs 
* across all n! possible inputs, algorithm exhibits 2^k distinct executions
  - suppose result of 1st input is {0,1,1,...n}, 2nd input is {0,0,-1,...n}, etc
* if 2^k < n!, the algorithm doesn't work because it can't distinguish between
  at least 2 different inputs, so 2^k >= n!
* the lower bound of k here is nlog(n)
