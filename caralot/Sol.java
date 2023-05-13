import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Stack;

public class Sol {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        List<Integer> events = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            events.add(scanner.nextInt());
        }

        int[] result = solve(n, events);
        System.out.println(result[0]);
        for (int i = 1; i <= result[0]; i++) {
            System.out.print(result[i] + " ");
        }
    }

    public static int[] solve(int n, List<Integer> events) {
        if (events.size() % 2 == 1) {
            return new int[]{-1, -1};
        }

        List<Integer> stack = new ArrayList<>();
        List<Integer> day = new ArrayList<>();
        List<Integer> done = new ArrayList<>();
        List<List<Integer>> oute = new ArrayList<>();

        for (Integer e : events) {
            if (!done.contains(e)) {
                if (e > 0 && !day.contains(e)) {
                    day.add(e);
                    stack.add(e);
                } else if (e < 0 && day.contains(-e)) {
                    day.remove(Integer.valueOf(-e));
                    stack.add(e);
                    done.add(-e);
                    if (day.size() == 0) {
                        oute.add(new ArrayList<>(stack));
                        done.clear();
                        day.clear();
                        stack.clear();
                    }
                } else {
                    return new int[]{-1, -1};
                }
            }
        }

        int[] outeIndex = new int[oute.size() + 1];
        outeIndex[0] = oute.size();
        for (int i = 1; i <= oute.size(); i++) {
            outeIndex[i] = oute.get(i - 1).size();
        }

        return outeIndex;
    }
}
