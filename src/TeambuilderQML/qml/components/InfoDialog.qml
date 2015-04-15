import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../js/units.js" as U

MessageDialog {
    title: "Info"
    text: "This Android version game is built based on the destop version of Pokemon Online by Boren Zhang, Yuxuan Zhou and Lu Wang. "
    standardButtons: StandardButton.OK
    onAccepted: console.log("close info dialog. ")
}

