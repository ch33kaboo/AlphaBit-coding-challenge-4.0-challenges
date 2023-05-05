import sys

class process:
    def __init__(self, rank : int, data : list, cache:int):
        self.rank  = rank
        self.data = data
        self.cache = cache
    
    def __eq__(self, __value: object) -> bool:
        return self == __value

class workers:
    def __init__(self, process_dict : list):
        self.list = []
        for proc in process_dict:
            rank = proc["rank"]
            self.list.append(process(rank = proc["rank"],
                                     data = proc["data"],
                                     cache = proc["data"][rank]))
        self.size = len(self.list)
    
    def get_worker(self, __rank: int):
        return next((x for x in self.list if x.rank == __rank), None)
    
    def send(self, current_process:process, dest:int, index:int):
        next_worker = self.get_worker(dest)
        next_worker.cache = current_process.data[index]
        current_process.data[index] = -1

    def recv(self, current_process:process):
        return current_process.cache
    
    def share(self, current_process:process, dest:int, index:int):
        next_worker = self.get_worker(dest)
        next_worker.data[index] = current_process.data[index]
    
        
    
def ring_all_reduce(function, process_dict : dict, max_iter : int):
    pr_list = workers(process_dict=process_dict)
    size = pr_list.size
    all_reduced = False
    shared = False
    j = 0
    itr = 0
    
    print("="*8+"Share-reduce phase"+"="*8)
    while not all_reduced and itr < max_iter:
        itr += 1
        print(f"iteration : {itr}")
        for r in range(size):
            p = pr_list.get_worker(r)
            rank = p.rank
            right = (rank + 1) % size
            pr_list.send(p, dest=right, index=rank-j)
            if rank != 0:
                recieved = pr_list.recv(p)
                print(f'worker {r} {recieved}+{p.data[rank-j-1]}')
                p.data[rank-j-1] = function(recieved, p.data[rank-j-1])
                print(p.data)
            if rank == size-1:
                first_p = pr_list.get_worker(0)
                recieved = pr_list.recv(first_p)
                print(f'worker {first_p.rank} {recieved}+{first_p.data[0-j-1]}')
                first_p.data[0-j-1] = function(recieved, first_p.data[0-j-1])
                print(first_p.data)
            
            all_reduced = (p.data.count(-1) == len(p.data) - 1)
        j += 1
        print("="*24)

    # Share-only phase
    print("="*8+"Share-only phase"+"="*8)
    k=0
    while not shared and itr < max_iter:
        itr += 1
        print(f"iteration : {itr}")
        for r in range(size):
            p = pr_list.get_worker(r)
            rank = p.rank
            right = (rank + 1) % size
            idx = (rank+1-k) % len(p.data)
            pr_list.share(p, dest=right, index=idx)
        for r in range(size):
            pr = pr_list.get_worker(r)
            print(f'worker {r}: {pr.data}')

        shared = all(val != -1 for val in p.data)
            # print(shared)
        k += 1
        print("="*23)
    
    return pr_list


def main():
    # redirect the standard input to a file
    # sys.stdin = open('/Users/abdelkrimzitouni/coding-challenge-4.0-challenges/great-search/input.txt', 'r')

    operation = str(input())

    max_iter = int(input())
    # read in the number of arrays
    n = int(input())

    # allocate memory for the arrays
    workers_list = []
    # read in each array
    for i in range(n):
        # read in the array length and values
        m, *values = map(int, input().split())
        # add the array to the list of arrays
        workers_list.append({})
        workers_list[i]['rank'] = m
        workers_list[i]['data'] = values
        

    def fn(a, b):
        if operation == "+":
            return a+b
        elif operation == "*":
            return a*b
        elif operation == "min":
            return min(a, b)
        elif operation == "max":
            return max(a, b)

    p_list = ring_all_reduce(fn, workers_list, max_iter)
    print("\n"+"="*8+"Results"+"="*8)
    for r in range(len(p_list.list)):
        p = p_list.get_worker(r)
        print(f"{r} {' '.join(str(d) for d in p.data)}")

if __name__ == "__main__":
    main()



