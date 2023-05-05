import java.util.Arrays;
import java.util.Scanner;

public class Sol {
    static class Input {
        int capacity;
        int[] weights;
        int[] uses;

        public Input(int capacity, int[] weights, int[] uses) {
            this.capacity = capacity;
            this.weights = weights;
            this.uses = uses;
        }
    }

    static int sol(Input input) {
        int currentCapacity = 0;
        int[] frequencyMap = new int[6];
        Arrays.fill(frequencyMap, 0);

        for (int i = 0; i < input.uses.length; i++) {
            int itemId = input.uses[i];

            if (frequencyMap[itemId] == 0) {
                while (currentCapacity + input.weights[itemId] > input.capacity) {
                    int minItemId = 0;
                    int minFrequency = Integer.MAX_VALUE;

                    for (int j = 0; j < frequencyMap.length; j++) {
                        if (frequencyMap[j] != 0 && frequencyMap[j] < minFrequency) {
                            minItemId = j;
                            minFrequency = frequencyMap[j];
                        }
                    }

                    frequencyMap[minItemId] = 0;
                    currentCapacity -= input.weights[minItemId];
                }

                currentCapacity += input.weights[itemId];
            }

            frequencyMap[itemId]++;
        }

        return currentCapacity;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the capacity: ");
        int capacity = scanner.nextInt();

        System.out.print("Enter the weights (comma-separated white spaces): ");
        String[] weightStrings = scanner.next().split(",");
        int[] weights = new int[weightStrings.length];
        for (int i = 0; i < weightStrings.length; i++) {
            weights[i] = Integer.parseInt(weightStrings[i]);
        }

        System.out.print("Enter the uses (comma-separated no white spaces): ");
        String[] useStrings = scanner.next().split(",");
        int[] uses = new int[useStrings.length];
        for (int i = 0; i < useStrings.length; i++) {
            uses[i] = Integer.parseInt(useStrings[i]);
        }

        scanner.close();

        Input input = new Input(capacity, weights, uses);
        System.out.println(sol(input)); // expected output: 800
    }
}
