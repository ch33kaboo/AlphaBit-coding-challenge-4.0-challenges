import java.util.Scanner;

public class Sol {
    static int n_row = 5;
    static int n_col = 6;
    static int[][] visit = new int[n_row][n_col];
    static String[][] maze = new String[n_row][n_col];

    public static String findEscape(int x, int y) {
        visit[x][y] = 1;

        if (x == 0 || x == n_row - 1 || y == 0 || y == n_col - 1) { // check if current position is possible escape
            return x + "," + y;
        }

        if (maze[x - 1][y].equals("1") && visit[x - 1][y] == 0) { // check if element on top is free and not visited
            String neighborEscape = findEscape(x - 1, y);
            if (!neighborEscape.equals("")) {
                return x + "," + y + "-" + neighborEscape;
            }
        }

        if (maze[x][y + 1].equals("1") && visit[x][y + 1] == 0) { // check if element on right is free and not visited
            String neighborEscape2 = findEscape(x, y + 1);
            if (!neighborEscape2.equals("")) {
                return x + "," + y + "-" + neighborEscape2;
            }
        }

        if (maze[x + 1][y].equals("1") && visit[x + 1][y] == 0) { // check if element under is free and not visited
            String neighborEscape3 = findEscape(x + 1, y);
            if (!neighborEscape3.equals("")) {
                return x + "," + y + "-" + neighborEscape3;
            }
        }

        if (maze[x][y - 1].equals("1") && visit[x][y - 1] == 0) { // check if element on left is free and not visited
            String neighborEscape4 = findEscape(x, y - 1);
            if (!neighborEscape4.equals("")) {
                return x + "," + y + "-" + neighborEscape4;
            }
        }

        return "";
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the maze as a space-separated string:");
        String input_maze = scanner.nextLine();

        System.out.println("Enter the starting row (0-indexed):");
        int x0 = scanner.nextInt();

        System.out.println("Enter the starting column (0-indexed):");
        int y0 = scanner.nextInt();

        String[] lst = input_maze.split(" ");
        int index = 0;
        for (int i = 0; i < n_row; i++) {
            for (int j = 0; j < n_col; j++) {
                maze[i][j] = lst[index++];
            }
        }

        System.out.println("escape : " + findEscape(x0, y0));
    }
}
