package clothes;

import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Scanner;

/**
 * sol
 */
public class sol {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int[] first_line = Arrays.stream(scanner.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray(); // number
                                                                                                               // of
                                                                                                               // items
                                                                                                               // &
                                                                                                               // number
                                                                                                               // of
                                                                                                               // matching
                                                                                                               // pairs
        double[] prices = Arrays.stream(scanner.nextLine().split(" ")).mapToDouble(Double::parseDouble).toArray();
        int[][] matchingPairs = new int[first_line[1]][2];

        for (int i = 0; i < first_line[1]; i++)
            matchingPairs[i] = Arrays.stream(scanner.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();

        double result = solution(first_line[0], first_line[1], prices, matchingPairs);
        System.out.println(new DecimalFormat("#").format(result));

        scanner.close();
    }

    public static double solution(int nbItems, int nbMatchingPairs, double[] prices, int[][] matchingPairs) {
        if (nbItems < 3 || nbMatchingPairs < 3)
            return -1;

        // init
        double[][] matchingCosts = new double[nbItems][nbItems];
        for (double[] array : matchingCosts)
            Arrays.fill(array, Double.POSITIVE_INFINITY);

        for (int[] matchingPair : matchingPairs) {
            int i = matchingPair[0] - 1;
            int j = matchingPair[1] - 1;
            matchingCosts[i][j] = Math.min(prices[i], prices[j]);
            matchingCosts[j][i] = Math.min(prices[i], prices[j]);
        }

        double min_cost = Double.POSITIVE_INFINITY;
        for (int i = 0; i < nbItems; i++)
            for (int j = i + 1; j < nbItems; j++) {
                if (matchingCosts[i][j] == Double.POSITIVE_INFINITY)
                    continue;
                for (int k = j + 1; k < nbItems; k++)
                    min_cost = Math.min(min_cost, prices[i] + prices[j] + prices[k]);
            }

        if (min_cost == Double.POSITIVE_INFINITY)
            return -1;
        else
            return min_cost;
    }

}