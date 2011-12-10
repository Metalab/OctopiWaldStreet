#! /usr/bin/env python

import math

class Rectangle():

  def __init__(self,*variant):
    """
    clockwise
    """
    self.p = variant

  def inside(self,x,y,radius=0):
    for i in range(4):
      if not _point_left_of_line(
           self.p[i*2],
           self.p[i*2+1],
           self.p[(i*2+2)%8],
           self.p[(i*2+3)%8],
           x,
           y
         ):
        return False;
    return True;


def _line_point_distance(Ax,Ay,Bx,By,Px,Py):
  """
  deliveres only the absolute value of the distance

  :param integer Ax: x value of the first line defining point
  :param integer Ay: y value of the first line defining point
  :param integer Bx: x value of the second line defining point
  :param integer By: y value of the second line defining point
  :param integer Px: x value of the third line defining point
  :param integer Py: y value of the third line defining point

  >>> _line_point_distance(1,2,3,2,2,1)
  1

  >>> _line_point_distance(1,2,3,2,2,3)
  1

  """

  #return int( abs(float(Ax-Px)*float(Ay-By)-float(Ax-Bx)*float(Ay-Py)) / math.sqrt( (float(Ax-Px))**2 + (float(Ay-Py))**2 ) )

  return int( abs( (float(Px-Ax)*float(By-Ay)) - (float(Py-Ay)*float(Bx-Ax)) ) / math.sqrt( float(Bx-Ax)**2 + float(By-Ay)**2 ) )



def _point_left_of_line(Ax,Ay,Bx,By,Px,Py):
  """
  >>> _point_left_of_line(1,2,3,2,2,1)
  False

  >>> _point_left_of_line(1,2,3,2,2,3)
  True

  >>> _point_left_of_line(3,2,1,2,2,3)
  False

  >>> _point_left_of_line(3,2,1,2,2,1)
  True

  >>> _point_left_of_line(2,2,4,2,5,1)
  False

    {'Px': 5, 'Py': 1, 'Ay': 2, 'Ax': 4, 'Bx': 4, 'By': 4}
    

  > _point_left_of_line(4,4,2,4,)
    {'Px': 5, 'Py': 1, 'Ay': 4, 'Ax': 4, 'Bx': 2, 'By': 4}

  """

  #print locals()

  return float(Bx-Ax)*float(Py-Ay) - float(By-Ay)*float(Px-Ax) > 0

def __tests():
  """
  >>> Rectangle(2,2,4,2,4,4,2,4).inside(1,1)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(1,3)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(1,5)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(3,1)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(3,3)
  True

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(3,5)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(5,1)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(5,3)
  False

  >>> Rectangle(2,2,4,2,4,4,2,4).inside(5,5)
  False

  """
  pass

if __name__ == '__main__':
  
  import sys
  import doctest
  doctest.testmod()
  print 'testing done ...'
