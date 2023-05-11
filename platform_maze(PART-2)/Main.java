// import java.util.ArrayList;
// import java.util.Comparator;
// import java.util.HashMap;
// import java.util.List;
// import java.util.Map;
// import java.util.Scanner;

// public class Main {
//     public static void main(String[] args) {
//         Scanner scanner = new Scanner(System.in);
//         int n = scanner.nextInt();
//         int m = scanner.nextInt();
//         scanner.nextLine(); // Consume the remaining newline character

//         List<Map<Integer, int[]>> markedMaze = new ArrayList<>();
//         for (int i = 0; i < n; i++) {
//             String[] line = scanner.nextLine().split(" ");
//             Map<Integer, int[]> row = new HashMap<>();
//             for (int j = 0; j < m; j++) {
//                 if (!line[j].equals("X")) {
//                     int[] coordinate = { i, j };
//                     row.put(j + 1, coordinate);
//                 }
//             }
//             markedMaze.add(row);
//         }
//         scanner.close();
//         List<Map<Integer, int[]>> graph = new ArrayList<>();
//         int v = 1;
//         for (int i = 0; i < markedMaze.size(); i++) {
//             for (int j = 0; j < markedMaze.get(i).size(); j++) {
//                 Map<Integer, int[]> vertex = markedMaze.get(i);
//                 if (vertex.containsKey(j + 1)) {
//                     Map<Integer, int[]> map = new HashMap<>();
//                     map.put(v, vertex.get(j + 1));
//                     graph.add(map);
//                     v++;
//                 }
//             }
//         }

//         List<List<Map<Integer, int[]>>> connectedComponents = findConnectedComponents(graph);
//         List<Map<Integer, int[]>> largestSubgraph = findLargestConnectedSubgraph(connectedComponents);

//         largestSubgraph.sort(Comparator.comparing((Map<Integer, int[]> e) -> e.get(e.keySet().iterator().next())[0])
//                 .thenComparing(Comparator.comparing((Map<Integer, int[]> e) -> e.get(e.keySet().iterator().next())[1])
//                         .reversed()));

//         // Print the sorted coordinates
//         System.out.println(largestSubgraph.size());
//         for (Map<Integer, int[]> element : largestSubgraph) {
//             int[] coordinate = element.get(element.keySet().iterator().next());
//             System.out.println(coordinate[0] + " " + coordinate[1]);
//         }
//     }

//     public static List<List<Map<Integer, int[]>>> findConnectedComponents(List<Map<Integer, int[]>> graph) {
//         List<Map<Integer, int[]>> visited = new ArrayList<>();
//         List<List<Map<Integer, int[]>>> connectedComponents = new ArrayList<>();
//         for (Map<Integer, int[]> vertex : graph) {
//             if (!visited.contains(vertex)) {
//                 List<Map<Integer, int[]>> component = new ArrayList<>();
//                 dfs(vertex, graph, visited, component);
//                 connectedComponents.add(component);
//             }
//         }
//         return connectedComponents;
//     }

//     public static List<Map<Integer, int[]>> findNeighbors(Map<Integer, int[]> vertex, List<Map<Integer, int[]>> graph) {
//         List<Map<Integer, int[]>> neighbors = new ArrayList<>();
//         int[] vertexCoordinates = vertex.get(vertex.keySet().iterator().next());
//         for (Map<Integer, int[]> v : graph) {
//             int[] vCoordinates = v.get(v.keySet().iterator().next());
//             if ((vCoordinates[0] == vertexCoordinates[0] && Math.abs(vCoordinates[1] - vertexCoordinates[1]) == 1) ||
//                     (vCoordinates[1] == vertexCoordinates[1] && Math.abs(vCoordinates[0] - vertexCoordinates[0]) == 1)
//                     ||
//                     (vCoordinates[0] == vertexCoordinates[0] && vCoordinates[1] == vertexCoordinates[1])) {
//                 neighbors.add(v);
//             }
//         }
//         return neighbors;
//     }

//     public static void dfs(Map<Integer, int[]> vertex, List<Map<Integer, int[]>> graph,
//             List<Map<Integer, int[]>> visited, List<Map<Integer, int[]>> component) {
//         visited.add(vertex);
//         component.add(vertex);
//         List<Map<Integer, int[]>> vertexNeighbors = findNeighbors(vertex, graph);
//         for (Map<Integer, int[]> neighbor : vertexNeighbors) {
//             if (!visited.contains(neighbor)) {
//                 dfs(neighbor, graph, visited, component);
//             }
//         }
//     }

//     public static List<Map<Integer, int[]>> findLargestConnectedSubgraph(
//             List<List<Map<Integer, int[]>>> connectedComponents) {
//         List<Map<Integer, int[]>> largestSubgraph = null;
//         int largestSize = 0;
//         for (List<Map<Integer, int[]>> component : connectedComponents) {
//             int size = component.size();
//             if (size > largestSize) {
//                 largestSubgraph = component;
//                 largestSize = size;
//             }
//         }
//         return largestSubgraph;
//     }
// }
