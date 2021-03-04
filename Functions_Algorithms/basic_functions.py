#!/usr/bin/env python
#basic_function.py
#write docstrings!

def multiply(a,b):
    """
    returns the product of a and b
    """
    return a * b
x = multiply(5,10)
print("The value of x is {}".format(x))

def hello_name(name = None):
    if name:
        """
        returns Hello, name!
        """
        return "Hello, {}!".format(name)
    else:
        """
        retirns Hello, you!
        """
        return "Hello, you!"
print(hello_name("MotherEarth"))
print(hello_name())

def less_than_ten(list_numbers):
    numbers = []
    for number in list_numbers:
        if number < 10:
            numbers.append(number)
    """
    returns a list of numbers less than 10
    """
    return numbers
print(less_than_ten([1, 5, 81, 10, 8, 2, 102]))
