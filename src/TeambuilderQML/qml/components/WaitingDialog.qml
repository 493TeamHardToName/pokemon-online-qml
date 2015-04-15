import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../js/units.js" as U

MessageDialog {
    property string playerName

    title: "Waiting"
    text: "Waiting for " + playerName.substring(9) + " to accept your challenge..."
    standardButtons: StandardButton.Cancel
    onRejected: console.log("challenge cancelled. ")
}
