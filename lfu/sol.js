const readline = require("readline").createInterface({ input: process.stdin });

const inputLines = [];
let index = 0;
const limit = 3; // 3 lines

readline.on("line", (line) => {
    inputLines.push(line);
    index++;
    if (index == limit) {
        readline.close();
        const input = {
            capacity: parseInt(inputLines[0]),
            weights: inputLines[1].split(" ").map((val) => parseInt(val)),
            uses: inputLines[2].split(" ").map((val) => parseInt(val)),
        };

        // solution
        let currentCapacity = 0;
        let frequencyMap = Array(6).fill(0); // init frequencies to 0
        for (const itemId of input.uses) {
            if (frequencyMap[itemId] === 0) {
                while (
                    currentCapacity + input.weights[itemId] >
                    input.capacity
                ) {
                    // remove weight of item with least non-zero frequency
                    const minItemId = frequencyMap.indexOf(
                        Math.min(...frequencyMap.filter((x) => x !== 0))
                    );
                    frequencyMap[minItemId] = 0;
                    currentCapacity -= input.weights[minItemId];
                }
                currentCapacity += input.weights[itemId];
            }
            frequencyMap[itemId]++;
        }

        console.log(currentCapacity);
    }
});
