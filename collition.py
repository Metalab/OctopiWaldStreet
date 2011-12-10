#! /usr/bin/env python

import math

class Rect():

  def __init__(rect):
    """
    :param integer[4][2] rect: corner points of a rectangle, clockwise
    """
    self.lines = rect

  def inside(x,y,radius):
    pass


def _line_point_distance(x1,y1,x2,y2,x3,y3):
  """
  :param integer x1: x value of the first line defining point
  :param integer y1: y value of the first line defining point
  :param integer x2: x value of the second line defining point
  :param integer y2: y value of the second line defining point
  :param integer x3: x value of the third line defining point
  :param integer y3: y value of the third line defining point

  >>> _line_point_distance(1,1,2,2,1,3)
  1

  """

  #return abs(float(x1-x2)*float(y1-y3)-float(x1-x3)*float(y1-y2)) / math.sqrt( (float(x1-x2))**2 + (float(y1-y2))**2 )
  return int( abs(float(x1-x3)*float(y1-y2)-float(x1-x2)*float(y1-y3)) / math.sqrt( (float(x1-x3))**2 + (float(y1-y3))**2 ) )


def __tests():
  """
  """
  pass

if __name__ == '__main__':
  
  import sys
  import doctest
  doctest.testmod()
  print 'testing done ...'
