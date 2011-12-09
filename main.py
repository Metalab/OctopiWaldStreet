#!/usr/bin/python
# -*- coding: utf-8 -*-
# OctopiWaldStreet

from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *

import sys
import os

if __name__ == '__main__':
    app = QApplication(sys.argv)
    view = QDeclarativeView()
    home = os.path.dirname(__file__)
    view.setSource(os.path.join(home, 'qml', 'index.qml'))
    view.setResizeMode(QDeclarativeView.SizeViewToRootObject)
    view.show()
    app.exec_()

