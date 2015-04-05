import QtQuick 2.0
import PokemonOnlineQml 1.0
import "../js/units.js" as U

Item {
    id: root
    anchors.fill: parent

    property string playerName

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.05
    }

    Rectangle {
        width: U.dp(4)
        height: U.dp(3)
        radius: U.dp(0.1)
        border {
            color: "black"
            width: 2
        }
        anchors.centerIn: parent

        Column {
            width: parent.width
            Text {
                text: "Waiting for " + playerName + "accept your challenge..."
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}


