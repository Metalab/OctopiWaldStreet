import QtQuick 1.0
import Qt.labs.particles 1.0

Particles {
    y: parent.height/2
    x: parent.width/2
    width: 5
    height: 5
    lifeSpan: 2000
    count: 7
    angle: 0
    angleDeviation: 360
    velocity: -150
}
