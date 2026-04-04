import Niri 0.1
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io


PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "transparent"

	Niri {
	    id: niri
	    Component.onCompleted: connect()

	    onConnected: console.log("Connected to niri")
	    onErrorOccurred: function(error) {
	        console.error("Niri error:", error)
	    }
	}

	Component.onCompleted: niri.workspaces.maxCount = 10
		
	Rectangle {
		id: centerContainer
		anchors.centerIn: parent
	    width: focusedTitle.implicitWidth + 20
	    height: 30
	    color: "#ffffff"
	    border.color: "black"
	    border.width: 2
	    radius: 20

	    Text {
	        id: focusedTitle
	        anchors.centerIn: parent
	        text: {
	            const t = niri.focusedWindow?.title ?? "";
	            return t.length > 44 ? t.slice(0, 44) + "…" : t;
	        }
	        font.family: "JetBrainsMono Nerd Font"
	        font.pixelSize: 16
	        color: "#000000"
	    }
	}

	Rectangle {
		id: leftContainer
		anchors.left: parent.left
	    width: focusedTitle.implicitWidth + 20
	    height: 30
	    color: "#ffffff"
	    border.color: "black"
	    border.width: 2
	    radius: 20

	    Text {
	        id: workspacesText
	        anchors.centerIn: parent
	        text: {
	            const t = niri.focusedWindow?.title ?? "";
	            return t.length > 44 ? t.slice(0, 44) + "…" : t;
	        }
	        font.family: "JetBrainsMono Nerd Font"
	        font.pixelSize: 16
	        color: "#000000"
	    }
	}

	Rectangle {
		id: rightContainer
		anchors.right: parent.right
	    width: focusedTitle.implicitWidth + 20
	    height: 30
	    color: "#ffffff"
	    border.color: "black"
	    border.width: 2
	    radius: 20

	    Text {
	        id: modulesText
	        anchors.centerIn: parent
	        text: {
	            const t = niri.focusedWindow?.title ?? "";
	            return t.length > 44 ? t.slice(0, 44) + "…" : t;
	        }
	        font.family: "JetBrainsMono Nerd Font"
	        font.pixelSize: 16
	        color: "#000000"
	    }
	}

}

