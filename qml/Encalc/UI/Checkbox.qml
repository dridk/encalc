import QtQuick 1.0
import "./js/settings.js" as Settings

Rectangle {
     id: container
     property alias text: label.text
     property alias label: label
     property bool on: true
     width: 200
     height: 30
     color: "#00000000"

     Text {
         id: label
         color: Settings.textColor
         text: "Button:"; anchors.right: checkbox.left; anchors.rightMargin: 5; font.family: Settings.fontFamily; font.pixelSize: Settings.textSize
         anchors.left: parent.left; anchors.leftMargin: 5;
         anchors.verticalCenter: parent.verticalCenter; style: Text.Raised; styleColor: "#ffffff"
         horizontalAlignment: Text.AlignLeft
     }

     Border {
         id: checkbox
         width: height; height: parent.height
         anchors.right: parent.right

         GradientShader{type: "inset"}

         Rectangle{
             id:indicator
             color: Settings.textColor
             radius: width/2
             anchors.margins: 8
             anchors.fill: parent
             opacity: (container.on)?1:0
             Behavior on opacity {
                 NumberAnimation { duration: 100 }
             }
         }
     }

     MouseArea { anchors.fill: parent; onClicked: container.on = (container.on)?false:true;

     }

 }
