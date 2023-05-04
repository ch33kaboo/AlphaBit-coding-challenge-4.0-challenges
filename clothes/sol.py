def optimized_Sollution(input_file):
    n, m = map(int, input().split())
    if (n < 3) or (m<3): return -1 
    prices = list(map(int, input().split()))
    matching_costs = [[float('inf') for _ in range(n)] for _ in range(n)]
    for _ in range(m):
        i, j = map(int, input().split())
        matching_costs[i-1][j-1] = matching_costs[j-1][i-1] = min(prices[i-1], prices[j-1])

        
    min_cost = float('inf')
    for i in range(n):
        for j in range(i+1, n):
            if matching_costs[i][j] == float('inf'):
                continue
            for k in range(j+1, n):
                if matching_costs[i][k] != float('inf') and matching_costs[j][k] != float('inf'):
                    min_cost = min(min_cost, prices[i]+prices[j]+prices[k])

    if min_cost == float('inf'):
        return -1
    else:
        return min_cost
print(optimized_Sollution("input.txt"))