import QtQuick 1.0

Item {
    property real progress: 0.4
    width: 120
    height: 20
    property int radius: 8

    Rectangle {
        id: outer
        anchors.fill: parent
        radius: parent.radius
        color: 'black'
        smooth: true
    }

    Rectangle {
        id: inner
        width: parent.width * progress
        height: parent.height
        radius: parent.radius
        color: 'grey'
        smooth: true
    }
}
