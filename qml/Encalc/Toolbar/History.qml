import QtQuick 1.0
import "../"

Item {
    id: container
    property alias pointerPosition: uiHolder.px

    Component.onCompleted: {
        var h = calc.loadHistory();
        if(h===undefined || h===null || h.length>0){
            for(var i = 0; i<h.length;i++){
                listModel.append(
                            {
                                itemLabel:"Session Date: "+h[i].date+" Label: ",
                                itemText:h[i].tag
                            }
                            );
            }
        }else{
            console.log("No previous history");
        }
    }

    function loadSession(index){
        console.log(index);
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    ListModel{
        id:listModel
    }

    Dropdown {
        id: uiHolder
        width: 300
        height: (column.height<150)?column.height:150
        px: 0
        Flickable{
            id:flick
            flickableDirection: Flickable.VerticalFlick
            anchors.fill: parent
            anchors.margins: 10
            contentWidth: column.width
            contentHeight:column.height
            clip: true
            Column {
                id: column
                width: 280
                height: (children.height>0)?children.height:10
                Repeater{
                    id: repeater
                    model: listModel
                    HistoryItem{
                        width: 280
                        height: 30
                        text: itemLabel+" "+itemText
                        onClicked: container.loadSession(index)
                    }
                }
            }
        }
    }
}
