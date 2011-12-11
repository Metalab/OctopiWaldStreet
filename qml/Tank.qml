
import QtQuick 1.0
import Qt.labs.particles 1.0

Image {
    property string color: 'blue'
    property int initialX: 0
    property int initialY: 0
    property int points: 0
    property real xSpeed: 0
    property real ySpeed: 0
    property real particlestrength: (xSpeed + ySpeed) / 7
    property alias cloudOpacity: cloud.opacity

    function reset() {
        x = initialX
        y = initialY
        xSpeed = 0
        ySpeed = 0
        points = 0
        rotation = 0
    }

    Cloud {
        id: cloud
        opacity: 0
        Behavior on opacity { PropertyAnimation { duration: 500 } }
    }

    scale: .5
    smooth: true

    function centerPoint() {
        return mapToItem(root, width/2, height/2);
    }

    source: 'img/' + color + '-team.png'

    Particles {
             y: parent.height
             x: parent.width/2
             width: 10
             height: 10
             source: 'img/sprayparticle.png'
             lifeSpan: 400
             count: 400 * particlestrength
             angle: 90
             angleDeviation: 40
             velocity: 100
             velocityDeviation: 45 * particlestrength
         }
}

