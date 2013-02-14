import QtQuick 1.0

Rectangle {
    width: 200
    height: 20
    color: "#00000000"

    Row {
        id: row
        spacing: 2
        anchors.fill: parent
        GenericButton{
            width:30
            height:20
            text:"Any"
        }
        GenericButton{
            width:20
            height:20
            text:"0"
        }
        GenericButton{
            width:20
            height:20
            text:"1"
        }
        GenericButton{
            width:20
            height:20
            text:"2"
        }
        GenericButton{
            width:20
            height:20
            text:"3"
        }
        GenericButton{
            width:20
            height:20
            text:"4"
        }
        GenericButton{
            width:20
            height:20
            text:"5"
        }
        GenericButton{
            width:20
            height:20
            text:"6"
        }
        GenericButton{
            width:20
            height:20
            text:"7"
        }
        GenericButton{
            width:20
            height:20
            text:"8"
        }
    }
}
