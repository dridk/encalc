import QtQuick 1.0

BorderImage {
    id: button
    property string type: "outset"
    border {bottom: 3; top: 3; right: 3; left: 3}
    source: "./images/borderImage_"+type+".png"
}
