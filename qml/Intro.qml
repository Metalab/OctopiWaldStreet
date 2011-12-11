import Qt 4.7
import Qt.labs.particles 1.0

Rectangle {
    id: intro
    signal animationsDone

  FontLoader { id: atozFont; source: "fnt/ATOZ____.TTF" }

  width: 640
  height: 480
  color: "black"

  SoundEffect {
    id: spraySound
    source: 'snd/spray.wav'
  } 

  Image {
    id: theDude
    x: 500
    y: -400
    scale: 0.35
    source: "img/dude.png"
  }

  Image {
    id: theCop
    x: -220
    y: 70
    scale: 1.25
    source: "img/cop.png"
  }

  Text {
    id: i_1
    text: "this moring the<br />Dude woke up<br \>and relaized"
    color: "white"
    x: 50
    y: 50
    opacity: 0.0
    font.pointSize: 32
    font.family: atozFont.name
  }
  
  Text {
    id: i_2
    text: "1% of the<br />people can<br />afford 99%<br />of all<br />white russians"
    color: "white"
    x: 50
    y: 200
    opacity: 0.0
    font.pointSize: 32
    font.family: atozFont.name
  }
  
  Text {
    id: i_3
    text: "so he decided to<br />file a complaint<br /> about it"
    color: "white"
    x: 50
    y: 180
    opacity: 0.0
    font.pointSize: 32
    font.family: atozFont.name
  }

  Text {
    id: i_4
    text: "but with all this<br />data retention<br />nowerdays"
    color: "white"
    x: 200
    y: 40
    opacity: 0.0
    font.pointSize: 32
    font.family: atozFont.name
  }

  Text {
    id: i_5
    text: "things get<br />spiced up<br />easy"
    color: "white"
    x: 310
    y: 230
    opacity: 0.0
    font.pointSize: 32
    font.family: atozFont.name
  }

  Particles {
    id: copSpray
    y: 220
    x: 240
    width: 10
    height: 10
    source: 'img/sprayparticle.png'
    lifeSpan: 400
    count: 0
    angle: 5
    angleDeviation: 40
    velocity: 100
    velocityDeviation: 45
  }


  SequentialAnimation { 
    running: true
    
    NumberAnimation { target: theDude; property: "x"; from: 500; to: 350; duration: 400} 
    NumberAnimation { target: i_1; property: "opacity"; from: 0.0; to: 1.0; duration: 500}
    PauseAnimation { duration: 500 }
    NumberAnimation { target: i_2; property: "opacity"; from: 0.0; to: 1.0; duration: 500}
    PauseAnimation { duration: 3000 }
    ParallelAnimation {
      NumberAnimation { target: i_1; property: "opacity"; from: 1.0; to: 0.0; duration: 500}
      NumberAnimation { target: i_2; property: "opacity"; from: 1.0; to: 0.0; duration: 500}
    }
    NumberAnimation { target: i_3; property: "opacity"; from: 0.0; to: 1.0; duration: 500}
    PauseAnimation { duration: 3000 }
    NumberAnimation { target: theDude; property: "x"; from: 350; to: 500; duration: 400} 
    NumberAnimation { target: i_3; property: "opacity"; from: 1.0; to: 0.0; duration: 500}

    PauseAnimation{ duration: 500 }

    NumberAnimation { target: i_4; property: "opacity"; from: 0.0; to: 1.0; duration: 500}
    PauseAnimation { duration: 500 }
    ParallelAnimation{
      NumberAnimation { target: i_5; property: "opacity"; from: 0.0; to: 1.0; duration: 500}
      NumberAnimation { target: theCop; property: "x"; from: -220; to: 20; duration: 400}
    }
    PauseAnimation { duration: 3000 }
    ScriptAction{
      spraySound.play()
    }
    ParallelAnimation {
      NumberAnimation { target: i_5; property: "opacity"; from: 1.0; to: 0.0; duration: 500}
      SequentialAnimation{
        NumberAnimation { target: copSpray; property: "count"; from: 0; to: 400; duration: 10}
        PauseAnimation { duration: 480}
        NumberAnimation { target: copSpray; property: "count"; from: 400; to: 0; duration: 10}
      }
    }
    NumberAnimation { target: i_4; property: "opacity"; from: 1.0; to: 0.0; duration: 500}
    NumberAnimation { target: theCop; property: "x"; from: 20; to: -220; duration: 400}
    ScriptAction {
        script: {
            console.log('ohai test')
            intro.animationsDone()
        }
    }

  }

}
