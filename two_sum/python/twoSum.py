def twoSumOptimized(array, target):
    
    lookup = {}
        
    for i in range(len(array)):

        complement = target - array[i]
            
        if complement in lookup:

            return lookup[complement], i
                
              
        lookup[array[i]] = i
            

    return None
