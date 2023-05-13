def optimal(net):
    def serie(*args):
        return sum(args)
    def parallel(*args):
        return 1 / sum(1/cur for cur in args)

    return eval(net.replace('(', 'serie(').replace('[', 'parallel(').replace(']', ')'))

# result
resistances = input("")
print("{:.2f}".format(optimal(resistances)))
