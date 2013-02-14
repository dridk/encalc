import QtQuick 1.0
import "../assets/js/grid.js" as Script

Rectangle {
    id: root
    width: 640
    height: 480
    border.color: "#ffffff"
    signal digitPress(string digit)

    Image {
        fillMode: Image.Tile
        anchors.fill: parent
        source: "../assets/img/white_carbon.png"
    }
    focus: true
    Keys.onPressed: {
        console.debug(event.key)

        if ((event.key == Qt.Key_M) && (event.modifiers & Qt.ShiftModifier))
            root.digitPress("3");

        if ((event.key >= 48) && (event.key <=57))
            root.digitPress(event.key - 48);

        if ((event.key >= 0) && (event.key <=9))
            root.digitPress(event.key);

        if ( event.key == Qt.Key_Plus)
            root.digitPress("+");

        if ( event.key == Qt.Key_Minus)
            root.digitPress("-");

        if ( event.key == Qt.Key_multiply||
                event.key == 42)
            root.digitPress("×");

        if ( event.key == Qt.Key_division||
                event.key == 47)
            root.digitPress("÷");

        if ( event.key == Qt.Key_Period)
            root.digitPress(".");

        if ( event.key == Qt.Key_Return ||
                event.key == 16777221 ||
                event.key == Qt.Key_Equal)
            root.digitPress("=");

        if( event.key == 16777216) //Clear
            root.digitPress("cl");

        if( event.key == 16777219) //Undo
            calculator.undo();
    }

    PlainCalcModel {id: calcModel }

    GridView {
        id: grid
        anchors.fill: parent

        interactive: false
        cellWidth: Math.round((root.width-12)/6)
        cellHeight: Math.round((root.height-12)/5)
        anchors.margins: 5

        model: calcModel

        delegate: CalcButton {
            text: sign
            size: textSize
            onClicked: {
                root.digitPress(calcModel.get(index).action)
                console.debug(calcModel.get(index).action)
            }
        }
    }
}
