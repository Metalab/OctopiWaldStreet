
import Qt 4.7

Item {
    width: 128 + 100
    height: 128 + 100

    Rectangle {
        anchors.fill: parent
        color: 'black'
    }

    Item {
        x: 50
        y: 50

        Tank { id: tank; scale: 1; particlestrength: 0; rotation: cloud.phase * 100 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: tank.cloudOpacity = 1 - tank.cloudOpacity
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        color: 'white'
        text: 'click it to toggle the cloud'
    }
}

