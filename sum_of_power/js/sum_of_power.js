let array1 = [];
let array2 = [];

function findRacines(n) {
  if (n == 0 || n == 1 || n == 2 || n == 3) {
    return String(n);
  } else {
    let a = parseInt(Math.sqrt(n));
    let b = n - Math.pow(a, 2);
    array1.push(a);
    array2.push(b);
    findRacines(a);
    
      
      findRacines(b);
    
  }
}

findRacines(20)
console.log(array1);
console.log(array2);