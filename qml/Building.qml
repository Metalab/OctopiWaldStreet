
import Qt 4.7

Image {
    source: 'img/building.png'
    smooth: true

    function mapCornerPoints(targetItem) {
        var p1 = mapToItem(targetItem, 0, 0);
        var p2 = mapToItem(targetItem, width, 0);
        var p3 = mapToItem(targetItem, width, height);
        var p4 = mapToItem(targetItem, 0, height);

        return [p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y];
    }
}

