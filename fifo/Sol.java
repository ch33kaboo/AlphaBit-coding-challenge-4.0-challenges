import java.util.Arrays;
import java.util.Scanner;

public class Sol {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter items (space-separated integers): ");
        String inputString = scanner.nextLine();
        int[] items;
        String[] itemsString = inputString.split(" ");
        items = Arrays.stream(itemsString).mapToInt(Integer::parseInt).toArray();
        System.out.print("Enter max size: ");
        int maxSize = scanner.nextInt();
        int[] result = cacheFifo(maxSize, items);
        System.out.println(Arrays.toString(result));
    }

    public static int[] cacheFifo(int maxSize, int[] items) {
        int occupiedSize = 0;
        int oldestItemIndex = 0;
        for (int i = 0; i < items.length; i++) {
            int item = items[i];
            while (occupiedSize + item > maxSize) {
                occupiedSize -= items[oldestItemIndex];
                oldestItemIndex += 1;
            }
            occupiedSize += item;
        }
        int[] result = { occupiedSize, oldestItemIndex };
        return result;
    }
}
