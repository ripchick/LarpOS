import QtQuick 2.15;

Presentation {
    id: presentation

    function nextSlide() { presentation.goToNextSlide(); }

    Timer {
        interval: 9000
        running: true
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
        Rectangle { color: "#0d0d12"; anchors.fill: parent }
        Image {
            source: "logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 340; height: 340; fillMode: Image.PreserveAspectFit
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter; anchors.topMargin: 190
            text: "LarpOS 2.0 — Blood Moon"
            color: "#e8e6e3"; font.pixelSize: 34; font.bold: true
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter; anchors.topMargin: 240
            text: "Hyprland Edition · Arch Linux based"
            color: "#ff7a45"; font.pixelSize: 20
        }
    }

    Slide {
        Rectangle { color: "#0d0d12"; anchors.fill: parent }
        Text {
            anchors.centerIn: parent
            width: parent.width * 0.7
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            text: "The installer will guide you through:\npartitioning, user setup and bootloader installation.\n\nAfter reboot you will be greeted by Hyprland —\na fast, tiled Wayland desktop."
            color: "#e8e6e3"; font.pixelSize: 26
        }
    }

    Slide {
        Rectangle { color: "#0d0d12"; anchors.fill: parent }
        Text {
            anchors.centerIn: parent
            width: parent.width * 0.7
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            text: "Super + Enter  terminal\nSuper + D  app launcher\nSuper + Q  close window\nSuper + M  exit session\n\nwiki.archlinux.org — your best friend.\nWelcome to the Blood Moon."
            color: "#e8e6e3"; font.pixelSize: 26
        }
    }
}
