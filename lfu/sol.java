package lfu;

import java.util.Arrays;
import java.util.Scanner;

/**
 * sol
 */
public class sol {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int capacity = Integer.parseInt(scanner.nextLine().trim());
        int[] weights = Arrays.stream(scanner.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();
        int[] uses = Arrays.stream(scanner.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();

        System.out.println(solution(capacity, weights, uses));
        scanner.close();
    }

    public static int solution(int capacity, int[] weights, int[] uses) {
        // init
        int currentCapacity = 0;
        int[] frequencyMap = new int[weights.length];
        Arrays.fill(frequencyMap, 0);

        // algo
        for (int itemId : uses) {
            if (frequencyMap[itemId] == 0) {
                while (currentCapacity + weights[itemId] > capacity) {
                    // remove weight of item with least non-zero frequency
                    int minItemId = minNonZero(frequencyMap);
                    frequencyMap[minItemId] = 0;
                    currentCapacity = currentCapacity - weights[minItemId];
                }
                currentCapacity = currentCapacity + weights[itemId];
            }
            frequencyMap[itemId] = frequencyMap[itemId] + 1;
        }

        return currentCapacity;
    }

    public static int minNonZero(int[] array) {
        int min = 0;
        for (int i = 1; i < array.length; i++) {
            if (array[i] != 0 && array[i] < array[min])
                min = i;
        }

        return min;
    }
}