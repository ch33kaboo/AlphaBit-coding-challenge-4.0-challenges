/* Common Template Starts */
process.stdin.resume()
process.stdin.setEncoding('utf-8')
let inputString = ''
let currentLine = 0

process.stdin.on('data', (inputStdin) => {
  inputString += inputStdin
})

process.stdin.on('end', (_) => {
  inputString = inputString
    .trim()
    .split('\n')
    .map((string) => {
      return string.trim()
    })

  main()
})

function readline() {
  return inputString[currentLine++]
}
/* Common Template Ends */


let caches
let datas
let max_itter, total, data_length
let operande

const fn = (a, b) => {
  return operande == '*'
    ? a * b
    : operande == '+'
    ? a + b
    : operande == 'max'
    ? Math.max(a, b)
    : operande == 'min'
    ? Math.min(a, b)
    : 0
}
const calc = (a, b) => (a < 0 ? a + b : a)

const countNegOnes = (arr) => {
  let counter = 0
  for (element of arr) {
    if (element === -1) {
      counter++
    }
  }
  return counter
}

const sendToNext = (currentProcessRank, dest_rank, dataIndex) => {
  caches[dest_rank] = datas[currentProcessRank][dataIndex]
  datas[currentProcessRank][dataIndex] = -1
}

const share = (currentProcessRank, dest_rank, dataIndex) => {
  datas[dest_rank][dataIndex] = datas[currentProcessRank][dataIndex]
}

const solve = () => {
  let bool
  let j, right, temp, current_itter

  bool = false
  j = 0
  current_itter = 0
  while (!bool && current_itter < max_itter) {
    current_itter++
    for (let rank = 0; rank < total; rank++) {
      right = (rank + 1) % total
      sendToNext(rank, right, calc(rank - j, data_length))
      if (rank != 0) {
        datas[rank][calc(rank - j - 1, data_length)] = fn(
          caches[rank],
          datas[rank][calc(rank - j - 1, data_length)]
        )
      }
      if (rank === total - 1) {
        datas[0][calc(0 - j - 1, data_length)] = fn(
          caches[0],
          datas[0][calc(0 - j - 1, data_length)]
        )
      }
      bool = countNegOnes(datas[rank]) === data_length - 1
    }
    j++
  }

  bool = false
  j = 0
  while (!bool && current_itter < max_itter) {
    current_itter++
    for (let rank = 0; rank < total; rank++) {
      right = (rank + 1) % total
      temp = calc(rank - j + 1, data_length) % data_length
      share(rank, right, temp)
    }
    bool = datas[total - 1].every((e) => e != -1)
    j++
  }
}

const printSolution = () => {
  for (let i = 0; i < total; i++) {
    process.stdout.write(`${i}`)
    for (let j = 0; j < data_length; j++) {
      process.stdout.write(` ${datas[i][j]}`)
    }
    process.stdout.write('\n')
  }
}

function main() {
  operande = readline()
  max_itter = +readline()
  total = +readline()
  caches = new Array(total)
  datas = new Array(total)

  for (let i = 0; i < total; i++) {
    input = readline()
      .split(' ')
      .map(Number)
    datas[input[0]] = input.slice(1)
    caches[input[0]] = datas[input[0]][input[0]]
  }
  data_length = datas[0].length

  solve()
  printSolution()
}
