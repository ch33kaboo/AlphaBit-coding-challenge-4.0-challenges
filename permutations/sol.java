import java.util.Scanner;

public class sol {
    public static void nperms(int n) {
        String[] a = new String[n];
        for (int i = 1; i <= n; i++) {
            a[i - 1] = Integer.toString(i);
        }
        permute(a, 0, a.length);
    }

    public static String toString(String[] List) {
        StringBuilder sb = new StringBuilder();
        for (String s : List) {
            sb.append(s);
        }
        return sb.toString();
    }

    public static void permute(String[] a, int l, int r) {
        if (l == r) {
            System.out.println(toString(a));
        } else {
            for (int i = l; i < r; i++) {
                String temp = a[l];
                a[l] = a[i];
                a[i] = temp;
                permute(a, l + 1, r);
                temp = a[l];
                a[l] = a[i];
                a[i] = temp; // backtrack
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        nperms(n);
    }
}
