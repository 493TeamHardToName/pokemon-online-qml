import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../js/units.js" as U

//Item {
//    id: root

//    property string playerName

//    signal decline;
//    signal accept;

//    anchors.fill: parent
//    Rectangle {
//        anchors.fill: parent
//        color: "black"
//        opacity: 0.05
//    }
//    Rectangle {
//        width: U.dp(4);
//        height: U.dp(3)
//        border {
//            color: "black"
//            width: 2
//        }
//        radius: U.dp(0.1)
//        anchors.centerIn: parent
//        Column {
//            width: parent.width
//            Text {
//                text: "Player " + playerName.substring(9) + " challenges you to a game"
//                anchors {
//                    horizontalCenter: parent.horizontalCenter
//                }
//            }
//            Row {
//                height: U.dp(0.5)
//                anchors.horizontalCenter: parent.horizontalCenter
//                Button {
//                    text: "Accept"
//                    onTriggered: {
//                        accept();
//                        root.destroy();
//                    }
//                }
//                Button {
//                    text: "Decline"
//                    onTriggered: {
//                        decline();
//                        root.destroy();
//                    }
//                }
//            }
//        }
//    }
//}

MessageDialog {
    property string playerName
    signal decline;
    signal accept;

    title: "Challenge"
    text: "Player " + playerName.substring(9) + " challenges you to a game"
    standardButtons: StandardButton.No | StandardButton.Yes
    onYes: {
        accept();
        console.log("challenge accepted.")
    }
    onNo: {
        decline();
        console.log("challenge declined. ")
    }
}
