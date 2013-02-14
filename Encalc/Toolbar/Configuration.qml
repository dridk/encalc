import QtQuick 1.0
import "../UI"

Item {
    id: container

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Dropdown {
        id: uiHolder
        width: 250; height: column.height+column.anchors.margins*2
        px: width-28

            Column {
                id: column
                spacing: 10
                anchors {right: parent.right; left: parent.left; top: parent.top}
                anchors.margins: 10
                GenericButton {
                    id: newSession
                    width: parent.width
                    height: 30
                    text: "Start New Session"
                    onClicked: calc.newSession();
                }

                Separator{}

                Row {
                    width: parent.width
                    height: 30

                    InputField{
                        id: taxRate
                        height: parent.height
                        text: "0"
//                        anchors.left: parent.left
//                        anchors.right: buttonMore.left
                        label: "Tax Rate:"
                        item.inputMask: "NN%"
                    }

                    GenericButton {
                        id: buttonMore
                        width: height = parent.height
                        text: "+"
//                        anchors.right: buttonLess.left
                        onClicked: {taxRate.text+=1}
                    }

                    GenericButton {
                        id: buttonLess
                        width: height = parent.height
                        text: "-"
//                        anchors.right: parent.right
                        onClicked: {taxRate.text-=1}
                    }
                }

                    Row {
                        width: parent.width
                        height: 30

                        InputField{
                            id: decimalPoint
                            width: parent.width-buttonAny.width
                            height: parent.height
                            text: "0"
                            label: "Decimal Spaces:"
                            item.inputMask: ""
                        }

                        GenericButton {
                            id: buttonAny
                            width: 80
                            height: parent.height
                            text: "As needed"
                            onClicked: decimalPoint.text = "any"
                        }
                    }

                    Separator{}

                    Checkbox{
                        id: saveMemory
                        width: parent.width
                        height: 30
                        text: "Save memory in history:"
                    }

                    Checkbox{
                        id: saveOnClose
                        width: parent.width
                        height: 30
                        text: "Save session on close:"
                    }

                    Checkbox{
                        id: restoreOnOpen
                        width: parent.width
                        height: 30
                        text: "Restore session on open:"
                    }




            }
    }
}
