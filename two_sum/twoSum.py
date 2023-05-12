def two_sum(nums, target):
    lookup = {}
    pairs = []
    for i, num in enumerate(nums):
        complement = target - num
        if complement in lookup:
            pairs.append([lookup[complement], i])
        lookup[num] = i
    return pairs




arr  = list(map(int, input().split()))

target = int(input())
print("")

print(two_sum(arr, target))
