
import Qt 4.7

Item {
    id: buildingsLayer

    function mapAllCornerPoints() {
        var i = 0;

        for (i=0; i<children.length; i++) {
            var child = children[i];
            if (child.mapCornerPoints !== undefined) {
                var corners = child.mapCornerPoints(root);
                collisions.detect(corners, child.isGoal);
            }
        }

        // left border
        collisions.detect([-100, 0, 0, 0, 0, 480, -100, 480], false);

        // right border
        collisions.detect([640, 0, 740, 0, 740, 480, 640, 480], false);

        // top border
        collisions.detect([0, 0, 640, 0, 640, statusBar.height, 0, statusBar.height], false);

        // bottom border
        collisions.detect([0, 480, 640, 480, 640, 580, 0, 580], false);
    }

    Building {
        x: 200
        y: 200
        transformOrigin: Item.TopLeft
        scale: .4
        rotation: 100
    }

    Building {
        x: 500
        y: 200
        transformOrigin: Item.TopLeft
        scale: .45
        rotation: 80
    }

    Building {
        x: -50
        y: 120
        scale: .3
        rotation: 7
    }

    Building {
        x: 270
        y: 130
        scale: .4
        rotation: -25
    }

    Building {
        x: 10
        y: 100
        scale: .4
        rotation: 100
    }

    Building {
        x: 220
        y: 120
        scale: .37
        rotation: -104
    }

    Image {
        id: tehCourtShadow
        source: 'img/goal-shadow.png'
        anchors.centerIn: tehCourt
        scale: tehCourt.scale
        opacity: tehCourt.altitude * .5
        anchors.horizontalCenterOffset: 3 + tehCourt.altitude * 10
        anchors.verticalCenterOffset: 3 + tehCourt.altitude * 10
        rotation: tehCourt.rotation
    }

    TehCourt {
        id: tehCourt
        state: ['first', 'second', 'third'][collisions.stateIndex%3]
        altitude: 1

        states: [
            State {
                name: 'first'
            },
            State {
                name: 'second'
                PropertyChanges { target: tehCourt; x: -40; y: 10; rotation: 140 }
            },
            State {
                name: 'third'
                PropertyChanges { target: tehCourt; x: 400; y: 20; rotation: 220 }
            }
        ]

        PropertyAnimation on altitude {
            duration: 5000
            //loops: 100
            from: 0
            to: 1
            running: false // this should be set to running once the game is
                           // completed. then it will fly away. yo!
        }

        scale: .5
        x: (parent.width/2 - width/2) - altitude*10
        y: (parent.height - height*3/4 - 10) - altitude*10
    }
}

