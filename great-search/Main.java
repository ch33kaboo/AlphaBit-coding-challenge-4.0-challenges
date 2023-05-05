import java.util.*;
import java.io.*;
import java.util.function.BinaryOperator;

class Process {
    int rank;
    List<Integer> data;
    int cache;

    public Process(int rank, List<Integer> data, int cache) {
        this.rank = rank;
        this.data = data;
        this.cache = cache;
    }
}

class Workers {
    List<Process> list;
    int size;

    public Workers(List<Map<String, Object>> processDict) {
        this.list = new ArrayList<>();
        for (Map<String, Object> proc : processDict) {
            int rank = (int) proc.get("rank");
            List<Integer> data = (List<Integer>) proc.get("data");
            // System.out.println(data);
            this.list.add(new Process(rank, data, data.get(rank)));
        }
        
        this.size = this.list.size();
    }

    public Process getWorker(int rank) {
        for (Process p : this.list) {
            if (p.rank == rank) {
                return p;
            }
        }
        return null;
    }

    public void send(Process currentProcess, int dest, int index) {
        Process nextWorker = this.getWorker(dest);
        // System.out.print(nextWorker.data);
        nextWorker.cache = currentProcess.data.get(index);
        // System.out.printf("%d",nextWorker.cache);
        currentProcess.data.set(index, null);
    }

    public int recv(Process currentProcess) {
        return currentProcess.cache;
    }

    public void share(Process currentProcess, int dest, int index) {
        Process nextWorker = this.getWorker(dest);
        nextWorker.data.set(index, currentProcess.data.get(index));
    }
}

public class Main {

    public static boolean allNotNull(List<Integer> array) {
        for (Object obj : array) {
            if (obj == null) {
                return false;
            }
        }
        return true;
    }

    public static Workers ringAllReduce(BinaryOperator<Integer> function, List<Map<String, Object>> processDict, int max_iter) {
        Workers prList = new Workers(processDict);
        int size = prList.size;
        boolean allReduced = false;
        boolean shared = false;
        int j = 0;
        int iter = 0;

        System.out.println("========Share-reduce phase========");
        while (!allReduced && iter < max_iter) {
            iter += 1;
            System.out.printf("iteration: %d\n", iter);
            for (int r = 0; r < size; r++) {
                Process p = prList.getWorker(r);
                int rank = p.rank;
                int right = (rank + 1) % size;
                int idx = Math.floorMod((rank - j), size);
                // System.out.printf("%d, %d, %d|",rank, right, idx);
                prList.send(p, right, idx);
                if (rank != 0) {
                    int received = prList.recv(p);
                    System.out.printf("worker %d op(%d, %d)\n", r, received, p.data.get(Math.floorMod((rank - j - 1), size)));
                    p.data.set(Math.floorMod((rank - j - 1), size), function.apply(received, p.data.get(Math.floorMod((rank - j - 1), size))));
                    System.out.println(p.data);
                }
                if (rank == size - 1) {
                    Process firstP = prList.getWorker(0);
                    int received = prList.recv(firstP);
                    System.out.printf("worker %d op(%d, %d)\n", firstP.rank, received, firstP.data.get(Math.floorMod((size - j - 1), size)));
                    firstP.data.set(Math.floorMod((size - j - 1), size), function.apply(received, firstP.data.get(Math.floorMod((size - j - 1), size))));
                    System.out.println(firstP.data);
                };
                allReduced = p.data.stream().filter(Objects::isNull).count() == p.data.size() - 1;
            }
            j += 1;
            System.out.println("===============================");
        }
        if (iter == max_iter) {
            return prList;
        }

        // Share-only phase
        System.out.println("=========Share-only phase=========");
        int k = 0;
        Process pr = prList.getWorker(0);
        while (!shared && iter < max_iter) {
            iter += 1;
            System.out.printf("iteration: %d\n", iter);
            shared = allNotNull(pr.data);            
            for (int r = 0; r < size; r++) {
                pr = prList.getWorker(r);
                int rank = pr.rank;
                int right = Math.floorMod((rank + 1), size);
                int idx = Math.floorMod((rank + 1 - k), size);
                // System.out.print(idx);
                prList.share(pr, right, idx);
            }
            for (int r = 0; r < size; r++) {
                pr = prList.getWorker(r);
                System.out.printf("worker %d %s\n", pr.rank, Arrays.toString(pr.data.toArray()));
            }

            k += 1;
            
            System.out.println("===============================");
        }
        return prList;
    }
    // public static BinaryOperator<Integer> sum = (a, b) -> a + b;

