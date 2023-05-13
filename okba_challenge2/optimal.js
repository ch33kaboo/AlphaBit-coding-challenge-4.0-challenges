const volumes = "5b 5B 3TB 2Tb" //B BYTE and b bit


function toArrayOfBytes(str) {
    let isBit, //false bit, true byte
    convertCoefficient, //depends if it's giga, tera, ...
    stringValue, //string value parsed to integer
    arr = [];

    str.split(' ').forEach((ele) => {
        convertCoefficient = 1;
        stringValue = 0;
        isBit = ele.includes('b'); //if it's a bit true else false it's a byte
        const beforeLastChar = ele.charCodeAt(ele.length-2);
        if (!(beforeLastChar>=48 && beforeLastChar<=57)) { //check the before last character if it's K/G/T/K or number
            stringValue = Number.parseInt(ele.slice(0, -2));
            switch (ele[ele.length-2].toUpperCase()) {
                case 'K'://kilo
                    convertCoefficient = 2**10;
                    break;
                    
                case 'M'://mega
                    convertCoefficient = 2**20;
                    break;

                case 'G'://giga
                    convertCoefficient = 2**30;
                    break;

                case 'T'://tera
                    convertCoefficient = 2**40;
                    break;
            } 
        } else {
            stringValue = Number.parseInt(ele.slice(0, -1));
        }
        arr.push((isBit) ? convertCoefficient * stringValue * 1/8 : convertCoefficient * stringValue);
    })  
      
    return arr.join(' ');
}


let rl = require('readline').createInterface({
    input: process.stdin
  });
  
rl.on("line", (volumes) => {
    rl.close();
    console.log(toArrayOfBytes(volumes));
});
