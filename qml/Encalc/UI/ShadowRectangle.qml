import QtQuick 1.0

Item {
    property alias filler : rectangle

    BorderImage {
        anchors.fill: rectangle
        anchors { leftMargin: -5; topMargin: -3; rightMargin: -5; bottomMargin: -7 }
        border { left: 5; top: 3; right: 5; bottom: 7 }
        source: "./images/shadow.png"; smooth: true
    }

    Rectangle { id: rectangle; anchors.fill: parent }
}
