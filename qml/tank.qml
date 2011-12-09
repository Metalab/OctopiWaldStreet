import QtQuick 1.0

Item {
    property alias color: rect.color
    property alias rotation: rect.rotation

    Rectangle {
        id: rect
        width: 15
        height: 35
        color: 'blue'
        rotation: 15
        smooth: true
        radius: 5

        border {
            color: 'black'
            width: 2
        }
    }
}
