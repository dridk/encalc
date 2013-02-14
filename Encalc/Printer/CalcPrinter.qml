import QtQuick 1.0
import "../assets/js/printer.js" as Script

BorderImage {
    id: root
    width: 210; height: 290
    border.left: 2; border.top: 10; border.bottom: 11; border.right: 1
    horizontalTileMode: BorderImage.Repeat; verticalTileMode: BorderImage.Repeat
    source: "../assets/img/app_print_area.png"

    Flickable {
        id:paperFeed
        anchors.right: parent.right; anchors.rightMargin: 1
        anchors.left: parent.left; anchors.leftMargin: 2
        anchors.bottom: parent.bottom; anchors.bottomMargin: 11
        anchors.top: parent.top; anchors.topMargin: 10
        contentHeight: col.height
        clip: true
        Column {
            id:col
            move: Transition {
                NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad; duration: 300 }
            }
            add: Transition {
                NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad ; duration: 300 }
            }

            Repeater {
                id:repeater
                model:historyModel
                CalcPrinterItem {
                    text: display != "null" ? display : ""
                    type: display == "null"?  "_rip" : ""
                    onClicked: {
                        console.log("item: "+index+" clicked")
                    }
                }

                onCountChanged: {
                    paperFeed.contentY = 0;

                }
            }
        }

        //        Rectangle { //scrollbar
        //            id: scrollbar
        //            y: paperFeed.visibleArea.yPosition * paperFeed.height
        //            width: 5
        //            height: paperFeed.visibleArea.heightRatio * paperFeed.height
        //            color: "#32000000"
        //            radius: 2
        //            anchors.right: parent.right
        //            anchors.rightMargin: 3
        //            border.color: "#64ffffff"
        //            opacity: paperFeed.moving? .7 : 0;
        //            Behavior on opacity {
        //                NumberAnimation { duration: 200 }
        //            }
        //        }
    }
    ShadowHorizontal{ anchors.right: parent.right; anchors.rightMargin: 1; anchors.left: parent.left; anchors.leftMargin: 2; anchors.top: parent.top; anchors.topMargin: 10}
    ShadowHorizontal{ anchors.right: parent.right; anchors.rightMargin: 2; anchors.left: parent.left; anchors.leftMargin: 1; anchors.bottomMargin: 11; anchors.bottom: parent.bottom; rotation: 180}

}
