def two_sum(nums, target):
    lookup = {}
    pairs = []
    for i, num in enumerate(nums):
        complement = target - num
        if complement in lookup:
            pairs.append([lookup[complement], i])
        lookup[num] = i
    return pairs


print("Enter elements of the array separated by space: ")

arr  = list(map(int, input().split()))

target = int(input("Enter The Target "))
print("")

print(two_sum(arr, target))
