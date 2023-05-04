def naiive_sollution(input_file):
    n, m = map(int, input().split())
    if (n < 3) or ( m < 3) : return -1 
    prices = list(map(int, input().split()))
    matches = [set() for _ in range(n)]
    for _ in range(m):
        u, v = map(int, input().split())
        matches[u-1].add(v-1)
        matches[v-1].add(u-1)

    #Parsing 
    min_cost = float('inf')
    for i in range(n):
        for j in matches[i]:
            for k in matches[i].intersection(matches[j]):
                    cost = prices[i] + prices[j] + prices[k]
                    if cost < min_cost:
                        min_cost = cost


    if min_cost == float('inf'):
            return -1
    else:
            return str(min_cost) 
print(naiive_sollution('input.txt'))