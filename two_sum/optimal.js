const readline = require('readline').createInterface({
    input: process.stdin
});

let target;
let arr;

readline.question('Enter target value: ', (value) => {
    target = parseInt(value);
    readline.on('line', (values) => {
        arr = values.split(' ').map(Number);
        twoSumOptimized(arr, target);
        readline.close();
    });
});

const twoSumOptimized = (arr, target) => {
    arr.forEach((iteratorA, indexA) => {
        if (target > iteratorA) {
        arr.forEach((iteratorB, indexB) => {
            if (iteratorB + iteratorA == target) {
                console.log(indexA + " " + indexB);
                process.exit(0);
                }
            });
        }
    });
}
