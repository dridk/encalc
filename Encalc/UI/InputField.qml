import QtQuick 1.0
import "./js/settings.js" as Settings

FocusScope {
    id: container
    width: 200
    height: 30
    signal accepted
    property alias label: label.text
    property alias text: input.text
    property alias item: input

    Border {
        id: border
        type: "inset"
        anchors.fill: parent

        GradientShader{type: "inset"}

        Text {
            id: label
            color: Settings.textColor
            text: "Button:"; font.family: Settings.fontFamily; font.pixelSize: Settings.textSize
            anchors.left: parent.left; anchors.leftMargin: 5;
            anchors.verticalCenter: parent.verticalCenter; style: Text.Raised; styleColor: "#ffffff"
            horizontalAlignment: Text.AlignHCenter

            MouseArea { //Switch focust over to the input field even when the label is clicked
                id: sensor
                anchors.fill: parent
                onClicked: container.focus=true
            }
        }
        TextInput {
            id: input
            height: label.height
            color: Settings.inputColor
            text: "Text"; font.family: Settings.fontFamily; font.pixelSize: Settings.textSize
            anchors.right: parent.right; anchors.rightMargin: 5
            anchors.left: label.right; anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            onAccepted:{container.accepted()}
            selectByMouse: true
            focus: true
        }
    }
}
