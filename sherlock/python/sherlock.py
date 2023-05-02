def is_valid(s):
    i = 0
    j = 0
    origin_i = 0
    cpt = 0
    previous_cpt = 0
    result = True
    c = ''
  
    while i < len(s):
        cpt = 0
        c = s[i]
        origin_i = i
  
        while j < len(s):
            if s[j] == c and j != origin_i:
                cpt += 1
            j += 1
        j = 0
  
        if cpt > 1:
            result = False
            break
        else:
            if i == 0:
                previous_cpt = cpt
            else:
                if cpt <= previous_cpt:
                    result = True
                else:
                    result = False
            previous_cpt = cpt
        i += 1
    return result
  
print(is_valid('lahcenxzy'))