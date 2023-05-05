package sum_of_power.java;

public class sum_of_power {
    static StringBuilder str1 = new StringBuilder();
    static StringBuilder str2 = new StringBuilder();

    public static String findRacines(int n) {
        if (n == 0 || n == 1 || n == 2 || n == 3) {
            return String.valueOf(n);
        } else {
            int a = (int) Math.sqrt(n);
            int b = n - (int) Math.pow(a, 2);
            str1.append(a).append(",");
            str2.append(b).append(",");
            findRacines(a);
            findRacines(b);
            return "";
        }
    }

    public static void main(String[] args) {
        findRacines(20);
        System.out.println(str1.substring(0, str1.length() - 1));
        System.out.println(str2.substring(0, str2.length() - 1));
    }
}
