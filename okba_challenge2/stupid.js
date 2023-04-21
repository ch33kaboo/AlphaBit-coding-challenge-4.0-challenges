const volumes = '13GB 13gb 1b 1B' //B BYTE and b bit


function stupid (str) {
    let arr = [];
    str.split(' ').forEach((ele) => {
        const beforeLastChar = ele.charCodeAt(ele.length-2);
        if (ele.includes('b')){//if it's a bit
            if (beforeLastChar>=48 && beforeLastChar<=57) { 
                arr.push(Number.parseInt(ele.slice(0, -1)) / 8); //check the before last character if it's K/G/T/K or number
            } else {
                switch (ele[ele.length-2].toUpperCase()) {
                    case 'K'://kilo
                        arr.push(2**10 * Number.parseInt(ele.slice(0, -2)) * 1/8);
                        break;
                        
                    case 'M'://mega
                        arr.push(2**20 * Number.parseInt(ele.slice(0, -2)) * 1/8);
                        break;
    
                    case 'G'://giga
                        arr.push(2**30 * Number.parseInt(ele.slice(0, -2)) * 1/8);
                        break;
    
                    case 'T'://tera
                        arr.push(2**40 * Number.parseInt(ele.slice(0, -2)) * 1/8);
                        break;
                }
            }
        } else { //it's a byte
            if (beforeLastChar>=48 && beforeLastChar<=57) { 
                arr.push(Number.parseInt(ele.slice(0, -1))); //check the before last character if it's K/G/T/K or number
            } else {
                switch (ele[ele.length-2].toUpperCase()) {
                    case 'K'://kilo
                        arr.push(2**10 * Number.parseInt(ele.slice(0, -2)));
                        break;
                        
                    case 'M'://mega
                        arr.push(2**20 * Number.parseInt(ele.slice(0, -2)));
                        break;
    
                    case 'G'://giga
                        arr.push(2**30 * Number.parseInt(ele.slice(0, -2)));
                        break;
    
                    case 'T'://tera
                        arr.push(2**40 * Number.parseInt(ele.slice(0, -2)));
                        break;
                }
            }
        }
    });
    return arr;
}

//result
console.log(stupid(volumes));