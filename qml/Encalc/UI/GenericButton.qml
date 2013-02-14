import QtQuick 1.0
import "./js/settings.js" as Settings

Item {
    id: container
    property alias text: buttonText.text
    signal clicked;
    Border{
        id: border
        anchors.fill: parent
        GradientShader{type:(sensor.pressed)?"inset":"outset";}
        Text{
            id:buttonText
            color: (sensor.containsMouse)?Settings.textOver:Settings.textColor
            text: "Button"; font.family: Settings.fontFamily; font.pixelSize: Settings.textSize
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            style: Text.Raised; styleColor: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
        }
        MouseArea {
            id: sensor
            hoverEnabled: true
            anchors.fill: parent
            onClicked: container.clicked()
//            onEntered: border.opacity=1
//            onExited: border.opacity=0
        }
    }
}
