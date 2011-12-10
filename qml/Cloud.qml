
import Qt 4.7

Item {
    id: cloud

    width: 128
    height: 128
    property real phase: 0

    Timer {
        running: cloud.opacity > 0
        repeat: true
        interval: 30
        onTriggered: cloud.phase += .2
    }

    Repeater {
        model: 7

        Image {
            source: 'img/cloud.png'
            opacity: .3
            x: Math.sin(cloud.phase * index * index + 500 * index) * 20
            y: Math.cos(cloud.phase * index * index + 70 * index) * 20
            rotation: -cloud.phase * 100 / index
        }
    }
}

