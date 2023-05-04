n = int(input())
s = list(map(int, input().split()))
p = list(map(int, input().split()))

for i in range(s[0],s[1]):
        if(p[i]==n) : 
            print("false")
            exit()
print("true")