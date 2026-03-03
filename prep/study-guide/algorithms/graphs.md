## Graphs

---

### Why this matters in interviews

- Many “real world” problems (courses and prerequisites, maps, dependencies) are naturally modeled as **graphs**.
- BFS and DFS are fundamental; topological sort and shortest paths build on them.
- You don’t need heavy theory; you need a solid **template** and ability to talk about complexity.

---

### Core concepts

- **Representations**
  - Adjacency list: `map<Node, [neighbors]>` – usually best; space \(O(V + E)\).
  - Adjacency matrix: `n x n` boolean/weight matrix – good for dense graphs, \(O(V^2)\) space.
- **Graph types**
  - Directed vs undirected.
  - Weighted vs unweighted.
  - Cyclic vs acyclic.
- **Traversal**
  - **BFS**: good for shortest path in unweighted graphs.
  - **DFS**: good for exploring components, detecting cycles, and backtracking.

---

### Canonical patterns

#### BFS template (unweighted shortest path)

Swift sketch (adjacency list as `[[Int]]`):

```swift
func bfsDistances(from start: Int, graph: [[Int]]) -> [Int] {
    var dist = Array(repeating: -1, count: graph.count)
    var queue: [Int] = []
    var head = 0

    dist[start] = 0
    queue.append(start)

    while head < queue.count {
        let node = queue[head]
        head += 1

        for nei in graph[node] {
            if dist[nei] == -1 {
                dist[nei] = dist[node] + 1
                queue.append(nei)
            }
        }
    }

    return dist
}
```

#### DFS template (recursive)

Swift sketch:

```swift
func dfs(_ node: Int, graph: [[Int]], visited: inout [Bool]) {
    if visited[node] { return }
    visited[node] = true
    for nei in graph[node] {
        dfs(nei, graph: graph, visited: &visited)
    }
}
```

Use for connected components, island counting, and exploring paths.

#### Topological sort (Kahn’s algorithm)

Use for ordering tasks with dependencies in a **DAG** (directed acyclic graph).

Swift sketch:

```swift
func topoSort(_ graph: [[Int]]) -> [Int]? {
    let n = graph.count
    var indegree = Array(repeating: 0, count: n)

    for u in 0..<n {
        for v in graph[u] {
            indegree[v] += 1
        }
    }

    var queue: [Int] = []
    var head = 0

    for i in 0..<n where indegree[i] == 0 {
        queue.append(i)
    }

    var order: [Int] = []

    while head < queue.count {
        let u = queue[head]
        head += 1
        order.append(u)

        for v in graph[u] {
            indegree[v] -= 1
            if indegree[v] == 0 {
                queue.append(v)
            }
        }
    }

    return order.count == n ? order : nil   // nil means cycle
}
```

#### High‑level shortest paths (weighted)

- **Dijkstra’s algorithm** for non‑negative edge weights:
  - Use a min‑priority queue keyed by tentative distance.
  - Complexity: \(O((V + E)\log V)\) with binary heap.
- You generally don’t need to code Dijkstra from scratch in most mid‑level interviews, but you should **recognize when BFS is insufficient** (when edges have weights).

---

### Interview Q&A

- **Q: When do you choose BFS over DFS?**  
  **A:** Use BFS when you need the **shortest number of steps** in an unweighted graph or grid; DFS is better when you need to explore **all paths** or use recursion/backtracking.

- **Q: How do you detect a cycle in a directed graph?**  
  **A:** Use DFS with a recursion stack (visited + “on path” set), or use topological sort and check if you processed all nodes.

- **Q: What’s the complexity of BFS/DFS on a graph?**  
  **A:** \(O(V + E)\) time and \(O(V)\) space.

- **Q: Why is adjacency list usually preferred over adjacency matrix?**  
  **A:** For sparse graphs, adjacency lists use much less space (\(O(V + E)\) vs \(O(V^2)\)) and support efficient traversal of neighbors.

---

### Practice prompts

- Count the number of **islands** in a 2D grid of water/land.
- Determine if a directed graph has a **cycle**.
- Given courses and prerequisites, return a valid **ordering** or detect that it’s impossible.
- In a grid, find the **shortest path** from a start cell to a target, avoiding obstacles.
- Given a set of tasks with dependencies, detect if you can **finish all tasks**.

