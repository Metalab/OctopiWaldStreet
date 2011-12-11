import QtQuick 1.0
import Qt.labs.particles 1.0

Fireworkparticle {
    property string currency
    source: 'img/money_' + currency + '.png'
    count: 50
    scale: 1.5
    velocity: -100
    smooth: true
}
