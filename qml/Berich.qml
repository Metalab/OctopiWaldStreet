import QtQuick 1.0
import Qt.labs.particles 1.0

Rectangle {
    width: 800
    height: 600

    Moneyparticle {
        currency: 'dollar'
    }

    Moneyparticle {
        currency: 'euro'
    }

    Moneyparticle {
        currency: 'pounds'
    }
}
