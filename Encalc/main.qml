import QtQuick 1.0
import 'Grid'
import 'Screen'
import 'Printer'
import 'Toolbar'
import 'assets/js/main.js' as Script

Rectangle {
    id: calc
    width: 640
    height: 480
    color: "#000000"



    CalcButtonGrid {
        id: calcbuttongrid
        y: 110
        anchors.top: calcscreen.bottom
        anchors.right: calcprinter.left
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        onDigitPress: calculator.pressDigit(digit)
    }

    CalcScreen {
        id: calcscreen
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.topMargin: -11
        anchors.top: toolbar.bottom
        anchors.right: parent.right
        display:calculator.display
        memory: calculator.memory
        operation: calculator.equation


    }
    CalcPrinter {
        id: calcprinter
        anchors.bottom: parent.bottom
        anchors.top: calcscreen.bottom
        anchors.right: parent.right
    }

    Toolbar{
        id: toolbar
        x: 0
        y: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top


    }
}
