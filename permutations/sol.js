const readline = require("readline").createInterface({
    input: process.stdin,
    output: process.stdout
});

function nperms(n) {
    let a = [];
    for (let i = 1; i <= n; i++) {
        a.push(i.toString());
    }
    permute(a, 0, a.length);
}

function toString(List) {
    return List.join('');
}

function permute(a, l, r) {
    if (l == r) {
        console.log(toString(a));
    } else {
        for (let i = l; i < r; i++) {
            [a[l], a[i]] = [a[i], a[l]];
            permute(a, l + 1, r);
            [a[l], a[i]] = [a[i], a[l]]; // backtrack
        }
    }
}

readline.question("", function(n) {
    nperms(parseInt(n));
    readline.close();
});