    public static void main(String[] args) throws Exception {
        // redirect the standard input to a file
        // System.setIn(new FileInputStream("/Users/abdelkrimzitouni/coding-challenge-4.0-challenges/great-search/input.txt"));
        Scanner sc = new Scanner(System.in);

        String operation = sc.nextLine();
        int max_iter = sc.nextInt();
        // System.out.println(max_iter);
        // read in the number of arrays
        int n = sc.nextInt();
        
        List<Map<String, Object>> arrays = new ArrayList<Map<String, Object>>();
        for (int i = 1; i <= n; i++) {
            int m = sc.nextInt();
            List<Integer> values = new ArrayList<Integer>();
            for (int j = 0; j < n; j++) {
                values.add(sc.nextInt());
            }
            Map<String, Object> array = new HashMap<String, Object>();
            array.put("rank", m);
            array.put("data", values);
            arrays.add(array);
        }
        sc.close();
        final BinaryOperator<Integer> sum = (a, b) -> a + b;
        final BinaryOperator<Integer> mul = (a, b) -> a * b;
        final BinaryOperator<Integer> max = (a, b) -> Math.max(a, b);
        final BinaryOperator<Integer> min = (a, b) -> Math.min(a, b);
        // print the arrays to verify the input was parsed correctly
        // System.out.println(arrays);
        Workers allWorkers;
        if (operation.equals("+")) {
            allWorkers = ringAllReduce(sum, arrays, max_iter);
            System.out.println("============Results============");
            for (int i = 0; i < n; i++) {
                Process pr = allWorkers.getWorker(i);
                System.out.printf("%d %s\n", pr.rank, Arrays.toString(pr.data.toArray())
                    .replace("null", "-1")
                    .replace(",", "")
                    .replace("[", "")
                    .replace("]", "")
                    .replace(":", ""));
            }
        } else if (operation.equals("*")) {
            allWorkers = ringAllReduce(mul, arrays, max_iter);
            System.out.println("============Results============");
            for (int i = 0; i < n; i++) {
                Process pr = allWorkers.getWorker(i);
                System.out.printf("%d %s\n", pr.rank, Arrays.toString(pr.data.toArray())
                    .replace("null", "-1")
                    .replace(",", "")
                    .replace("[", "")
                    .replace("]", "")
                    .replace(":", ""));
            }
        } else if (operation.equals("max")) {
            allWorkers = ringAllReduce(max, arrays, max_iter);
            System.out.println("============Results============");
            for (int i = 0; i < n; i++) {
                Process pr = allWorkers.getWorker(i);
                System.out.printf("%d %s\n", pr.rank, Arrays.toString(pr.data.toArray())
                    .replace("null", "-1")
                    .replace(",", "")
                    .replace("[", "")
                    .replace("]", "")
                    .replace(":", ""));
            }
        } else if
        (operation.equals("min")) {
            allWorkers = ringAllReduce(min, arrays, max_iter);
            System.out.println("============Results============");
            for (int i = 0; i < n; i++) {
                Process pr = allWorkers.getWorker(i);
                System.out.printf("%d %s\n", pr.rank, Arrays.toString(pr.data.toArray())
                    .replace("null", "-1")
                    .replace(",", "")
                    .replace("[", "")
                    .replace("]", "")
                    .replace(":", ""));
            }
        }
    }
}
