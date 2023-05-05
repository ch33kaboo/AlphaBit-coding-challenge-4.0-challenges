const readline = require('readline');

function findEscape(x, y, maze, visit) {
    visit[x][y] = 1;

    if (x == 0 || x == maze.length - 1 || y == 0 || y == maze[0].length - 1) {
        // check if current position is possible escape
        return `${x},${y}`;
    }

    if (maze[x - 1][y] == "1" && visit[x - 1][y] == 0) {
        // check if element on top is free and not visited
        const neighborEscape = findEscape(x - 1, y, maze, visit);
        if (neighborEscape) {
            return `${x},${y}-${neighborEscape}`;
        }
    }

    if (maze[x][y + 1] == "1" && visit[x][y + 1] == 0) {
        // check if element on right is free and not visited
        const neighborEscape2 = findEscape(x, y + 1, maze, visit);
        if (neighborEscape2) {
            return `${x},${y}-${neighborEscape2}`;
        }
    }

    if (maze[x + 1][y] == "1" && visit[x + 1][y] == 0) {
        // check if element under is free and not visited
        const neighborEscape3 = findEscape(x + 1, y, maze, visit);
        if (neighborEscape3) {
            return `${x},${y}-${neighborEscape3}`;
        }
    }

    if (maze[x][y - 1] == "1" && visit[x][y - 1] == 0) {
        // check if element on left is free and not visited
        const neighborEscape4 = findEscape(x, y - 1, maze, visit);
        if (neighborEscape4) {
            return `${x},${y}-${neighborEscape4}`;
        }
    }

    return "";
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter the number of rows in the maze: ', (n_row) => {
    rl.question('Enter the number of columns in the maze: ', (n_col) => {
        let input_maze = '';
        rl.question('Enter the maze as a string with 0s and 1s separated by spaces: ', (maze_string) => {
            input_maze = maze_string;

            rl.question('Enter the x-coordinate of the starting position: ', (x0) => {
                rl.question('Enter the y-coordinate of the starting position: ', (y0) => {

                    const lst = input_maze.split(" ");
                    const maze = Array.from({ length: n_row }, (_, i) =>
                        lst.slice(i * n_col, (i + 1) * n_col)
                    );
                    const visit = Array.from({ length: n_row }, () =>
                        Array.from({ length: n_col }, () => 0)
                    );

                    console.log("Escape path: ", findEscape(parseInt(x0), parseInt(y0), maze, visit));
                    rl.close();
                });
            });
        });
    });
});