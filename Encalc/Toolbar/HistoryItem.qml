import QtQuick 1.0

FocusScope {
    id: container
    width: 200
    height: 30
    signal clicked;
    property alias text: text.text

    Rectangle {
        anchors.fill: parent
        radius: 2
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#dcdcdc"
            }

            GradientStop {
                position: 1
                color: "#ffffff"
            }
        }

        Text {
            id: text
            x: 5
            y: 7
            text: "Label:"
            color: "#787878"
            font.family:  "Nimbus Sans L"
            font.pixelSize: 14
            style: Text.Raised
            styleColor: "#ffffff"
            anchors.fill: parent
            anchors.margins: 5
            MouseArea {
                anchors.fill: parent
                onClicked:container.clicked()
            }
        }
    }
}
