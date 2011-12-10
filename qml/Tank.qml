
import QtQuick 1.0
import Qt.labs.particles 1.0

Image {
    property string color: 'blue'
    property real xSpeed: 0
    property real ySpeed: 0
    property real particlestrength: 0.9

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
             lifeSpan: 3000
             count: 400 * particlestrength + 150
             angle: 90
             angleDeviation: 35
             velocity: 80
             velocityDeviation: 35 * particlestrength + 10

             ParticleMotionGravity {
                 yattractor: 0
                 xattractor: 0
                 acceleration: 30
             }
         }
}

