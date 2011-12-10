
import Qt 4.7

Item {
    id: buildingsLayer

    function mapAllCornerPoints() {
        var i = 0;

        for (i=0; i<children.length; i++) {
            var child = children[i];
            var corners = child.mapCornerPoints(root);
            collisions.detect(corners);
        }

        // left border
        collisions.detect([-100, 0, 0, 0, 0, 480, -100, 480]);

        // right border
        collisions.detect([640, 0, 740, 0, 740, 480, 640, 480]);

        // top border
        collisions.detect([0, 0, 640, 0, 640, statusBar.height, 0, statusBar.height]);

        // bottom border
        collisions.detect([0, 480, 640, 480, 640, 580, 0, 580]);
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

    TehCourt {
        scale: .5
        x: parent.width/2 - width/2
        y: parent.height - height*3/4 - 10
    }
}

