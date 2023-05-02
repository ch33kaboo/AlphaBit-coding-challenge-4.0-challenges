const readline = require('readline')

const solve = (n, p, s) => {
  for (e of p.slice(s[0], s[1])) {
    if (e >= n) return 'false'
  }
  return 'true'
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
})

rl.question('', (n) => {
  rl.question('', (p) => {
    rl.question('', (s) => {
      //let start = performance.now();
      n = +n
      p = p.split(' ').map((e) => +e)
      s = s.split(' ').map((e) => +e)
      console.log(solve(n, p, s))
      //console.log("time in miliseconds: ", (performance.now() - start)/1000)
      rl.close()
    })
  })
})

