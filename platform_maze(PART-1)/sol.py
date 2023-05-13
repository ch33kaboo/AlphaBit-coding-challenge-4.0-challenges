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

def main():
        n, m = input().split()
        n, m = int(n), int(m)
        maze = []
        for i in range(n):
                maze.append(input().split())

        nh, mh = input().split()
        nh, mh = int(nh), int(mh)
        hint = []
        for i in range(nh):
                hint.append(input().split())

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

        for l in maze:
                print(' '.join(str(_) for _ in l))

if __name__ == "__main__":
    main()