from math import dist
import copy

maze = [["T", "T", "T", "T", "T", "T"],
           ["T", "T", "T", "T", "T", "T"],
           ["T", "T", "T", "T", "T", "T"],
           ["T", "T", "T", "T", "T", "T"],
           ["T", "T", "T", "T", "T", "T"],
           ["T", "T", "T", "T", "T", "T"]]

hint = [["2,r", "3,l", "1,l,l"],
              ["3", "2,r,r", "3"],
              ["1,l,l", "3", "2,r"]]

# hint = [["2", "3,l", "2"],
#               ["1,r", "2,r,r", "3"],
#               ["1,l,l", "3", "2,r"]]
print("unmarked")
for l in maze:
        print(l)
print("\n"+"="*8)

def mark(maze, spots, spins, direction, i_line, i_col):
        if spots == 1:
                if spins % 4 == 0:
                        maze[i_line*2+1][i_col*2+1] = "X"
                elif spins % 4 == 1:
                        if direction == 'l':
                                maze[i_line*2+1-1][i_col*2+1] = "X"
                        elif direction == 'r':
                                maze[i_line*2+1][i_col*2+1-1] = "X"
                elif spins % 4 == 2:
                        maze[i_line*2+1-1][i_col*2+1-1] = "X"
                elif spins % 4 == 3:
                        if direction == 'r':
                                maze[i_line*2+1-1][i_col*2+1] = "X"
                        elif direction == 'l':
                                maze[i_line*2+1][i_col*2+1-1] = "X"
        # 2 spots
        if spots == 2:
                if spins % 4 == 0:
                        maze[i_line*2+1-1][i_col*2+1-1] = "X"
                        maze[i_line*2+1-1][i_col*2+1] = "X"
                elif spins % 4 == 1:
                        if direction == 'l':
                                maze[i_line*2+1-1][i_col*2+1-1] = "X"
                                maze[i_line*2+1][i_col*2+1-1] = "X"
                        elif direction == 'r':
                                maze[i_line*2+1-1][i_col*2+1] = "X"
                                maze[i_line*2+1][i_col*2+1] = "X"
                elif spins % 4 == 2:
                        maze[i_line*2+1][i_col*2+1-1] = "X"
                        maze[i_line*2+1][i_col*2+1] = "X"
                elif spins % 4 == 3:
                        if direction == 'r':
                                maze[i_line*2+1-1][i_col*2+1-1] = "X"
                                maze[i_line*2+1][i_col*2+1-1] = "X"
                        elif direction == 'l':
                                maze[i_line*2+1-1][i_col*2+1] = "X"
                                maze[i_line*2+1][i_col*2+1] = "X"
        
        # 3 spots
        if spots == 3:
                if spins % 4 == 0:
                        maze[i_line*2+1-1][i_col*2+1] = "X"
                        maze[i_line*2+1][i_col*2+1] = "X"
                        maze[i_line*2+1][i_col*2+1-1] = "X"
                elif spins % 4 == 1:
                        if direction == 'l':
                                maze[i_line*2+1-1][i_col*2+1-1] = "X"
                                maze[i_line*2+1-1][i_col*2+1] = "X"
                                maze[i_line*2+1][i_col*2+1] = "X"
                        elif direction == 'r':
                                maze[i_line*2+1-1][i_col*2+1-1] = "X"
                                maze[i_line*2+1][i_col*2+1-1] = "X"
                                maze[i_line*2+1][i_col*2+1] = "X"
                elif spins % 4 == 2:
                        maze[i_line*2+1-1][i_col*2+1-1] = "X"
                        maze[i_line*2+1-1][i_col*2+1] = "X"
                        maze[i_line*2+1][i_col*2+1-1] = "X"
                elif spins % 4 == 3:
                        if direction == 'r':
                                maze[i_line*2+1-1][i_col*2+1-1] = "X"
                                maze[i_line*2+1-1][i_col*2+1] = "X"
                                maze[i_line*2+1][i_col*2+1] = "X"
                        elif direction == 'l':
                                maze[i_line*2+1-1][i_col*2+1-1] = "X"
                                maze[i_line*2+1][i_col*2+1-1] = "X"
                                maze[i_line*2+1][i_col*2+1] = "X"


for i_line, line in enumerate(hint):
    for i_col, col in enumerate(line):
        h = hint[i_line][i_col].split(",")
        spots = int(h[0]) #number of spots

        # count how many lefts and rights are in there
        count_left = h.count("l")
        count_right = h.count("r")

        spins = abs(count_left - count_right)
        direction = "l" if (count_left - count_right > 0) else "r" #it doesn't matter if it's 0 we handle it with spins%4
        mark(maze, spots, spins, direction, i_line, i_col)


