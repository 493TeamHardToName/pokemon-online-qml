import QtQuick 2.0
import QtQuick.Controls 1.3
import "../components" as Comp
import "../js/units.js" as U

Rectangle {

    property bool attackEnabled : true

    signal goBack();

    anchors.fill: parent

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted:logTextArea.text += line + "\n"
    }

    Connections {
        target: analyserAccess
        onAllowAttackSelection: attackEnabled = true
    }

    Column {
        width: parent.width
        // TODO scene window

        TextArea {
            id: logTextArea
            width: parent.width
            height: U.dp(3)
        }

        Flow {
            width: parent.width
            Repeater {
                model: analyserAccess.attackListModel
                delegate: Button {
                    text: name
                    enabled: attackEnabled
                    onClicked: {
                        attackEnabled = false;
                        analyserAccess.attackClicked(index)
                    }
                }
            }
        }

        Label {
            text: "Switch"
        }
        Flow {
            width: parent.width
            Repeater {
                model: analyserAccess.pokemonListModel
                delegate: Button {
                    text: name
                    enabled: attackEnabled
                    onClicked: {
                        attackEnabled = false;
                        analyserAccess.switchClicked(index)
                    }
                }
            }
        }

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
