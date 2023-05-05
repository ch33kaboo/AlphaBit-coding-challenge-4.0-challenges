import java.util.*;

public class Sol {
    public static List<Integer> array1 = new ArrayList<Integer>();
    public static List<Integer> array2 = new ArrayList<Integer>();

    public static void findRacines(int n) {
        if (n == 0 || n == 1 || n == 2 || n == 3) {
            array1.add(n);
        } else {
            int a = (int) Math.sqrt(n);
            int b = n - (int) Math.pow(a, 2);
            array1.add(a);
            findRacines(a);
            if (b != 0) {
                array2.add(b);
                findRacines(b);
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a number: ");
        int n = scanner.nextInt();
        scanner.close();
        findRacines(n);
        System.out.println("Array 1: " + array1);
        System.out.println("Array 2: " + array2);
    }
}
