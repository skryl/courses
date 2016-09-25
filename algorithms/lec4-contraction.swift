class Graph: Printable {

    class Node: Printable, Equatable, Hashable {
        let name: String
        var neighbors: [Node]
        var description: String { return name }
        var hashValue: Int { return name.hashValue }
        init(_ name: String, neighbors: [Node] = []) {
            self.name = name
            self.neighbors = neighbors
        }

    }

    var nodes: [Node] = []
    var description: String {
        return nodes.map { $0.name }.description
    }

    init(_ nodes: Dictionary<String, [String]>) {
        for (name, neighbors) in nodes {
            if findByName(name) == nil {
              self.nodes.append(Node(name))
            }

            let thisNode = findByName(name)!
            for neighbor in neighbors {
                if let foundNeighbor = self.findByName(neighbor) {
                  thisNode.neighbors.append(foundNeighbor)
                  foundNeighbor.neighbors.append(thisNode)
                } else {
                  let neighborNode = Node(neighbor)
                  thisNode.neighbors.append(neighborNode)
                  neighborNode.neighbors.append(thisNode)
                  self.nodes.append(neighborNode)
                }
            }
        }
    }

    func findByName(name: String) -> Node? {
        return nodes.filter { $0.name == name }.first
    }
}

func ==(lhs: Graph.Node, rhs: Graph.Node) -> Bool {
    return lhs.name == rhs.name
}


func DFS(node: Graph.Node, var _ visited: [Graph.Node:Bool] = [:]) -> [String] {
  var result = [node.name]
  visited[node] = true
  for neighbor in node.neighbors {
    if !(visited[neighbor] ?? false) {
      result += DFS(neighbor, visited)
    }
  }
  return result
}

/* func BFS(node: Graph.Node) -> [String] { */
/*   var toVisit = [node] */
/*   var visited = [Graph.Node:Bool]() */
/*  */
/*   for var idx = 0; idx < toVisit.count; idx++ { */
/*     let currentNode = toVisit[idx] */
/*     visited[currentNode] = true */
/*     for neighbor in currentNode.neighbors { */
/*       if !(visited[neighbor] ?? false) { */
/*         toVisit.append(neighbor) */
/*       } */
/*     } */
/*   } */
/*   return toVisit.map { $0.name } */
/* } */

func BFS(nodes: [Graph.Node], var _ visited: [Graph.Node:Bool] = [:]) -> [String] {
  if nodes.isEmpty { return [] }
  else {
    visited[nodes[0]] = true
    let newNeighbors = nodes[0].neighbors.filter { visited[$0] == nil }
    return firstNode + newNeighbors.map { $0.name } + BFS(nodes[1..<nodes.count] + newNeighbors, visited)
  }
}

/* let result =  DFS(Graph(["a": ["b", "c", "d", "e"], "b": ["f", "g"], "c": ["h", "i"]]).findByName("a")!) */
/* println(result) */

let result = BFS([Graph(["a": ["b", "c", "d", "e"], "b": ["f", "g"], "c": ["h", "i"]]).findByName("a")!])
println(result)
