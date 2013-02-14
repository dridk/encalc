import QtQuick 1.0
import "../assets/js/screen.js" as Formater
import "../assets/js/printer.js" as Script

BorderImage {
    id: root
    width: 210
    height: {
        if(type=="")return textAnswer.y+textAnswer.height;
        else return 24
    }
    border.bottom: 9
    border.top: 1
    source: "../assets/img/paper_roll"+type+".png"
    verticalTileMode: BorderImage.Repeat

    property string text: ""
    property string type: ""
    //Type  ""
    //      "line" > small numbers, aligned left
    //      "rip" > big numbers aligned right

    signal clicked()

    FontLoader { id: localFont; source: "../assets/fonts/NovaMono.ttf" }

    Text {
        id: textAction
        x: 8; y: 2
        width: 191
        color: "#5e6ea8"
        opacity: 0.7
        font.family: localFont.name
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 12
        text: Formater.addCommas(Script.getAction(root.text),",",".")
        elide: Text.ElideRight
    }

    Text {
        id: textAnswer
        x: 8
        width: 191
        color: "#5e6ea8"
            //"#006ed3"
        font.family: localFont.name
        horizontalAlignment: Text.AlignRight
        text: Formater.addCommas(Script.getAnswer(root.text),",",".")
        anchors.topMargin: 0//-8
        anchors.top: textAction.bottom
        font.pixelSize: 19
    }

    MouseArea {
        id: sensor
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
