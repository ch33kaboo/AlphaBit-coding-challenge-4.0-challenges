let resistances = "(10, [20, 30])";

function calceRes(str) {
	let isSerie = false;
	total = 0;
	for (i in str) {
		i = str[i];
		if (i == "s") {
			isSerie = true;
		}
		else if (typeof(i) == "number"){
			total += isSerie ? i : 1 / i;
		}
		else {
			total += isSerie ? calceRes(i) : 1 / calceRes(i);
		}
	}	
	return isSerie ? total : 1 / total;
}

function stupid(str) {
	return calceRes(JSON.parse(str.split("(").join("[\"s\", ").split(")").join("]")));
}

//result
console.log(stupid(resistances));