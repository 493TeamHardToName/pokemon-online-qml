import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../js/units.js" as U

//Item {
//    id: root
//    property string playerName

//    anchors.fill: parent

//    Rectangle {
//        anchors.fill: parent
//        color: "black"
//        opacity: 0.05
//    }

//    Rectangle {
//        width: U.dp(4)
//        height: U.dp(3)
//        radius: U.dp(0.1)
//        border {
//            color: "black"
//            width: 2
//        }
//        anchors.centerIn: parent

//        Column {
//            width: parent.width
//            Text {
//                text: "Waiting for " + playerName.substring(9) + " to accept your challenge..."
//                anchors {
//                    horizontalCenter: parent.horizontalCenter
//                }
//            }
//        }
//    }
//}

MessageDialog {
    property string playerName

    title: "Waiting"
    text: "Waiting for " + playerName.substring(9) + " to accept your challenge..."
    standardButtons: StandardButton.Cancel
    onRejected: console.log("challenge cancelled. ")
}
