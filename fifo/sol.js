const readline = require("readline").createInterface({
    input: process.stdin,
});

const input = [];
let index = 0;
const limit = 2;

readline.on("line", (line) => {
    input.push(line);
    index++;
    if (index == limit) {
        readline.close();
        const maxSize = parseInt(input[0]);
        const items = input[1].split(" ").map((val) => parseInt(val));

        let occupiedCapacity = 0;
        let oldestIndex = 0;
        for (const item of items) {
            while (occupiedCapacity + item > maxSize) {
                occupiedCapacity -= items[oldestIndex];
                oldestIndex++;
            }
            occupiedCapacity += item;
        }
        console.log(occupiedCapacity);
        console.log(oldestIndex);
    }
});
