import QtQuick 1.0

Item {
    id: statusBar

    property real firstPumpValue: .7
    property real secondPumpValue: .2

    property real firstPumpFrequency: 1
    property real secondPumpFrequency: 1

    property real firstPumpFrequencyTarget: 1
    property real secondPumpFrequencyTarget: 1

    width: 600
    height: 80

    property real time: 0

    function gotPumpAction(isFirst) {
        if (isFirst) {
            if (firstPumpValue > .5) {
                firstPumpFrequencyTarget *= 1.1
                if (firstPumpFrequencyTarget > 2) {
                    firstPumpFrequencyTarget = 2
                } else if (firstPumpFrequencyTarget < .7) {
                    firstPumpFrequencyTarget = .7
                }
            } else {
                firstPumpFrequencyTarget *= .5
            }
        } else {
            // TODO
        }
    }

    function tick() {
        time += .05

        firstPumpFrequency = firstPumpFrequency * .9 + firstPumpFrequencyTarget * .1
        secondPumpFrequency = secondPumpFrequency * .9 + secondPumpFrequencyTarget * .1

        firstPumpValue = Math.abs(Math.sin(time*firstPumpFrequency))
        secondPumpValue = Math.abs(Math.sin(time*secondPumpFrequency))
    }

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
                color: (statusBar.firstPumpValue > .5)?'green':'red'
                Behavior on color { ColorAnimation { duration: 500 } }
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
                color: (statusBar.secondPumpValue > .5)?'green':'red'

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
