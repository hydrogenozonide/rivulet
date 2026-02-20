import Niri 0.1
import QtQuick
import Quickshell

ShellRoot {
    PanelWindow {
        id: panel

        // --- actual sliding ---
        property bool open: false
        property int sidebarWidth: 40
        property int dashboardWidth: 400

		aboveWindows: true
		exclusiveZone: 40

        implicitWidth: panel.open ? panel.sidebarWidth + panel.dashboardWidth : panel.sidebarWidth
        color: "#ffffff"
        Component.onCompleted: niri.workspaces.maxCount = 10

        anchors {
            top: true
            left: true
            bottom: true
        }

        // --- nerd shit ---
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

        // --- row for actual content  -----
        Row {
            anchors.fill: parent



            // --- dashboard ---
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
            // --- sidebar ---
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

                // --- window title ---
                Text {
                    text: niri.focusedWindow.title ?? "" // add ? after focusedWindow afer lint, linter hates that for some reason + errors
                    font.family: "Barlow Medium"
                    font.pixelSize: 16
                    color: "#89919A"
                    anchors.centerIn: parent
                    rotation: 90
                    transformOrigin: Item.Center
                }

                // --- clock ---
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



