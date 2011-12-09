
import Qt 4.7

Rectangle {
    width: 640
    height: 480

    color: '#006699'

    Tank {
        id: tank
        color: 'blue'
        x: 30
        y: 300
        rotation: 200
    }

    Timer {
        running: true
        interval: 30
        repeat: true
        onTriggered: {
            tank.rotation += 5*steering.get_steering()
        }
    }

    Tank {
        color: 'red'
        x: 600
        y: 400
        rotation: 100
    }

}

