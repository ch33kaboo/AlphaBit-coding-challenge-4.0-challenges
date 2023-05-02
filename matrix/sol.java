package matrix;

import java.util.Arrays;
import java.util.Scanner;

/**
 * sol
 */
public class sol {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String targetWord = scanner.nextLine().trim();
        int[] dimensions = Arrays.stream(scanner.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();
        String[] matrix = new String[dimensions[0]];

        for (int i = 0; i < dimensions[0]; i++)
            matrix[i] = scanner.nextLine();

        System.out.println(solution(targetWord, dimensions, matrix));

        scanner.close();
    }

    public static String solution(String targetWord, int[] dimensions, String[] matrix) {
        // init
        int rows = dimensions[0];
        int cols = dimensions[1];

        // algo
        for (int i = 0; i < rows; i++) {
            if (checkHorizontal(matrix, targetWord, i)) {
              return String.format("row %d", i + 1);
            }
          }
        
          for (int i = 0; i < cols; i++) {
            if (checkVertical(matrix, targetWord, i)) {
              return String.format("col %d", i + 1);
            }
          }

        return "none";
    }

    public static String getColumn(String[] matrix, int colNumber) {
        String columnStr = "";
        for (String row : matrix) {
            columnStr = columnStr + row.charAt(colNumber);
        }
        return columnStr;
      }
      
      // helper functions
      public static Boolean checkHorizontal(String[] matrix, String targetWord, int row) {
        String right = matrix[row].repeat(2);
        String left = (new StringBuffer(matrix[row]).reverse().toString()).repeat(2);
      
        return right.indexOf(targetWord) != -1 || left.indexOf(targetWord) != -1;
      }
      
      public static Boolean checkVertical(String[] matrix, String targetWord, int col) {
        String columnStr = getColumn(matrix, col);
        String bottom = columnStr.repeat(2);
        String top = (new StringBuffer(columnStr).reverse().toString()).repeat(2);
      
        return bottom.indexOf(targetWord) != -1 || top.indexOf(targetWord) != -1;
      }
}