import java.util.Scanner;

public class sol {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("");
        int target = scanner.nextInt();
        scanner.nextLine();
        String[] values = scanner.nextLine().split(" ");
        int[] arr = new int[values.length];
        for (int i = 0; i < values.length; i++) {
            arr[i] = Integer.parseInt(values[i]);
        }
        twoSumOptimized(arr, target);
    }

    public static void twoSumOptimized(int[] arr, int target) {
        for (int indexA = 0; indexA < arr.length; indexA++) {
            int iteratorA = arr[indexA];
            if (target > iteratorA) {
                for (int indexB = 0; indexB < arr.length; indexB++) {
                    int iteratorB = arr[indexB];
                    if (iteratorB + iteratorA == target) {
                        System.out.println(indexA + " " + indexB);
                        System.exit(0);
                    }
                }
            }
        }
    }
}
