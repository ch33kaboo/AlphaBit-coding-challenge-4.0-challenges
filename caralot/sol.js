const solve = (n, eventsss) => {
  if (parseInt(n) % 2 == 1) return [-1, [-1]] //wahed dkhal w makhrejch
  let stack = [] // people entering and leaving in the current day
  let day = [] // number of people in the office in the current day
  let done = [] // people entered and left the current day
  let oute_index = [] // number of people who worked the current day * 2
  let oute = [] // data partition from the events list

  const events = eventsss.split(' ').map((e) => parseInt(e))
  for (let i = 0; i < events.length; i++) {
    const e = events[i]
    if (done.includes(e)) return [-1, [-1]]
    else {
      //ida wah7ed dkhal wkhrej w bghi y3awed ydkhl same day
      if (e > 0 && !day.includes(e)) {
        // entering
        day.push(e)
        stack.push(e)
      } else if (e < 0 && day.includes(-e)) {
        //departure
        day.splice(day.indexOf(-e), 1)
        stack.push(e)
        done.push(-e)
        if (day.length == 0) {
          oute.push(stack.slice())
          done = []
          day = []
          stack = []
        }
      } else {
        return [-1, [-1]]
      }
    }
  }

  oute_index = oute.map((day) => day.length)
  return [oute.length, oute_index]
}

let n = '6'
let events = '2 5 -5 6 -6 -2'

const sol = solve(n, events)
console.log(`${sol[0]}\n${sol[1].join(' ')}`)
