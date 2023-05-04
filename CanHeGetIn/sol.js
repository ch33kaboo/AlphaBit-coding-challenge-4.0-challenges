const readline = require('readline').createInterface({
    input : process.stdin,
})

const input = [];
let index = 0;
const limit = 3;

readline.on('line', line => {
    input.push(line);
    index++;
    if (index == limit) {
        readline.close()
        const n = parseInt(input[0]);
        const s = input[1].split(" ").map(val => parseInt(val))
        const p = input[2].split(" ").map(val => parseInt(val))
        
        for(e of p.slice(s[0], s[1])) {
            if(e>=n) {
                console.log("false")
                return;
            }
        }
        console.log("true")
    } 
})

