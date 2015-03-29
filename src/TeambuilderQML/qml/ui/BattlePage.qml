import QtQuick 2.0
import QtQuick.Controls 1.3
import "../components" as Comp
import "../js/units.js" as U

Rectangle {

    signal goBack();

    anchors.fill: parent

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted:logTextArea.text += line + "\n"
    }

    Column {
        width: parent.width
        // TODO scene window
        // TODO logwindow
        TextArea {
            id: logTextArea
            width: parent.width
            height: U.dp(3)
        }

        // TODO 4 skills
        // TODO 6 pokemons
        Button {
            text: "Forfeit"
            onClicked: {
                //TODO forfeit
                goBack();
            }
        }
    }
}
