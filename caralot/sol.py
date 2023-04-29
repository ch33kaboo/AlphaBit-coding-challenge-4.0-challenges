with open('input.txt', 'r') as f:
    n = int(f.readline())
    events = list(map(int, f.readline().split()))


def solve(events):
    if len(events) % 2  == 1 : return -1 ,[-1] #wahed dkhal w makhrejch
    stack =[]  # people entering and leaving in the current day 
    day =[]   # number of people in the office in the current day
    done=[]   # people entered and fuleft the current  day 
    oute_index = [] # nmubr of people who worked the current day * 2
    oute=[]   # dats partition from the events list
    
    for e in events:
        if e not in done :
            if e > 0 and e not in day: # entering 
                day.append(e)
                stack.append(e)
            elif (e < 0) and (-e in day):  #departure
                day.remove(abs(e))
                stack.append(e)
                done.append(abs(e))
                if len(day)==0:  
                    oute.append(stack.copy())
                    del done[:]
                    del day[:]
                    del stack[:]
                    print(oute)
            else : 
                return -1 ,[-1]


    oute_index = [len(num) for num in oute]


    return len(oute), oute_index


n , sol = solve(n, events)