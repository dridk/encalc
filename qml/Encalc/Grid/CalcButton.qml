import QtQuick 1.0
Item {
    id:root
    width: Math.round((parent.width-12)/6)
    height: Math.round((parent.height-12)/5)
    property alias text : buttonText.text
    property double size ;
    signal clicked()


    FontLoader { id: localFont; source: "../assets/fonts/Rationale-Regular.ttf" }

    BorderImage {
        opacity: 0.500
        border.bottom: 4
        border.top: 4
        border.right: 4
        border.left: 4
        anchors.fill: parent
        source: "../assets/img/borderImage_outset.png"
    }

    Text {
        id: buttonText
        color: {
            if (sensor.pressed)
                return "#ffaa00";
            if ( sensor.containsMouse)
                return "#000"
            else return "#666666"
        }
        font.family: localFont.name
        anchors.centerIn: parent
        font.pixelSize: root.size * root.width
        scale: sensor.pressed ? 3 : 1

        Behavior on scale  {
            NumberAnimation {
                easing.type: Easing.OutElastic
                duration: 500

            }

        }

    }

    MouseArea {
        id: sensor
        hoverEnabled: true
        anchors.fill: parent
        onClicked: root.clicked(buttonText.text)
    }
}


