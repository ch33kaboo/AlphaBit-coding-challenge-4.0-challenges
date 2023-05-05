import java.util.Scanner;

public class Sol {
    public static String optimal(String str) {
        String capitalVowels = "";
        String smallDiv4 = "";
        String capitalContstantes = "";
        String capitalDiv4 = "";
        String digits = "";
        String symboles = "";
        String smallVowels = "";
        String smallConstantes = "";

        for (int index = 0; index < str.length(); index++) {
            if ("AEIOUY".indexOf(str.charAt(index)) >= 0) {
                    capitalVowels += str.charAt(index);
            } else if ("dhlptx".indexOf(str.charAt(index)) >= 0) {
                smallDiv4 += str.charAt(index);
            } else if ("BCDFGHJKLMNOPQRSTVWXZ".indexOf(str.charAt(index)) >= 0) {
                capitalContstantes += str.charAt(index);
            } else if ("DHLPTX".indexOf(str.charAt(index)) >= 0) {
                capitalDiv4 += str.charAt(index);   
            } else if ("0123456789".indexOf(str.charAt(index)) >= 0) {
                digits += str.charAt(index);
            } else if ("!@#$%^&*()_+/\\][{}\":;`<>?\'".indexOf(str.charAt(index)) >= 0) {
                symboles += str.charAt(index);
            } else if ("aeiouy".indexOf(str.charAt(index)) >= 0) {
                smallVowels += str.charAt(index);
            } else if ("bcdfghjklmnpqrstvwxz".indexOf(str.charAt(index)) >= 0) {
                smallConstantes += str.charAt(index);
            }
        }

    return capitalVowels+smallDiv4+capitalContstantes+capitalDiv4+digits+symboles+smallVowels+smallConstantes;

    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a string: ");
        String myString = scanner.nextLine();
        scanner.close();
        System.out.println(optimal(myString));
    }
}
