#import time

def solve(n, p, s):
    for i in p[s[0]:s[1]]:
        if(i>=n) :
            return "false"
    return "true"

n = input()
p = input()
s = input()
n = int(n)
p = list(map(int, p.split(" ")))
s = list(map(int, s.split(" ")))
#start = time.time()
print(solve(n,p,s))
#end = time.time()-start
#print("exec time : ", end-start)