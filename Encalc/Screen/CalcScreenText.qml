import QtQuick 1.0

Text {
    id: screenNumerals
    property string textSize: "big"
    FontLoader { id: localFont; source: "../assets/fonts/Rationale-Regular.ttf" }
    text:"test"
    color: "#ffaa00"
    clip: true
    horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter
    font.family: localFont.name
    font.letterSpacing: 1
    font.pixelSize: (textSize=="big")?30:20;
    opacity: 0.8
}
