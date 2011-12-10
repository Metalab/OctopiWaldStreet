#!/usr/bin/python
#/**
# * lenken... wenn der motion sensor in der richtigen position gehalen wird
# */

from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *

import sys
import os

# XXX: Should not hardcode path to the psmove module here
sys.path.insert(0, '/home/thp/src/psmoveapi/build/')

import psmove

class Controller(QObject):
    # constant:: if the current ax, ay, az values are smaller than these
    # limits, the position is correct , if the limit is zero, the value is to
    # be ignored
    CORRECT_SENSOR_POSITION_LIMITS = (0, 700, 0)

    def __init__(self, id):
        QObject.__init__(self)
        self.id = id
        self.move = psmove.PSMove(id)
        self.sensor_values = []
        self.current_sensor_position = (0, 0, 0)
        self.last_pumping_value = 0

    @Slot(result=int)
    def get_trigger(self):
        self.move.poll()
        return self.move.get_trigger()

    @Slot(result=int)
    def get_pumping(self):
        self.move.poll()
        if abs(self.move.gy) < 100:
            result = 0
        if self.move.gy > 0 and self.last_pumping_value < 0:
            result = 1
        elif self.move.gy < 0 and self.last_pumping_value > 0:
            result = 1
        else:
            result = 0
        self.last_pumping_value = self.move.gy
        return result

    @Slot(result=int)
    def get_steering(self):
        result = 0
        self.move.poll()
        self.update_sensor(self.move.gx, self.move.gy, self.move.gz)
        self.set_current_sensor_position(self.move.ax, self.move.ay,
                self.move.az)

        rotation = self.get_rotation()

        #print current_sensor_position
        if self.position_is_correct():
            self.move.set_leds(0, 0, 0)
            self.move.set_rumble(0)

            if rotation > 400:
                #move.set_leds(0, 255, 0)
                #print 'RIGHT', rotation
                result = 1
            elif rotation < -400:
                #move.set_leds(0, 0, 255)
                #print 'LEFT', rotation
                result = -1
        else:
            self.move.set_leds(255, 0, 0)
            self.move.set_rumble(200)

        self.move.update_leds()
        return result


    def update_sensor(self, gx, gy, gz):
        self.sensor_values.append((gx,gy,gz))

    def get_rotation(self):
        #//calculate the new rotation
        # wenn im interval die x componente meistens positiv war dann haben
        # wir eine rechtsdrehung
        self.sensor_values.sort()

        # get the median value
        median = self.sensor_values[len(self.sensor_values)/2]

        if median > 0:
            direction = 1
        else:
            direction = -1

        # wenn das hole den maximal wert der liste... evt haben wir so die
        # direktion billig gleich dabei
        X, Y, Z = range(3)

        if direction == -1:
            amplitude = min(self.sensor_values)[Y]
        else:
            amplitude = max(self.sensor_values)[Y]

        self.sensor_values = []
        return direction * amplitude

    def set_current_sensor_position(self, ax,ay,az):
        self.current_sensor_position = (ax,ay,az)

    #/**
    # * Richtige position anzeigen
    # * @return boolean
    # */
    def position_is_correct(self):
        cur_x, cur_y, cur_z = map(abs, self.current_sensor_position)
        limit_x, limit_y, limit_z = self.CORRECT_SENSOR_POSITION_LIMITS

        # wenn der wert igoriert werden soll(limit = 0) oder wenn er innerhalb
        # des limits ist
        if limit_x != 0 and cur_x <= limit_x:
            return False

        if limit_y != 0 and cur_y > limit_y:
            return False

        if limit_z != 0 and cur_z <= limit_z:
            return False

        return True

class ZoomingView(QDeclarativeView):
    def __init__(self):
        QDeclarativeView.__init__(self)
        self.setBackgroundBrush(Qt.black)
        self.setRenderHint(QPainter.Antialiasing)
        self.setRenderHint(QPainter.SmoothPixmapTransform)

    def resizeEvent(self, event):
        width, height = event.size().width(), event.size().height()
        dwidth, dheight = 640, 480
        scaleFactor = float(height) / float(dheight)
        rootObject = self.rootObject()
        if rootObject is not None:
            # XXX: This has some optical problems :/ Workarounds?
            rootObject.setScale(scaleFactor)
        return QDeclarativeView.resizeEvent(self, event)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    view = ZoomingView()

    steering = Controller(0)
    view.rootContext().setContextProperty('steering', steering)

    pumping = Controller(1)
    view.rootContext().setContextProperty('pumping', pumping)

    home = os.path.dirname(__file__)
    view.setSource(os.path.join(home, 'qml', 'motion.qml'))
    view.setResizeMode(QDeclarativeView.SizeViewToRootObject)

    if 'fullscreen' in sys.argv:
        view.showFullScreen()
    else:
        view.show()

    app.exec_()

