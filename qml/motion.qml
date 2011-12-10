
import Qt 4.7
import QtMultimediaKit 1.1

Rectangle {
    id: root
    width: 640
    height: 480
    clip: true

    Statusbar {
        id: statusBar
        width: parent.width
        z: 1000
    }

    Rectangle {
        id: playField

        x: 0
        y: statusBar.height

        width: parent.width
        height: parent.height - statusBar.height

        color: '#081c1f'

        Tank {
            id: tank
            color: 'blue'
            x: 20
            y: parent.height - height - 20
        }

        Tank {
            id: tank2
            color: 'red'
            x: parent.width - width - 20
            y: parent.height - height - 20
        }

        Timer {
            running: true
            interval: 30
            repeat: true

            onTriggered: {
                tank.rotation += 15*steering.get_steering()

                if (pumping.get_pumping()) {
                    var xDirection = -Math.cos((tank.rotation+90)/180*3.1415);
                    var yDirection = -Math.sin((tank.rotation+90)/180*3.1415);
                    tank.xSpeed = xDirection * 10 * statusBar.firstPumpValue;
                    tank.ySpeed = yDirection * 10 * statusBar.firstPumpValue;
                    statusBar.gotPumpAction(true)
                }

                tank.x += tank.xSpeed;
                tank.y += tank.ySpeed;

                tank.xSpeed *= .9
                tank.ySpeed *= .9

                //statusBar.firstPumpValue = steering.get_trigger()/255
                //statusBar.secondPumpValue = pumping.get_trigger()/255
                statusBar.tick()

                buildingsLayer.mapAllCornerPoints()
            }
        }

        BuildingsLayer {
            id: buildingsLayer
            anchors.fill: parent
        }

    }

    Camera {
        anchors.fill: parent
        opacity: .5
        MouseArea {
            anchors.fill: parent
            onClicked: parent.captureImage()
        }
        onImageCaptured: console.log('captured')
        onImageSaved: console.log(path)
    }

    Component.onCompleted: {
        collisions.set_player(0, tank)
        collisions.set_player(1, tank2)
    }
}

