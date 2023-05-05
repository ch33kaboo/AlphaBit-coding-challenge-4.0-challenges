let resistances = "(5, 8, 9, [10, 24])";

function optimal(net) {
	const serie = (...args) => args.reduce((acc,cur) => acc + cur, 0);
	const parallel = (...args) => 1 / (args.reduce((acc, cur) => acc + 1/cur, 0));

	return eval(net.replace(/\(/g, 'serie(').replace(/\[/g, 'parallel(').replace(/\]/g, ')'));
}

//result
let rl = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question("", (resistances) => {
	console.log(optimal(resistances).toFixed(2));
   rl.close();
});
