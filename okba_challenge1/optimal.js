let myString = 'YzA}Q45TTjdhbs*>lp0ouleE'

function stupid (str) {
    let capitalVowels = "",
    smallDiv4 = "",
    capitalContstantes = "",
    capitalDiv4 = "",
    digits = "",
    symboles = "",
    smallVowels = "",
    smallConstantes = "";

    for (let index = 0; index < str.length; index++) {
        switch (true) {
            case ('AEIOUY'.includes(str[index])):
                capitalVowels += str[index];
                break;

            case ('dhlptx'.includes(str[index])):
                smallDiv4 += str[index];
                break;

            case ('BCDFGHJKLMNOPQRSTVWXZ'.includes(str[index])):
                capitalContstantes += str[index];
                break;

            case ('DHLPTX'.includes(str[index])):
                capitalDiv4 += str[index];
                break;

            case ('0123456789'.includes(str[index])):
                digits += str[index];
                break;

            case ('!@#$%^&*()_+/\\][{}":;`<>?\''.includes(str[index])):
                symboles += str[index];
                break;

            case ('aeiouy'.includes(str[index])):
                smallVowels += str[index];
                break;

            case ('bcdfghjklmnpqrstvwxz'.includes(str[index])):
                smallConstantes += str[index];
                break;
        }
    }

    return capitalVowels + smallDiv4 + capitalContstantes + capitalDiv4 + digits + symboles + smallVowels + smallConstantes; 
}

//result
let rl = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
  });
  
rl.question("", (myString) => {
    console.log(stupid(myString));
    rl.close();
});
