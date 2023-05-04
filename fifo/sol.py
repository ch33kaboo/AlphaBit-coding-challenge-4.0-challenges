max_size = int(input())
items = list(map(int, input().split()))

occupied_size = 0
oldest_item_index = 0
for item in items:
    while (occupied_size + item > max_size):
        occupied_size -= items[oldest_item_index]
        oldest_item_index += 1
    
    occupied_size += item

print(occupied_size)
print(oldest_item_index)