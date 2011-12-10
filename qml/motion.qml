
import Qt 4.7

Rectangle {
    width: 640
    height: 480

    color: '#006699'

    Tank {
        id: tank
        color: 'blue'
        x: 300
        y: 300
        rotation: 200
    }

    Timer {
        running: true
        interval: 30
        repeat: true

        onTriggered: {
            tank.rotation += 15*steering.get_steering()
            var speed = 5*pumping.get_pumping()

            tank.x += Math.cos((tank.rotation+90)/180*3.1415) * speed
            tank.y += Math.sin((tank.rotation+90)/180*3.1415) * speed
        }
    }

    Tank {
        id: tank2
        color: 'red'
        x: 600
        y: 400
        rotation: 100
    }

}

