import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../js/units.js" as U

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
