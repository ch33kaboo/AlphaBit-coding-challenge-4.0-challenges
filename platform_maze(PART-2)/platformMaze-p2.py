
def main():
        n, m = input().split()
        n, m = int(n), int(m)
        marked_maze = []
        for i in range(n):
                marked_maze.append(input().split())
        
        graph = []
        v = 1
        for i, line in enumerate(marked_maze):
                for j, col in enumerate(line):
                        if marked_maze[i][j] != 'X':
                                graph.append({v: (i, j)})
                                v += 1

        def findConnectedComponents(graph):
                visited = list()
                connectedComponents = []
                for vertex in graph:
                        if vertex not in visited:
                        # start a new connected component
                                component = list()
                                dfs(vertex, graph, visited, component)
                                connectedComponents.append(component)
                return connectedComponents

        def neighbours(vertex, graph):
                neigh = []
                for i, v in enumerate(graph):
                        if v.get(i+1)[0] == list(vertex.values())[0][0]:
                                if abs(v.get(i+1)[1] - list(vertex.values())[0][1]) == 1:
                                        neigh.append(v)
                        if v.get(i+1)[1] == list(vertex.values())[0][1]:
                                if abs(v.get(i+1)[0] - list(vertex.values())[0][0]) == 1:
                                        neigh.append(v)
                return neigh
                

        def dfs(vertex, graph, visited, component):
                visited.append(vertex)
                component.append(vertex)
                for neighbor in neighbours(vertex, graph):
                        if neighbor not in visited:
                                dfs(neighbor, graph, visited, component)

        def largestConnectedSubgraph(graph):
                connectedComponents = findConnectedComponents(graph)
                largestSubgraph = None
                largestSize = 0
                for component in connectedComponents:
                        size = len(component)
                        if size > largestSize:
                                largestSubgraph = component
                                largestSize = size
                return largestSubgraph
        # print("the largest connected subgraph is:\n")
        lcsg = largestConnectedSubgraph(graph)
        print(len(lcsg))
        sorted_lcsg = sorted(lcsg, key=lambda x: (x[list(x.keys())[0]][0], -x[list(x.keys())[0]][1]))
        for e in sorted_lcsg:
                print(f"{e[list(e.keys())[0]][0]} {e[list(e.keys())[0]][1]}")

if __name__ == "__main__":
    main()