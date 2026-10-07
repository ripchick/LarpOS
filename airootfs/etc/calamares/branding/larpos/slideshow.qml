import QtQuick

Rectangle {
    id: root
    color: "#14090d"

    Image {
        id: logo
        source: "larpos.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
        width: 180
        height: 180
        fillMode: Image.PreserveAspectFit
    }

    Text {
        anchors.centerIn: parent
        text: "Welcome to LarpOS"
        color: "#ff5560"
        font.pixelSize: 34
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        text: "Arch-based  -  Hyprland  -  Blood Moon"
        color: "#e8dfe0"
        font.pixelSize: 18
    }
}
