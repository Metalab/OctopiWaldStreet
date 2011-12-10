
import QtQuick 1.0

Image {
    property string color
    scale: .5
    smooth: true

    source: 'img/' + color + '-team.png'
}

