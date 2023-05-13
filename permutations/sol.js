const readline = require("readline").createInterface({
    input: process.stdin,
    output: process.stdout
});

function nperms(n) {
    let arr = [];
    for (let i = 1; i <= n; i++) {
        arr.push(i);
    }
    let perms = permute(arr);
    perms.sort();
    for (let i = 0; i < perms.length; i++) {
        console.log(perms[i].join(''));
    }
}

function permute(arr) {
    let result = [];
    if (arr.length === 0) return [[]];
    for (let i = 0; i < arr.length; i++) {
        const rest = permute(arr.slice(0, i).concat(arr.slice(i + 1)));
        for (let j = 0; j < rest.length; j++) {
            result.push([arr[i]].concat(rest[j]));
        }
    }
    return result;
}

function toString(List) {
    return List.join('');
}


readline.question("", function(n) {
    nperms(parseInt(n));
    readline.close();
});
