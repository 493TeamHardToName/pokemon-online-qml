import QtQuick 2.4
import QtQuick.Controls 1.3
import "../js/units.js" as U

Item {
    property var stats
    property var headers: ["Hp", "Attack", "Defense", "Special Attack", "Special Defense", "Speed"]

    height: col.height
    Column {
        id: col
        width: parent.width
        Repeater {
            model: stats
            delegate:
                Row {
                    Label {
                        text: headers[index]
                        width: U.dp(1.5)
                        elide: Text.ElideRight
                    }

                    Label {
                        text: ":"
                    }

                    ProgressBar {
                        maximumValue: 180
                        minimumValue: 0
                        value: modelData
                        width: U.dp(1)
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
        }
    }
}
