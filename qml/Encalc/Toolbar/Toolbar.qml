import QtQuick 1.0
import "../assets/js/toolbar.js" as Script

Item {
    id: root
    width: 640
    height: 50
    BorderImage {
        border.bottom: 21
        border.right: 21; border.left: 21
        horizontalTileMode: BorderImage.Repeat
        anchors.fill: parent
        source: "../assets/img/header.png"
    }

    Row {
        id: navigationButtons
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 4
        anchors.leftMargin: 7
        spacing: 3
        ToolbarButton{
            id: buttonUndo
            buttonType: "undo"
            disabled: true
            onClicked: calculator.undo()
        }

        ToolbarButton{
            id: buttonHistory
            buttonType: "history"
            //            onClicked: Script.showHistory()
        }
//        ToolbarButton{
//            id: buttonRedo
//            buttonType: "redo"
//            disabled: true
//            onClicked: Script.redo()
//        }
    }
    Row {
        id: configButtons
        x: 240
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 7
        spacing: 3
        ToolbarButton{
            id: buttonPrint
            buttonType: "print"
           // onClicked: Script.showPrint()
            onClicked: historyModel.printDialog()
        }
        ToolbarButton{
            id: buttonSettings
            buttonType: "config"
//            onClicked: Script.showSettings()
        }

        ToolbarButton {
            id: buttonAbout
            buttonType: "about"
        }
    }

//    Configuration {
//        id: configMenu
//        x: 386; y: 44
//        opacity: 0
//    }

}
