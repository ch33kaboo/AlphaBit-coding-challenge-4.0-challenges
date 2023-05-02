function IsValid(s) {
    let i = 0;
    let j = 0;
    let originI = 0;
    let cpt = 0;
    let previousCmpt=0;
    let result;
    let c;
  
    while (i < s.length) {
      cpt = 0;
      c = s.charAt(i);
      originI = i;
  
      while (j < s.length) {
        if (s.charAt(j) === c && j !== originI) {
          cpt++;
        }
        j++;
      }
      j = 0;
  
      if (cpt > 1) {
        result = false;
        break;
      }else{
          if(i==0){
              previousCmpt=cpt;
          }else{
              if(cpt<=previousCmpt){
                  //true 
                  result=true
              }else{
                  result=false;
              }
          }
      }
      i++;
    }
    return result;
  }
  
  console.log(IsValid('laahcceenxzzy'));
