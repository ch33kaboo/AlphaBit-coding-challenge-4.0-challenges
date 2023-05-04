const readline = require("readline").createInterface({ input: process.stdin });

const input = {
    matrix: [],
    str: "",
};

let index = 0;
let dimensions = [];

readline.on("line", (line) => {
    if (index == 0) input.str = line
    else if (index == 1) dimensions = line.split(" ").map(val => parseInt(val))
    else if (index < 2 + dimensions[0] - 1)
        input.matrix.push(line)
    else {
        readline.close();
        const { matrix, str } = input;
        const rows = matrix.length;
        const cols = matrix[0].length;

        for (let i = 0; i < rows; i++) {
            if (checkHorizontal(matrix, str, i)) {
                console.log(`row ${i + 1}`);
                return;
            }
        }

        for (let i = 0; i < cols; i++) {
            if (checkVertical(matrix, str, i)) {
                console.log(`col ${i + 1}`);
                return;
            }
        }

        console.log("none");
    }
    index++;
});
// utility functions
function reverseString(str) {
    return str.split("").reverse().join("");
}

function getColumn(matrix, colNumber) {
    return matrix.map((row) => row[colNumber]).join("");
}

// helper functions
function checkHorizontal(matrix, str, pos) {
    const row = Math.floor(pos / matrix.length);
    const right = matrix[row].repeat(2);
    const left = reverseString(matrix[row]).repeat(2);

    return right.search(str) != -1 || left.search(str) != -1;
}

function checkVertical(matrix, str, pos) {
    const col = pos % matrix[0].length;
    const bottom = getColumn(matrix, col).repeat(2);
    const up = reverseString(getColumn(matrix, col)).repeat(2);

    return bottom.search(str) != -1 || up.search(str) != -1;
}
