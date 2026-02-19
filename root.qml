import Niri 0.1
import QtQuick
import Quickshell

ShellRoot {
    PanelWindow {
        id: panel

        // ----- Panel open/close state -----
        property bool open: false
        property int sidebarWidth: 40
        property int dashboardWidth: 400

        implicitWidth: panel.open ? panel.sidebarWidth + panel.dashboardWidth : panel.sidebarWidth
        color: "#ffffff"
        Component.onCompleted: niri.workspaces.maxCount = 10

        anchors {
            top: true
            left: true
            bottom: true
        }

        // ----- Clock and Niri -----
        SystemClock {
            id: clock

            precision: SystemClock.Minutes
        }

        Niri {
            id: niri

            Component.onCompleted: connect()
            onConnected: console.log("Connected to niri")
            onErrorOccurred: function(error) {
                console.error("Niri error:", error);
            }
        }

        // ----- Layout: Row for sidebar + dashboard -----
        Row {
            anchors.fill: parent



            // --- Sliding dashboard panel ---
            Item {
                // Add dashboard widgets here later

                id: dashboardPanel

                width: panel.open ? panel.dashboardWidth : 0
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                Rectangle {
                    anchors.fill: parent
                    color: "#1e1f22"
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }

                }

            }
            // --- Sidebar content ---
            Item {
                width: panel.sidebarWidth
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                // Workspace column
                Column {
                    spacing: 10

                    anchors {
                        top: parent.top
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }

                    Column {
                        spacing: 2

                        Repeater {
                            model: niri.workspaces

                            Rectangle {
                                width: 30
                                height: 20
                                color: model.isFocused ? "#106DAA" : model.isActive ? "#377B86" : "#222225"
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

                }

                // Rotated window title
                Text {
                    text: niri.focusedWindow.title ?? "" // add ? after focusedWindow afer lint
                    font.family: "Barlow Medium"
                    font.pixelSize: 16
                    color: "#89919A"
                    anchors.centerIn: parent
                    rotation: 90
                    transformOrigin: Item.Center
                }

                // Clock at bottom
                Column {
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 10
                        horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: Qt.formatTime(clock.date, "hh")
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Text {
                        text: Qt.formatTime(clock.date, "mm")
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: panel.open = !panel.open
                        }

                    }

                }

            }

        }

        Behavior on implicitWidth {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InOutCubic
            }

        }

    }

}



