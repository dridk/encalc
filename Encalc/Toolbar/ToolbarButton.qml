import QtQuick 1.0

Item {
    id:root
    width: 32
    height: 32
    property string buttonType: "settings"
    property bool disabled: false
    signal clicked()
    Image {
        id: normal
        anchors.centerIn: parent
        source: {
            if ( sensor.pressed)
                return  "../assets/img/button-"+parent.buttonType+".png";
            if ( sensor.containsMouse)
                return  "../assets/img/button-"+parent.buttonType+"-over.png";
            else return "../assets/img/button-"+parent.buttonType+".png";
        }
    }
    MouseArea {
        id: sensor
        hoverEnabled: true
        z: 1
        anchors.fill: parent
        onClicked: root.clicked()

    }
}
