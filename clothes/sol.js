const solve = (first, pricesString, matches) => {
  const [n, m] = first.split(' ').map(Number)
  if (n < 3 || m < 3) {
    return -1
  }
  const prices = pricesString.split(' ').map(Number)
  const matching_costs = Array.from({ length: n }, () =>
    Array.from({ length: n }, () => Infinity)
  )
  for (let i = 0; i < m; i++) {
    const [a, b] = matches[i].split(' ').map(Number)
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

const first = '3 2'
const pricesString = '2 3 4'
const matches = ['2 3', '2 1']

console.log(solve(first, pricesString, matches))
