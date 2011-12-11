
import Qt 4.7
import QtMultimediaKit 1.1

Rectangle {
    id: root
    width: 640
    height: 480
    clip: true

    state: 'playing'

    states: [
        State {
            name: 'playing'
        },
        State {
            name: 'finished'
        }
    ]

    Statusbar {
        id: statusBar
        width: parent.width
        z: 1000

        firstPoints: tank.points
        secondPoints: tank2.points
    }

    Rectangle {
        id: playField

        x: 0
        y: statusBar.height

        width: parent.width
        height: parent.height - statusBar.height

        //color: '#081c1f'
        color: '#778899'

        Camera {
            id: sneakyCam
            property variant imagePaths: []

            anchors.fill: parent
            anchors.topMargin: -statusBar.height
            opacity: .5
            MouseArea {
                anchors.fill: parent
                onClicked: parent.captureImage()
            }

            Timer {
                running: root.state == 'playing'
                onTriggered: sneakyCam.captureImage()
                interval: 3000
                repeat: true
            }

            onImageCaptured: console.log('captured')
            onImageSaved: {
                console.log('smile(d)!')
                //console.log(path)
                sneakyCam.imagePaths = sneakyCam.imagePaths.concat([path]);
                for (var i in sneakyCam.imagePaths) {
                    //console.log('' + i + ': ' + sneakyCam.imagePaths[i])
                }
            }
        }

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
            running: root.state == 'playing'
            interval: 30
            repeat: true

            onTriggered: {
                var rotation_step = 10
                // PLAYER 1
                tank.cloudOpacity = steering1.get_trigger() / 256
                tank.rotation += rotation_step*steering1.get_steering()

                if (pumping1.get_pumping()) {
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

                // PLAYER 2
                tank2.cloudOpacity = steering2.get_trigger() / 256
                tank2.rotation += rotation_step*steering2.get_steering()

                if (pumping2.get_pumping()) {
                    var xDirection = -Math.cos((tank2.rotation+90)/180*3.1415);
                    var yDirection = -Math.sin((tank2.rotation+90)/180*3.1415);
                    tank2.xSpeed = xDirection * 10 * statusBar.secondPumpValue;
                    tank2.ySpeed = yDirection * 10 * statusBar.secondPumpValue;
                    statusBar.gotPumpAction(false)
                }

                tank2.x += tank2.xSpeed;
                tank2.y += tank2.ySpeed;

                tank2.xSpeed *= .9
                tank2.ySpeed *= .9

                statusBar.tick()
                buildingsLayer.mapAllCornerPoints()
            }
        }

        BuildingsLayer {
            id: buildingsLayer
            anchors.fill: parent
        }

    }

    Timer {
        interval: 60000 // That's the duration of the game in milliseconds
        running: true
        onTriggered: {
            console.log('finished')
            root.state = 'finished'
        }
    }

    Image {
        id: bestShots
        property int shotIndex: 0
        visible: root.state == 'finished'

        Timer {
            running: parent.visible
            interval: 100
            repeat: true

            onTriggered: {
                bestShots.shotIndex = bestShots.shotIndex + 1
                bestShots.source = '../' + sneakyCam.imagePaths[bestShots.shotIndex%sneakyCam.imagePaths.length];
            }
        }
    }

    Component.onCompleted: {
        collisions.set_player(0, tank)
        collisions.set_player(1, tank2)
    }
}

