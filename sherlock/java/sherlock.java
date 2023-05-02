class Helloworld{
    public static boolean isValid(String s) {
        int i = 0;
        int j = 0;
        int originI = 0;
        int cpt = 0;
        int previousCmpt = 0;
        boolean result=true;
        char c;
      
        while (i < s.length()) {
            cpt = 0;
            c = s.charAt(i);
            originI = i;
        
            while (j < s.length()) {
                if (s.charAt(j) == c && j != originI) {
                    cpt++;
                }
                j++;
            }
            j = 0;
        
            if (cpt > 1) {
                result = false;
                break;
            } else {
                if (i == 0) {
                    previousCmpt = cpt;
                } else {
                    if (cpt <= previousCmpt) {
                        result = true;
                    } else {
                        result = false;
                    }
                }
            }
            i++;
        }
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println(isValid("lahhhcennxxzy"));
    }
    
    }