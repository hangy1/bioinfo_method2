#!/usr/bin/env python3
#hello_you.py

import sys
def hello_name(name = None):
    """
    print "Hello, sys.argv[1]!" or print "Hello, you!" when there is no system argument
    """
    if name:
        return "Hello, {}!".format(name)
    else:
        return "Hello, you!"

if __name__ == "__main__" :
    if len(sys.argv) == 1:
        print(hello_name())
    elif len(sys.argv) > 1:
        print(hello_name(sys.argv[1]))
