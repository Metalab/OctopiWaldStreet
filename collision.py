#! /usr/bin/env python

import math

class Rectangle():

  def __init__(self,*variant):
    """
    clockwise
    """
    self.p = variant

  def inside(self,x,y,radius=64):
    for i in range(4):
      #print "distance:", _line_point_distance(self.p[i*2],self.p[i*2+1],self.p[(i*2+2)%8],self.p[(i*2+3)%8],x,y)
      if _line_point_distance(
           self.p[i*2],
           self.p[i*2+1],
           self.p[(i*2+2)%8],
           self.p[(i*2+3)%8],
           x,
           y
         ) < -radius:
        return False;
    return True;

def __test_Rectangle():
  """
  >>> Rectangle(128,128,128,256,256,256,256,128).inside(192,32)
  False

  >>> Rectangle(128,128,128,256,256,256,256,128).inside(192,100)
  True

  """
  pass


def _line_point_distance(Ax,Ay,Bx,By,Px,Py):
  """

  :param integer Ax: x value of the first line defining point
  :param integer Ay: y value of the first line defining point
  :param integer Bx: x value of the second line defining point
  :param integer By: y value of the second line defining point
  :param integer Px: x value of the third line defining point
  :param integer Py: y value of the third line defining point


  result positive:

        P
         O
         |
  O -----------> O
 A              B


 
  result negative:

  O -----------> O
 A       |      B
         O
        P

  >>> _line_point_distance(1,2,3,2,2,1)
  1.0

  >>> _line_point_distance(1,2,3,2,2,3)
  -1.0

  >>> _line_point_distance(1,2,3,2,2,0)
  2.0

  >>> _line_point_distance(1,2,3,2,2,4)
  -2.0

  """

  #print locals()

  if _point_left_of_line(Ax,Ay,Bx,By,Px,Py):
    return -( abs(float(Ax-Bx)*float(Ay-Py)-float(Ax-Px)*float(Ay-By)) / math.sqrt( (float(Ax-Bx))**2 + (float(Ay-By))**2 ) )
    #return -abs( (float(Px-Ax)*float(By-Ay)) - (float(Py-Ay)*float(Bx-Ax)) ) / math.sqrt( float(Bx-Ax)**2 + float(By-Ay)**2 )
  else:
    return ( abs(float(Ax-Bx)*float(Ay-Py)-float(Ax-Px)*float(Ay-By)) / math.sqrt( (float(Ax-Bx))**2 + (float(Ay-By))**2 ) )
    #return abs( (float(Px-Ax)*float(By-Ay)) - (float(Py-Ay)*float(Bx-Ax)) ) / math.sqrt( float(Bx-Ax)**2 + float(By-Ay)**2 )



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

  return float(Bx-Ax)*float(Py-Ay) - float(By-Ay)*float(Px-Ax) > 0

if __name__ == '__main__':
  
  import sys
  import doctest
  doctest.testmod()
  print 'testing done ...'
