#!/usr/bin/env python3

import sys

def population(n,k):
    """
    return the population on n(1<= n <= 10000) days with reproduction rate k(1<k<100000)
    initial population is 1, the organism can reproduce asexually,and the offspring
    come out after 2 days.
    """
    if n == 1:
        return 1 
#initial a population list,start with population size = 1  
    population_list = [0] * n
    population_list[0] = 1
    population_list[1] = 1
    for i in range(2,n):
           offspring = population_list[i-2]*k
           population_list[i] = population_list[i-1]+offspring
    return population_list[n-1]

if __name__ == "__main__":
    arg_count = len(sys.argv)-1
    if arg_count <2:
        raise Exception("This script requires at least 2 arguments")
    n = int(sys.argv[1])
    k = int(sys.argv[2])
    if n not in range(1,10001):
        sys.exit("n must be larger than 0 and less than 10000")
    elif k not in range(1,10001):
        sys.exit("k must be larger than 0 and less than 10000")
    pop = population(n,k)
    print(pop)
#add comma when the number is large
    #if (pop > 10000):
        #print("{:,}".format(pop))

