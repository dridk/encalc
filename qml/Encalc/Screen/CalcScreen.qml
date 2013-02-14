import QtQuick 1.0
import "../assets/js/screen.js" as Script

BorderImage {
    id: root
    source: "../assets/img/screen.png"
    border.right: 114; border.left: 67
    horizontalTileMode: BorderImage.Round

    property string display: "0"
    property string memory: ""
    property string operation: ""
    property int decimalDigits: -1
    property bool negatifSign : false


    Row {
        id: inforow
        height: 15
        anchors.topMargin: 9
        anchors {top: parent.top;right: parent.right;left: parent.left}
        anchors.margins: 15

        CalcScreenText {
            id: screenError
            text: "ERROR"
            textSize: "small"
            visible: screenNumerals.text == "inf"
        }

        CalcScreenText {
            id: screenMem
            text: Script.addCommas(root.memory," ",".")
            textSize: "small"
            visible: !screenError.visible
        }

        CalcScreenText {
            id: screenOperation
            width: inforow.width-screenMem.width
            textSize: "small"
            text: Script.addCommas(root.operation," ",".")
            anchors.leftMargin: 10; anchors.left: screenMem.right
            visible: !screenError.visible
        }

    }

    Row {
        id: mainrow
        spacing: 10
        anchors.verticalCenterOffset: 6
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 15; anchors.rightMargin: 30


        CalcScreenText {
            id: screenNumerals
            text: Script.addCommas(root.display," "," .")
        }

//        CalcScreenText {
//            id: screenAction
//            width: 30
//        }
    }

    Image {
        id: overlay
        smooth: true
        anchors.fill: parent
        source: "../assets/img/screen-highlight.png"
    }


}
