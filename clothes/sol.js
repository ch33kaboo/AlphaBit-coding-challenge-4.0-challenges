const solve = (n, m,) => {
  if (n < 3 || m < 3) {
    return 'error'
  }
  let prices = f.readline().split(' ').map(Number)
  let matching_costs = Array.from({ length: n }, () =>
    Array.from({ length: n }, () => Infinity)
  )
  for (let i = 0; i < m; i++) {
    let [a, b] = f.readline().split(' ').map(Number)
    matching_costs[a - 1][b - 1] = matching_costs[b - 1][a - 1] = Math.min(
      prices[a - 1],
      prices[b - 1]
    )
  }

  let min_cost = Infinity
  for (let i = 0; i < n; i++) {
    for (let j = i + 1; j < n; j++) {
      if (matching_costs[i][j] == Infinity) {
        continue
      }
      for (let k = j + 1; k < n; k++) {
        if (
          matching_costs[i][k] != Infinity &&
          matching_costs[j][k] != Infinity
        ) {
          min_cost = Math.min(min_cost, prices[i] + prices[j] + prices[k])
        }
      }
    }
  }

  if (min_cost == Infinity) {
    return -1
  } else {
    return min_cost
  }
}

console.log(Infinity)
