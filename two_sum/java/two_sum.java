public class two_sum {
        public static void twoSumOptimized(int[] arr, int target) {
            for (int i = 0; i < arr.length; i++) {
                int iteratorA = arr[i];
                if (target > iteratorA) {
                    for (int j = 0; j < arr.length; j++) {
                        int iteratorB = arr[j];
                        if (iteratorB + iteratorA == target) {
                            System.out.println(i + " " + j);
                        }
                    }
                }
            }
        }
        
        public static void main(String[] args) {
            int[] arr = {1, 44, 32, 11};
            int target = 12;
            twoSumOptimized(arr, target);
        }
    
}
