
import QtQuick 1.0

Image {
    property string color
    property real speed: 0

    scale: .5
    smooth: true

    source: 'img/' + color + '-team.png'
}