class Spot:
        def __init__(self, i, j, wall):
                self.i = i
                self.j = j

                self.f = 0
                self.g = 0
                self.h = 0

                self.wall = (wall == "X")

                self.neighbours = []
                self.previous = None

        def add_neighbours(self, maze_grid):
                i = self.i
                j = self.j
                if (i < len(maze_grid[0]) -1):
                        self.neighbours.append(maze_grid[i + 1][j])
                if (i > 0):
                        self.neighbours.append(maze_grid[i - 1][j])
                if (j < len(maze_grid[:][0]) -1):
                        self.neighbours.append(maze_grid[i][j + 1])
                if (j > 0):
                        self.neighbours.append(maze_grid[i][j - 1])
                if (i < len(maze_grid[0]) -1):
                        self.neighbours.append(maze_grid[i + 1][j])
                if (i > 0):
                        self.neighbours.append(maze_grid[i - 1][j])
                if (j < len(maze_grid[:][0]) -1):
                        self.neighbours.append(maze_grid[i][j + 1])
                if (j > 0):
                        self.neighbours.append(maze_grid[i][j - 1])
                # Diagonals
                if (i > 0 and j > 0):
                        self.neighbours.append(maze_grid[i - 1][j-1])
                if (i < len(maze_grid[0]) -1 and j > 0):
                        self.neighbours.append(maze_grid[i + 1][j - 1])
                if (i > 0 and j < len(maze_grid[:][0]) -1):
                        self.neighbours.append(maze_grid[i - 1][j + 1])
                if (i < len(maze_grid[0]) -1 and j < len(maze_grid[:][0]) -1):
                        self.neighbours.append(maze_grid[i + 1][j + 1])
                

def heuristic(a, b):
        return dist([a.i, a.j], [b.i, b.j])

openSet = []
closedSet = []

rows  = len(maze[0])
cols  = len(maze[:][0])


print("marked")
for l in maze:
        print(l)
print("\n"+"="*8)

maze_grid = copy.deepcopy(maze)
# making the spots grid
for i, line in enumerate(maze_grid):
    for j, col in enumerate(line):
            val = maze[i][j]
            maze_grid[i][j] =  Spot(i, j, wall=val)

# add neighbours
for i, line in enumerate(maze_grid):
    for j, col in enumerate(line):
            maze_grid[i][j].add_neighbours(maze_grid)

start = maze_grid[rows - 1][0]
# starts = [x for x in maze_grid[rows - 1] if not x.wall]
ends = [x for x in maze_grid[0] if not x.wall]
# ends = maze_grid[0]

# all possible shortest paths for diferent starting and ending point
all_paths = []
openSet.append(start)

if ends :
        while len(openSet) > 0: # Am I still searching ?

                # Best next option
                winner = 0
                for i in range(len(openSet)):
                        if openSet[i].f < openSet[winner].f:
                                winner = i
                
                current = openSet[winner]

                if current == ends[0]:
                        print("DONE!\n")
                        for p in path:
                                maze[p.i][p.j] = "P"
                        maze[current.i][current.j] = "P"
                        break

                openSet.remove(current)
                closedSet.append(current)

                # Check all neighbours
                for neighbour in current.neighbours:
                        # Valid next spot?
                        if ((neighbour not in closedSet) and (not neighbour.wall)):
                                tempG = current.g + heuristic(neighbour, current)
                        
                                # Is this a better path than before?
                                newPath = False
                                if neighbour in openSet:
                                        if tempG < neighbour.g:
                                                neighbour.g = tempG
                                                newPath = True
                                else:
                                        neighbour.g = tempG
                                        newPath = True
                                        openSet.append(neighbour)
                                
                                # Yes, it's a better path
                                if newPath:
                                        neighbour.h = heuristic(neighbour, ends[0])
                                        neighbour.f = neighbour.g + neighbour.h
                                        neighbour.previous = current
                        
                path = []
                temp = current
                path.append(temp)
                while (temp.previous):
                        path.append(temp.previous)
                        temp = temp.previous
        if len(openSet) == 0:
                print('no solution, blocked road')
else:
        print('no ending point')              

for l in maze:
        print(l)

graph = []
v = 1
for i, line in enumerate(maze_grid):
    for j, col in enumerate(line):
            if maze[i][j] != 'X':
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
print("the largest connected subgraph is:\n")
print(largestConnectedSubgraph(graph))