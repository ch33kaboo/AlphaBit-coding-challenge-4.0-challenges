import time

def isPossible(n, p, s):
    for i in range(s[0],s[1]):
        if(p[i]==n) : 
            return False
    return True

def isPossible2(n, p, s):
    for i in p[s[0]:s[1]]:
        if(i==n) : 
            return False
    return True

def isPossible3(n, p, s):
    return all(i<n for i in p[s[0]:s[1]])

start = time.time()
n = '150'
p = '130 89 150 73 78 100 122 150'
s = '0 6'
n = int(n)
p = list(map(int, p.split(" ")))
s = list(map(int, s.split(" ")))

print(isPossible(n,p,s))
end1 = time.time()-start
print("time : ", end1)

start = time.time()
n = '150'
p = '130 89 150 73 78 100 122 150'
s = '0 6'
n = int(n)
p = list(map(int, p.split(" ")))
s = list(map(int, s.split(" ")))

print(isPossible2(n,p,s))
end2 = time.time()-start
print("time diff : ", end2-end1)


start = time.time()
n = '150'
p = '130 89 150 73 78 100 122 150 150 150 64 3 0 71'
s = '3 10'
n = int(n)
p = list(map(int, p.split(" ")))
s = list(map(int, s.split(" ")))

print(isPossible3(n,p,s))
end3 = time.time()-start
print("time diff : ", end3-end2)