import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Button {
    id: root

    property string onText: "On"
    property string offText: "Off"
    property string commandOn: ""
    property string commandOff: ""

    checkable: true
    text: checked ? onText : offText
    implicitWidth: 96
    implicitHeight: 96
    Material.primary: Material.color(Material.Shade500)
    Material.roundedScale: Material.FullScale
    onClicked: {
        if (commandOn && commandOff)
            Qt.shell.execute("bash", ["-c", checked ? commandOn : commandOff]);

    }
}
