#!/usr/bin/python
#/**
# * lenken... wenn der motion sensor in der richtigen position gehalen wird
# */

from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *

import sys
import os

#/** sensor werte seit der letzten lenk operation */
sensor_values = []

#/**
# * Damit bekommen wir die sensor updates
# *
# */
def update_sensor(gx, gy, gz):
    global sensor_values
    #fill array with new value
    sensor_values.append((gx,gy,gz))


#/**
# * Hier liefern wir die relative lenkbewegung also die lenkbewegung relativ zur bisherige richtung
# * @return int
# */
def get_rotation():
	#//calculate the new rotation
	#wenn im interval die x componente meistens positiv war dann haben wir eine rechtsdrehung
	#sort sensor values by y component
        global sensor_values
	sensor_values.sort()

	#get the median value
	median = sensor_values[len(sensor_values)/2]


	if median > 0:
		direction = +1
	else:
		direction = -1

	#wenn das hole den maximal wert der liste... evt haben wir so die direktion billig gleich dabei

        X, Y, Z = range(3)

	if direction == -1:
		amplitude = min(sensor_values)[Y]
	else:
		amplitude = max(sensor_values)[Y]

        sensor_values = []

	return direction * amplitude



#/** constant:: if the current ax, ay, az values are smaller than these limits, the position is correct , if the limit is zero, the value is to be ignored */
correct_sensor_position_limits = (0, 700, 0)

current_sensor_position = (0,0,0)#//(ax,ay,az);

#/**
# * 	hier setzen wir die current_sensor_position
# */
def set_current_sensor_position(ax,ay,az):
    global current_sensor_position
    current_sensor_position = (ax,ay,az)

#/**
# * Richtige position anzeigen
# * @return boolean
# */
def position_is_correct():

	cur_x, cur_y, cur_z = map(abs, current_sensor_position)

	limit_x, limit_y, limit_z = correct_sensor_position_limits

	correct = True

	#//wenn der wert igoriert werden soll(limit = 0) oder wenn er innerhalb des limits ist
	if limit_x != 0 and cur_x <= limit_x:
		correct = False

	if limit_y != 0 and cur_y > limit_y:
		correct = False

	if limit_z != 0 and cur_z <= limit_z:
		correct = False


	return correct

import sys

# XXX: Should not hardcode path to the psmove module here
sys.path.insert(0, '/home/thp/src/psmoveapi/build/')

import psmove
move = psmove.PSMove()



while False:
    if move.poll():
        #print move.ax, move.ay, move.az
        update_sensor(move.gx, move.gy, move.gz)
        set_current_sensor_position(move.ax, move.ay, move.az)

        rotation = get_rotation()

        #print current_sensor_position
        if position_is_correct():
            move.set_leds(0, 0, 0)

            if rotation > 400:
                move.set_leds(0, 255, 0)
                print 'RIGHT', rotation
            elif rotation < -400:
                move.set_leds(0, 0, 255)
                print 'LEFT', rotation
        else:
            move.set_leds(255, 0, 0)

        move.update_leds()

class Steering(QObject):
    def __init__(self):
        QObject.__init__(self)

    @Slot(result=int)
    def get_steering(self):
        global move
        result = 0
        move.poll()
        update_sensor(move.gx, move.gy, move.gz)
        set_current_sensor_position(move.ax, move.ay, move.az)

        rotation = get_rotation()

        #print current_sensor_position
        if position_is_correct():
            move.set_leds(0, 0, 0)

            if rotation > 400:
                move.set_leds(0, 255, 0)
                print 'RIGHT', rotation
                result = +1
            elif rotation < -400:
                move.set_leds(0, 0, 255)
                print 'LEFT', rotation
                result = -1
        else:
            move.set_leds(255, 0, 0)

        move.update_leds()
        return result

if __name__ == '__main__':
    app = QApplication(sys.argv)
    steering = Steering()
    view = QDeclarativeView()
    view.rootContext().setContextProperty('steering', steering)
    home = os.path.dirname(__file__)
    view.setSource(os.path.join(home, 'qml', 'motion.qml'))
    view.setResizeMode(QDeclarativeView.SizeViewToRootObject)
    view.show()
    app.exec_()

