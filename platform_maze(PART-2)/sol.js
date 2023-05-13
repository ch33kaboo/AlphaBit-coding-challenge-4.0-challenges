/* Common Template Starts */
process.stdin.resume()
process.stdin.setEncoding('utf-8')
let inputString = ''
let currentLine = 0

process.stdin.on('data', (inputStdin) => {
  inputString += inputStdin
})

process.stdin.on('end', (_) => {
  inputString = inputString
    .trim()
    .split('\n')
    .map((string) => {
      return string.trim()
    })

  main()
})

function readline() {
  return inputString[currentLine++]
}/*Common Template Ends */


const neighboors = (vertex, graph) => {
  const neigh = []
  graph.forEach((v, i) => {
    if (v[i + 1][0] === Object.values(vertex)[0][0]) {
      if (Math.abs(v[i + 1][1] - Object.values(vertex)[0][1]) === 1) {
        neigh.push(v)
      }
    }
    if (v[i + 1][1] === Object.values(vertex)[0][1]) {
      if (Math.abs(v[i + 1][0] - Object.values(vertex)[0][0]) === 1) {
        neigh.push(v)
      }
    }
  })
  return neigh
}

const dfs = (vertex, graph, visited, component) => {
  visited.push(vertex)
  component.push(vertex)
  const neighbors = neighboors(vertex, graph)
  neighbors.forEach((neighbor) => {
    if (!visited.includes(neighbor)) {
      dfs(neighbor, graph, visited, component)
    }
  })
}

const findConnectedComponents = (graph) => {
  const visited = []
  const connectedComponents = []
  graph.forEach((vertex) => {
    if (!visited.includes(vertex)) {
      const component = []
      dfs(vertex, graph, visited, component)
      connectedComponents.push(component)
    }
  })

  return connectedComponents
}

const largestConnectedSubgraph = (graph) => {
  const connectedComponents = findConnectedComponents(graph)
  let largestSubgraph = null
  let largestSize = 0

  for (let i = 0; i < connectedComponents.length; i++) {
    const component = connectedComponents[i]
    const size = component.length
    if (size > largestSize) {
      largestSubgraph = component
      largestSize = size
    }
  }

  return largestSubgraph
}

const main = () => {
  const [n, m] = readline().split(' ')
    .map(Number)

  const marked_maze = []
  for (let i = 0; i < n; i++) {
    const input = readline().split(' ')
    marked_maze.push(input)
  }

  const graph = []
  let v = 1
  for (let i = 0; i < marked_maze.length; i++) {
    for (let j = 0; j < marked_maze[i].length; j++) {
      if (marked_maze[i][j] !== 'X') {
        graph.push({ [v]: [i, j] })
        v++
      }
    }
  }

  const lcsg = largestConnectedSubgraph(graph)
  const sorted_lcsg = lcsg.sort((a, b) => {
    const keyA = Object.keys(a)[0]
    const keyB = Object.keys(b)[0]
    const valueA = a[keyA]
    const valueB = b[keyB]

    let comparison = valueA[0] - valueB[0]
    if (comparison === 0) {
      comparison = valueB[1] - valueA[1]
    }
    return comparison
  })

  console.log(lcsg.length)
  for (let i = 0; i < sorted_lcsg.length; i++) {
    const e = sorted_lcsg[i]
    const key = Object.keys(e)[0]
    const value = e[key]
    console.log(value[0] + ' ' + value[1])
  }
}