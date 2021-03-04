#!/usr/bin/env python3

import math

class Circle():
    """ 
    A class called circle with 2 attributes
    """
    def __init__(self, color, radius):
        self.color = color
        self.radius = radius

    def diameter(self):
        return 2 * self.radius
    
    def circumfrence(self):
        return math.pi * self.diameter()

    def isRed(self):
        if self.color is "red":
            return True
        
Circle_1 = Circle("red", 30)

print(Circle_1.diameter())
print(Circle_1.isRed())
print("{:.2f}".format(Circle_1.circumfrence()))

class GraduateStudent():
    """
    A class called GraduateStudent with 3 attributes
    """
    def __init__(self, first_name, last_name, year, major):
        self.first_name = first_name
        self.last_name = last_name
        self.year = year
        self.major = major

    def year_matriculated(self):
        return 2020 - self.year

student_1 = GraduateStudent("Hang", "Yin", 2019, "Bioinformatics")
print(student_1.year_matriculated())
