
import Qt 4.7
import QtMultimediaKit 1.1

Rectangle {
    id: root
    width: 640
    height: 480
    clip: true
    color: 'black'

    state: 'finished'

    states: [
        State {
            name: 'intro'
        },
        State {
            name: 'playing'
        },
        State {
            name: 'finished'
        }
    ]

    Image {
        anchors.centerIn: parent
        source: 'img/octopi.png'
    }

    Statusbar {
        id: statusBar
        visible: playField.visible
        width: parent.width
        z: 1000

        firstPoints: tank.points
        secondPoints: tank2.points

        Text {
            anchors.centerIn: parent
            color: 'white'
            font.pixelSize: 40
            font.bold: true
            text: gameTimeTimer.remainingSeconds
        }
    }

    Connections {
        target: collisions
        onBounce: crashSound1.play()
    }

    SoundEffect {
        id: startingSound
        source: 'snd/car-accelerate.wav'
        volume: .5
    }

    SoundEffect {
        id: crashSound1
        source: 'snd/crash1.wav'
        volume: .5
    }

    Rectangle {
        id: playField
        visible: root.state == 'playing'

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
            initialX: 20
            initialY: parent.height - height - 20
        }

        Tank {
            id: tank2
            color: 'red'
            initialX: parent.width - width - 20
            initialY: parent.height - height - 20
        }

        Timer {
            running: true
            interval: 30
            repeat: true

            onTriggered: {
                if (root.state == 'playing') {
                    playing_iteration()
                } else if (root.state == 'finished') {
                    finished_iteration()
                }
            }

            function finished_iteration() {
                if (pumping1.move_button_pressed() && pumping2.move_button_pressed()) {
                    // reset everything and start a new game
                    sneakyCam.imagePaths = []
                    tank.reset()
                    tank2.reset()
                    statusBar.reset()
                    root.state = 'playing'
                    collisions.reset_internal_state()
                    gameTimeTimer.start_game()
                }
            }

            function playing_iteration() {
                var rotation_step = 10
                // PLAYER 1

                //tank.cloudOpacity = steering1.get_trigger() / 256
                tank.rotation += rotation_step*steering1.get_steering(0)

                if (pumping1.get_pumping()) {
                    var xDirection = -Math.cos((tank.rotation+90)/180*3.1415);
                    var yDirection = -Math.sin((tank.rotation+90)/180*3.1415);
                    tank.xSpeed = xDirection * 10 * statusBar.firstPumpValue;
                    tank.ySpeed = yDirection * 10 * statusBar.firstPumpValue;
                    statusBar.gotPumpAction(true)
                    startingSound.play()
                }

                tank.x += tank.xSpeed;
                tank.y += tank.ySpeed;

                tank.xSpeed *= .9
                tank.ySpeed *= .9

                // PLAYER 2
                //tank2.cloudOpacity = steering2.get_trigger() / 256
                tank2.rotation += rotation_step*steering2.get_steering(1)

                if (pumping2.get_pumping()) {
                    var xDirection = -Math.cos((tank2.rotation+90)/180*3.1415);
                    var yDirection = -Math.sin((tank2.rotation+90)/180*3.1415);
                    tank2.xSpeed = xDirection * 10 * statusBar.secondPumpValue;
                    tank2.ySpeed = yDirection * 10 * statusBar.secondPumpValue;
                    statusBar.gotPumpAction(false)
                    startingSound.play()
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
        id: gameTimeTimer
        property int defaultDuration: 60
        property int remainingSeconds: 0 // That's the duration of the game in milliseconds
        interval: 1000
        repeat: true

        function start_game() {
            remainingSeconds = defaultDuration
            restart()
        }

        onTriggered: {
            remainingSeconds -= 1
            if (remainingSeconds == 0) {
                console.log('finished')
                root.state = 'finished'
                running = false
            }
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
                if (sneakyCam.imagePaths.length > 0) {
                    bestShots.source = '../' + sneakyCam.imagePaths[bestShots.shotIndex%sneakyCam.imagePaths.length];
                }
            }
        }
    }

    Item {
        anchors.fill: parent
        visible: root.state == 'finished'

        Rectangle {
            anchors.fill: restartMessage
            anchors.margins: -10
            radius: 10
            color: 'yellow'
            border.width: 1
            border.color: 'black'
        }

        Text {
            id: restartMessage

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                margins: 20
            }

            color: 'black'
            font.pixelSize: 20
            font.bold: true

            text: (((tank.points+tank2.points) == 0)?'':('End result: ' + tank.points + ' - ' + tank2.points + '\n'))+'OHAI FYI: Press your MOVE button to start a new match.'
        }
    }

    Text {
        color: {
            var x = gameTimeTimer.remainingSeconds

            if (x == 5) {
                'green'
            } else if (x <= 2) {
                'red'
            } else {
                'orange'
            }
        }
        style: Text.Outline
        styleColor: 'black'
        anchors.centerIn: parent
        font.pixelSize: 40 + 40 * (6-gameTimeTimer.remainingSeconds)
        font.bold: true
        visible: gameTimeTimer.remainingSeconds < 6 && gameTimeTimer.remainingSeconds > 0
        text: gameTimeTimer.remainingSeconds
    }

    Intro {
        opacity: root.state == 'intro'
        Behavior on opacity { PropertyAnimation { } }

        anchors.fill: parent
        onAnimationsDone: {
            root.state = 'finished'
            console.log(root.state)
        }
    }

    Component.onCompleted: {
        collisions.set_player(0, tank)
        collisions.set_player(1, tank2)
    }
}

