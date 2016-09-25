// Greedy Algorithms
//
// Iteratively make myopic decisions, hope everything works out at the end.
// eg. Djikstra
//
// 1. easy to propose for many problems
// 2. easy running time analysis
// 3. hard to establish correctness
// 4. DANGER: most are NOT correct!!!

// The Caching Problem
//
// The "furthest-in-the-future" algorithm is ^optimal (minimizes the number of cache misses).
// 1. Impossible to implement since it's clearvoyant.
// 2. Serves as a guideline for practical algorithms. Eg. LRU
//

// A Scheduling Problem
//
// One shared resource, many jobs to do. Each jobj as a weight w (priority) and
// l (length).  The goal is to minimize the weighted sum of completion times
// sum(w*C). Where C is just the sum of the lengths of all jobjs prior and the
// current job.
//
// Jobs can be sorted by w/l. Is this correct? Yes.
//

// Prim's MST Algorithm
//
// Input: Undirected graph (OK if edge costs are negative)
// Output: Minimum cost tree that spans all vertices.
//  1. Tree has no cycles
//  2. The subgraph is connected (contains a path between each pair of vertices.
// Assumptions:
//  1. Input graph G is connected
//  2. Edge costs are distinct
