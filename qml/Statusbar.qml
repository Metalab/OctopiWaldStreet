import QtQuick 1.0

Item {
    id: statusBar

    property real firstPumpValue: .7
    property real secondPumpValue: .2

    width: 600
    height: 80

    Rectangle {
        id: rect
        color: 'black'
        radius: 7
        anchors.fill: parent

        Text {
            id: firstPlayer
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.leftMargin: 15
            text: 'Team HypoReal'
            font.pixelSize: 20
            color: 'white'
        }

        Item {
            id: fistPumpBar
            anchors.top: firstPlayer.bottom
            anchors.margins: 8

            Text {
                id: firstPumpText
                text: 'Pump'
                anchors.left: parent.left
                anchors.leftMargin: 5
                color: 'white'
            }

            Progressbar {
                anchors.left: firstPumpText.right
                anchors.leftMargin: 5
                width: 180
                progress: statusBar.firstPumpValue
            }
        }

        Text {
            id: secondPlayer
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.rightMargin: 15
            text: 'Team Bawag'
            font.pixelSize: 20
            color: 'white'
        }

        Item {
            id: secondPumpBar
            anchors.top: secondPlayer.bottom
            anchors.right: parent.right
            anchors.margins: 8

            Progressbar {
                progress: statusBar.secondPumpValue
                scale: -1 // mirror it

                anchors.rightMargin: 5
                width: 180
                anchors.right: secondPumpText.left
            }

            Text {
                id: secondPumpText
                text: 'Pump'
                anchors.right: parent.right
                anchors.leftMargin: 5
                color: 'white'
            }
        }
    }
}
