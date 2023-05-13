import java.util.Arrays;

public class Sol {
    public static boolean isPossible(String n, String p, String s) {
        int[] arr = Arrays.stream(p.split(" ")).mapToInt(Integer::parseInt).toArray();
        int[] range = Arrays.stream(s.split(" ")).mapToInt(Integer::parseInt).toArray();
        int num = Integer.parseInt(n);

        for (int i = range[0]; i < range[1]; i++) {
            if (arr[i] >= num) {
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        String n = "150";
        String p = "130 89 150 73 78 100 122 150 150 150 64 3 0 71";
        String s = "0 6";
        System.out.println(isPossible(n, p, s));
    }
}