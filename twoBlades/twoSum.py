def two_sum(nums, target):
    lookup = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in lookup:
            return [lookup[complement], i]
        lookup[num] = i
    return []


target = int(input())
arr  = list(map(int, input().split()))
print(' '.join(map(str, two_sum(arr, target))))



