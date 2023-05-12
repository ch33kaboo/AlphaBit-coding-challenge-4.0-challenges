const readline = require('readline')

const mark = (maze, spots, spins, direction, i_line, i_col) => {
  if (spots === 1) {
    if (spins % 4 === 0) {
      maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
    } else if (spins % 4 === 1) {
      if (direction === 'l') {
        maze[i_line * 2][i_col * 2 + 1] = 'X'
      } else if (direction === 'r') {
        maze[i_line * 2 + 1][i_col * 2] = 'X'
      }
    } else if (spins % 4 === 2) {
      maze[i_line * 2][i_col * 2] = 'X'
    } else if (spins % 4 === 3) {
      if (direction === 'r') {
        maze[i_line * 2][i_col * 2 + 1] = 'X'
      } else if (direction === 'l') {
        maze[i_line * 2 + 1][i_col * 2] = 'X'
      }
    }
  }

  if (spots === 2) {
    if (spins % 4 === 0) {
      maze[i_line * 2][i_col * 2] = 'X'
      maze[i_line * 2][i_col * 2 + 1] = 'X'
    } else if (spins % 4 === 1) {
      if (direction === 'l') {
        maze[i_line * 2][i_col * 2] = 'X'
        maze[i_line * 2 + 1][i_col * 2] = 'X'
      } else if (direction === 'r') {
        maze[i_line * 2][i_col * 2 + 1] = 'X'
        maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      }
    } else if (spins % 4 === 2) {
      maze[i_line * 2 + 1][i_col * 2] = 'X'
      maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
    } else if (spins % 4 === 3) {
      if (direction === 'r') {
        maze[i_line * 2][i_col * 2] = 'X'
        maze[i_line * 2 + 1][i_col * 2] = 'X'
      } else if (direction === 'l') {
        maze[i_line * 2][i_col * 2 + 1] = 'X'
        maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      }
    }
  }

  if (spots === 3) {
    if (spins % 4 === 0) {
      maze[i_line * 2][i_col * 2 + 1] = 'X'
      maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      maze[i_line * 2 + 1][i_col * 2] = 'X'
    } else if (spins % 4 === 1) {
      if (direction === 'l') {
        maze[i_line * 2][i_col * 2] = 'X'
        maze[i_line * 2][i_col * 2 + 1] = 'X'
        maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      } else if (direction === 'r') {
        maze[i_line * 2][i_col * 2] = 'X'
        maze[i_line * 2 + 1][i_col * 2] = 'X'
        maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      }
    } else if (spins % 4 === 2) {
      maze[i_line * 2][i_col * 2] = 'X'
      maze[i_line * 2][i_col * 2 + 1] = 'X'
      maze[i_line * 2 + 1][i_col * 2] = 'X'
    } else if (spins % 4 === 3) {
      if (direction === 'r') {
        maze[i_line * 2][i_col * 2] = 'X'
        maze[i_line * 2][i_col * 2 + 1] = 'X'
        maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      } else if (direction === 'l') {
        maze[i_line * 2][i_col * 2] = 'X'
        maze[i_line * 2 + 1][i_col * 2] = 'X'
        maze[i_line * 2 + 1][i_col * 2 + 1] = 'X'
      }
    }
  }
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
})

const main = async () => {
  const [n, m] = (await new Promise((resolve) => rl.question('', resolve)))
    .split(' ')
    .map(Number)

  const maze = []
  for (let i = 0; i < n; i++) {
    const input = (await new Promise((resolve) => rl.question('', resolve))).split(' ')
    maze.push(input)
  }

  const [nh, mh] = (await new Promise((resolve) => rl.question('', resolve)))
    .split(' ')
    .map(Number)


  const hint = []
  for (let i = 0; i < nh; i++) {
    const input = (
      await new Promise((resolve) => rl.question('', resolve))
    ).split(' ')
    hint.push(input)
  }

  rl.close()

  for (let i_line = 0; i_line < nh; i_line++) {
    for (let i_col = 0; i_col < mh; i_col++) {
      const h = hint[i_line][i_col].split(',')
      const spots = parseInt(h[0])

      const count_left = h.filter((x) => x === 'l').length
      const count_right = h.filter((x) => x === 'r').length

      const spins = Math.abs(count_left - count_right)
      const direction = count_left - count_right > 0 ? 'l' : 'r'
      mark(maze, spots, spins, direction, i_line, i_col)
    }
  }
  
  for (let l of maze) {
    console.log(l.join(' '))
  }
}

main()
