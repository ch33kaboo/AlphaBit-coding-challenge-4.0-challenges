const isPossible= (n,p,s) => {
    for(e of p.slice(s[0], s[1])) {
        if(e>=n) return false
    }
    return true
}

let start = performance.now();
n = '150'
p = "130 89 150 73 78 100 122 150 150 150 64 3 0 71"
s = '0 6'
n = +n;
p = p.split(" ").map((e)=>+e);
s = s.split(" ").map((e)=>+e);

console.log(isPossible(n,p,s));
console.log("time in miliseconds: ", (performance.now() - start)/1000)

//weirdly same code takes less time here
let start2 = performance.now();
n = '150'
p = "130 89 150 73 78 100 122 150 150 150 64 3 0 71"
s = '0 6'
n = +n;
p = p.split(" ").map((e)=>+e);
s = s.split(" ").map((e)=>+e);

console.log(isPossible(n,p,s));
console.log("time in miliseconds: ", (performance.now() - start2)/1000)



