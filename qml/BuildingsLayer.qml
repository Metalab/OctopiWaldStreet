
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
}

