import QtQuick 2.0
import QtQuick.Controls 1.3
import "../components" as Comp
import "../js/units.js" as U

Rectangle {
    id: root

    property bool switchEnabled:  true

    signal goBack();
    signal disable();

    onDisable: console.log("root disabled")
    anchors.fill: parent

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted:logTextArea.text += line + "\n"
    }

    Connections {
        target: analyserAccess
        onSwitchAllowed: switchEnabled = true;
    }

    Column {
        width: parent.width

        Column {
            id: battleSceneContainer
            width: parent.width
            Component.onCompleted: analyserAccess.createBattleSceneItem(battleSceneContainer)
        }

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
                    id: atkButton
                    enabled: true
                    text: name
                    onClicked: {
                        disable();
                        analyserAccess.attackClicked(index)
                    }
                    Connections {
                        target: analyserAccess
                        onAttackAllowed: {
                            if (attackIdx == index)
                                atkButton.enabled = true;
                        }
                    }
                    Connections {
                        target: root
                        onDisable: atkButton.enabled = false
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
                    enabled: switchEnabled
                    onClicked: {
                        disable()
                        switchEnabled = false
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
