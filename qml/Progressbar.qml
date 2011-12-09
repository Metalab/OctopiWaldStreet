import QtQuick 1.0

Item {
    property real progress: 0

    Rectangle {
        id: outer
        width: 100
        height: 15
        radius: 8
        color: 'white'
    }

    Rectangle {
        id: inner
        width: outer.width * progress
        color: 'grey'
    }
}
