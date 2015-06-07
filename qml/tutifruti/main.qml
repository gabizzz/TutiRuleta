import QtQuick 2.3
import QtQuick.Controls 1.2
import "random.js" as Logic
import QtMultimedia 5.0
import QtQuick.Dialogs 1.2


Item {
    id: root
    property string patron: "ABCDEFGIJLMNOPRSTUV"
    property int timerSorteo: 0
    property int timerJuego: 0
    property bool nivel1: false
    property bool timerjugando: false
    property bool pausa: false

    width: 600
    height: 1000

    function nuevo(){
        patron="ABCDEFGIJLMNOPRSTUV";
        labelnivel.text=patron;
        playbanner2.start();
        labelletraJuega.text="";
        labelletrasSorteadas.text="";
        labelletraJuega.text="Start";
        labelletraJuega.font.pointSize= 50;
        labelTimer.text="";
        timerJuego=0;
        timerSorteo=0;
        nivel1=false;
        pausa=false;
        rectangleStop.source="media-pause.png"
        relojRegresivo.stop();
        reloj.stop();
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("Alerta!")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    Rectangle {
        id: rectletraJuega
        x: 80
        y: 26

        width: 324
        height: 328
        color: "#d60505"
        radius: 43
        border.width: 5
        anchors.horizontalCenter: parent.horizontalCenter


        Label {
            id: labelletraJuega
            color: "#f2ad26"
            text: qsTr("Start")
            wrapMode: Text.WordWrap
            font.bold: true
            font.pointSize: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent

            Rectangle {
                id: rectTimer
                x: 252
                y: 256
                width: 130
                height: 130
                color: "#dca004"
                radius: 60
                border.color: "#000000"
                border.width: 5

                Label {
                    id: labelTimer
                    color: "#a70606"
                    text: ""
                    anchors.fill: parent
                    font.bold: true
                    font.pointSize: 40
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        SequentialAnimation {
            id: animBotonStart
            ColorAnimation {target: rectletraJuega;properties: "color"; to: "orange"; duration: 100 }
            ColorAnimation {target: rectletraJuega;properties: "color"; to: "#d60505"; duration: 100 }
        }

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onPressed: {
                if (timerjugando===false && pausa===false)
                {
                    nivelSound.play();
                    animBotonStart.running=true;
                    timerjugando=true;
                    relojRegresivo.start();
                }
                }
            }
    }

    Label {
        id: labelletrasSorteadas
        y: 964
        width: 574
        height: 22
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Audio{
        id:finalSound
        source: "qrc:/qml/tutifruti/finalSound.wav"
    }

    Audio{
        id:reloadSound
        source:"qrc:/qml/tutifruti/reloadSound.wav"
    }

    Audio{
        id:beep
        source: "qrc:/qml/tutifruti/beep.wav"
    }
    Audio{
        id:nivelSound
        source: "qrc:/qml/tutifruti/nivelSound.wav"
    }

    Timer {
            id: relojRegresivo
            interval: 1000; running: false; repeat: true;
            onTriggered: {
                beep.play();
                timerSorteo+=1;
                labelTimer.text=timerSorteo.toString();
            if (timerSorteo===4)
            {
                relojRegresivo.stop()
                timerSorteo=0;
                labelTimer.text=timerSorteo.toString();

                labelletraJuega.text= Logic.randomBg(patron)
                labelletraJuega.font.pointSize= 120
                labelletrasSorteadas.text += labelletraJuega.text
                patron=patron.replace(labelletraJuega.text,"");
                if (patron.length===0)
                {
                    labelletraJuega.text="End Game"
                    labelletraJuega.font.pointSize= 50
                }
                reloj.start()
            }
            }
        }
    Timer{
        id:reloj
        interval: 1000; running: false; repeat: true;
        onTriggered: {
            timerJuego +=1
            labelTimer.text=timerJuego.toString()
            if (timerJuego===54)
            {
                finalSound.play();
            }


            if (timerJuego===60)
            {
                timerJuego=0;
                labelTimer.text=timerJuego.toString();
                reloj.stop();
                timerjugando=false
            }
        }
    }
    
    Rectangle {
        id: rectangle1
        x: 205
        y: 885
        width: 190
        height: 70
        color: "#e0e02d"
        radius: 10
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 45
        border.width: 3

        Label {
            id: labelNivel1
            color: "#000000"
            text: qsTr("Facil")
            anchors.fill: parent
            font.pointSize: 25
            opacity: 1.0
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            id: labelNivel2
            color: "#000000"
            text: qsTr("Normal")
            anchors.fill: parent
            opacity: 0.0
            font.pointSize: 25
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        MouseArea{
            anchors.fill: parent
           onClicked: {
               nivelSound.play()
               if (timerjugando===false)
               {
                   if (nivel1===false)
                   {
                       playbanner.start()
                       nivel1=true
                       patron="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                   }else{
                       playbanner2.start()
                       nivel1=false
                       patron="ABCDEFGIJLMNOPRSTUV"
                   }
                   labelnivel.text=patron
               }

           }
       }

       SequentialAnimation {
              id: playbanner
              running: false
              NumberAnimation { target: labelNivel1; property: "opacity"; to: 0.0; duration: 200}
              NumberAnimation { target: labelNivel2; property: "opacity"; to: 1.0; duration: 200}
          }
       SequentialAnimation {
              id: playbanner2
              running: false
              NumberAnimation { target: labelNivel2; property: "opacity"; to: 0.0; duration: 200}
              NumberAnimation { target: labelNivel1; property: "opacity"; to: 1.0; duration: 200}
       }

    }

    Image {
        id: background
        anchors.fill: parent
        z: -1
        source: "bkg.jpeg"
    }

    Label {
        id: labelnivel
        x: 13
        y: 847
        width: 574
        height: 17
        color: "white"
        text: qsTr("")
        anchors.horizontalCenterOffset: 0
        font.bold: true
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 136
        anchors.horizontalCenter: parent.horizontalCenter

        Component.onCompleted: {
            labelnivel.text=patron
        }
    }

    Image {
        id: rectangleStop
        source: "media-pause.png"
        x: 497
        width: 80
        height: 80
        anchors.top: parent.top
        anchors.topMargin: 26
        anchors.right: parent.right
        anchors.rightMargin: 23

        MouseArea {
            id: mouseAreaStop
            anchors.fill: parent
            onClicked: {
                nivelSound.play();
                if(timerjugando===true && pausa===false)
                {
                    reloj.stop();
                    if (finalSound.PlayingState)
                    {
                        finalSound.pause();
                    }
                    pausa=true;
                    timerjugando=false;
                    rectangleStop.source="media-play.png"
                }else if(timerjugando===false && pausa===true){
                    reloj.start();
                    if (finalSound.PausedState)
                    {
                        finalSound.play();
                    }
                    pausa=false;
                    timerjugando=true;
                    rectangleStop.source="media-pause.png"
                }
            }
        }
    }

          Image {
            x: 26
            y: 26
            width: 80
            height: 80
            id: imagereload
            smooth: true
            fillMode: Image.PreserveAspectFit
            source: "media-repeat-alt.png"

            RotationAnimation {
                id:rotar
                target: imagereload
                loops: 1
                from: 0
                to: 360
            }

            MouseArea {
                id: mouseArea2
                anchors.fill: parent
                onClicked: {
                    reloadSound.play();
                    if(timerjugando===false)
                    {
                        nuevo();
                        rotar.running=true;
                    }
                }
        }
    }

}

