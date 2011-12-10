import QtQuick 1.0
import Qt.labs.particles 1.0

Fireworkparticle {
    property string color
    source: 'img/flower_' + color + '.png'
    scale: 0.5
}
