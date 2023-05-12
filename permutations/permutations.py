def nperms (n):
    a = []
    for i in range(1,n+1):
        a.append(str(i))
    return permute(a,0,len(a))


def toString(List):
    return ''.join(List) 

def permute(a, l, r):
    if l == r:
        print(toString(a))
    else:
        for i in range(l, r):
            a[l], a[i] = a[i], a[l]
            permute(a, l+1, r)
            a[l], a[i] = a[i], a[l]  # backtrack


nperms(int(input()))
