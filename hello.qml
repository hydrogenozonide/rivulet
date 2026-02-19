import Quickshell
import QtQuick
import Niri 0.1

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            bottom: true
        }
        implicitWidth: 200
        color: "#ffffff"

        Niri {
            id: niri
            Component.onCompleted: connect()

            onConnected: console.log("Connected to niri")
            onErrorOccurred: function(error) {
                console.error("Niri error:", error)
            }
        }

        Component.onCompleted: niri.workspaces.maxCount = 10

        Column {
            spacing: 10
            anchors {
                top: parent.top
                topMargin: 5
            }

            Column {
                spacing: 2

                Repeater {
                    model: niri.workspaces

                    Rectangle {
                        width: 30
                        height: 20
                        color: model.isFocused ? "#106DAA" :
                               model.isActive ? "#377B86" : "#222225"
                        border.color: model.isUrgent ? "red" : "#16181A"
                        border.width: 2
                        radius: 3

                        Text {
                            anchors.centerIn: parent
                            text: model.name || model.index
                            font.family: "Barlow Medium"
                            color: model.isFocused || model.isActive ? "white" : "#89919A"
                            font.pixelSize: 14
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: niri.focusWorkspaceById(model.id)
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            Text {
                text: niri.focusedWindow?.title ?? ""
                font.family: "Barlow Medium"
                font.pixelSize: 16
                color: "#89919A"
                rotation: 90
            }
        }
    }
}
