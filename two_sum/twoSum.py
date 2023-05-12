def two_sum(nums, target):
    lookup = {}
    pairs = []
    for i, num in enumerate(nums):
        complement = target - num
        if complement in lookup:
            pairs.append([lookup[complement], i])
        lookup[num] = i
    return pairs



target = int(input())
arr  = list(map(int, input().split()))

print(two_sum(arr, target))
