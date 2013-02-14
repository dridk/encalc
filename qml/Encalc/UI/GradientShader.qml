import QtQuick 1.0

Rectangle {
    property string type: "outset"
    radius: 2
    gradient: Gradient {
        GradientStop {position: (type=="inset")?0:1; color: "#dcdcdc"}
        GradientStop {position: (type=="inset")?1:0; color: "#ffffff"}
    }
    anchors.fill: parent
    anchors.margins: 2
}
