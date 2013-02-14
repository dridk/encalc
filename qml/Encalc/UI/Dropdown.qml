import QtQuick 1.0
import "./js/settings.js" as Settings

Item {
    property alias px: pointer.x

    ShadowRectangle {
        id: dropdownHolder
        anchors.fill: parent
        filler.border.width: 1
        filler.radius: 4
        filler.border.color: Settings.borderColorDark
        filler.color: Settings.windowBackground

        Image {
            id: pointer
            y: -(pointer.height-1)
            source: "./images/pointer.png"
        }
    }
}
