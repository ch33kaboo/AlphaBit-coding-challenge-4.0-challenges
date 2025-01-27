import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Sol {

    public static String toArrayOfBytes(String str) {
        boolean isBit; // false bit, true byte
        double convertCoefficient; // depends if it's giga, tera, ...
        double stringValue; // string value parsed to integer
        List<Double> arr = new ArrayList<>();

        for (String ele : str.split(" ")) {
            convertCoefficient = 1;
            stringValue = 0;
            isBit = ele.contains("b"); // if it's a bit true else false it's a byte
            int beforeLastChar = ele.charAt(ele.length() - 2);
            if (!(beforeLastChar >= 48 && beforeLastChar <= 57)) { // check the before last character if it's K/G/T/K or
                                                                   // number
                stringValue = Integer.parseInt(ele.substring(0, ele.length() - 2));
                switch (Character.toUpperCase(ele.charAt(ele.length() - 2))) {
                    case 'K': // kilo
                        convertCoefficient = Math.pow(2, 10);
                        break;

                    case 'M': // mega
                        convertCoefficient = Math.pow(2, 20);
                        break;

                    case 'G': // giga
                        convertCoefficient = Math.pow(2, 30);
                        break;

                    case 'T': // tera
                        convertCoefficient = Math.pow(2, 40);
                        break;
                }
            } else {
                stringValue = Integer.parseInt(ele.substring(0, ele.length() - 1));
            }
            arr.add((isBit) ? convertCoefficient * stringValue * 1 / 8 : convertCoefficient * stringValue);
        }

        StringBuilder result = new StringBuilder();
        DecimalFormat decimalFormat = new DecimalFormat("#.########");
        decimalFormat.setGroupingUsed(false);
        for (double value : arr) {
            if (value == (int) value) {
                result.append(decimalFormat.format(value)).append(" ");
            } else {
                result.append(decimalFormat.format(value)).append(" ");
            }
        }
        return result.toString().trim();
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String volumes = scanner.nextLine();
        System.out.println(toArrayOfBytes(volumes));
        scanner.close();
    }
}
