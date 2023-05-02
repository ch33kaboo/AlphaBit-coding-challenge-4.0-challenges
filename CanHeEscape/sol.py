#import time

def solve(x:int ,y:int):
    visit[x][y] = 1

    if((x==0)or(x==n_row-1)or(y==0)or(y==n_col-1)): #check if current position is possible escape
        return f"{x},{y}"

    if(maze[x-1][y]=="1" and visit[x-1][y]==0 ): #check if element on top is free and not visited
        neighborEscape = solve(x-1, y)
        if(neighborEscape):
            return f"{x},{y}-"+neighborEscape

    if(maze[x][y+1]=="1" and visit[x][y+1]==0): #check if element on right is free and not visited
        neighborEscape2 = solve(x, y+1)
        if(neighborEscape2):
            return f"{x},{y}-"+neighborEscape2

    if(maze[x+1][y]=="1" and visit[x+1][y]==0): #check if element under is free and not visited
        neighborEscape3 = solve(x+1, y)
        if(neighborEscape3):
            return f"{x},{y}-"+neighborEscape3

    if(maze[x][y-1]=="1" and visit[x][y-1]==0): #check if element on left is free and not visited
        neighborEscape4 = solve(x, y-1)
        if(neighborEscape4):
            return f"{x},{y}-"+neighborEscape4

    return ""



n_row = input()
n_col = input()
input_maze = input()
x0 = input()
y0 = input()


#start = time.time()
n_row = int(n_row)
n_col = int(n_col)
x0 = int(x0)
y0 = int(y0)
input_maze = input_maze.split()
maze = [[input_maze[i+j] for j in range(n_col)] for i in range(0, n_row*n_col, n_col)]
visit = [[0 for j in range(n_col)] for i in range(0, n_row*n_col, n_col)]
print(solve(x0,y0))
#end = time.time()-start
#print("exec time ", end)