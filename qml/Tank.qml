
import QtQuick 1.0

Image {
    property string color
    property real xSpeed: 0
    property real ySpeed: 0

    scale: .5
    smooth: true

    function centerPoint() {
        return mapToItem(root, width/2, height/2);
    }

    source: 'img/' + color + '-team.png'
}

