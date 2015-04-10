import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1
import "../components" as Comp
import "../js/units.js" as U

Comp.Page {
    id: root

    property bool switchEnabled:  true
    property string logHtml: ""
    property bool battleEnded: false
    property bool mustSwitchPokemon: false
    signal goBack();
    signal disable();

    onDisable: switchEnabled = false

    backAction: Action {
        id: end
        text: battleEnded ? "Close" : "Forfeit"
        iconSource: battleEnded ? Qt.resolvedUrl("../graphics/glyphicons_free/glyphicons/png/glyphicons-225-chevron-left.png")
                                : Qt.resolvedUrl("../graphics/glyphicons_free/glyphicons/png/glyphicons-267-flag.png")
        onTriggered: {
            onClicked: {
                if (!battleEnded) {
                    //TODO popup
                    analyserAccess.forfeit();
                } else {
                    analyserAccess.forfeit();
                }

                goBack();
            }
        }
    }

    anchors.fill: parent

    Connections {
        target: analyserAccess
        onSwitchAllowed: switchEnabled = true;
        onBattleEnded: {
            battleEnded = true;
        }
        onSwitchToPokemonTab: {
            mustSwitchPokemon = true;
        }
    }

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted: {
            logHtml += line.replace(/<(?:.|\n)*?>/gm, '').replace("&apos;", '\''); + "\n"
            tabView.currentIndex = 2;
        }
    }

    Item {
        id: battleSceneContainer
        width: parent.width
        anchors {
            top: parent.top
            bottom: tabView.top
        }

        Component.onCompleted: analyserAccess.createBattleSceneItem(battleSceneContainer)
    }

    Item {
        id: tabView
        width: parent.width
        height: U.dp(3)
        anchors.bottom: parent.bottom
        property int currentIndex: 0
        Row {
            id: tabButtons
            width: parent.width
            height: U.dp(0.4)

            Item {
                height: parent.height
                width: U.dp(0.1)
            }

            Repeater {
                model: ["Moves", "Pokemons","Log"]
                delegate: Button {
                    text: modelData
                    onClicked: tabView.currentIndex = index;
                    height: tabButtons.height
                    width: implicitWidth + U.dp(0.2)
                    style: ButtonStyle {
                        background: Rectangle {
                            radius: U.dp(0.1)
                            anchors {
                                fill: parent
                            }
                            color: (control.pressed || (tabView.currentIndex == index)) ? "#D6D3CF" : "#E6E4E2"
                        }
                    }
                }
            }
        }

        Item {
            id: tabContent
            width: parent.width
            anchors {
                top: tabButtons.bottom
                bottom: parent.bottom
            }

            Rectangle {
                anchors.fill: parent
                color: "#F6F6F5"
            }

            Flow {
                visible: tabView.currentIndex == 0
                anchors.fill: parent
                Repeater {
                    model: analyserAccess.attackListModel
                    delegate: Button {
                        id: atkButton
                        enabled: true
                        width: tabContent.width / 2
                        height: tabContent.height / 2

                        style: ButtonStyle {
                            background: Item {
                                Rectangle {
                                    radius: U.dp(0.1)
                                    anchors {
                                        fill: parent
                                        margins: U.dp(0.1)
                                    }
                                    color: attackColor
                                    opacity: control.pressed ? 1.0 : 0.5
                                }
                            }
                        }

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
                        Label {
                            text: name
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: U.dp(-0.1)
                        }

                        Label {
                            text: "PP " + pp + "/" + maxpp
                            anchors {
                                bottom: parent.bottom
                                right: parent.right
                                margins: U.dp(0.1)
                            }

                        }
                    }
                }
            }
            Item {
                id: pokemonsTab
                visible: tabView.currentIndex == 1
                anchors.fill: parent
                anchors.margins: U.dp(0.1)
                Flow {
                    spacing: U.dp(0.1)
                    width: parent.width
                    Repeater {
                        model: analyserAccess.pokemonListModel
                        delegate: Button {
                            height: U.dp(0.6)
                            width: Math.max(pokemonsTab.width / 2 - U.dp(0.1), U.dp(2))
                            Image {
                                id: pokeIcon
                                anchors {
                                    left: parent.left
                                    leftMargin: U.dp(0.1)
                                    verticalCenter: parent.verticalCenter
                                }

                                source: "image://pokeinfo/icon/" + num;
                            }

                            Column {
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                    right: parent.right
                                    left: pokeIcon.right
                                    leftMargin: U.dp(0.1)
                                }

                                Label {
                                    text: name
                                }
                                Label {
                                    text: hp + "/" + hpMax
                                }
                            }
                            enabled: switchEnabled && !isKoed && index != 0
                            onClicked: {
                                disable();
                                switchEnabled = false;
                                mustSwitchPokemon = false;
                                analyserAccess.switchClicked(index)
                            }
                        }
                    }
                }
            }

            TextArea {
                anchors.fill: parent
                visible: tabView.currentIndex == 2
                text: logHtml
                onTextChanged: flickableItem.contentY = flickableItem.contentHeight - height
                readOnly: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: tabView.currentIndex = (mustSwitchPokemon ? 1 : 0);
                }
                style: TextAreaStyle {
                    backgroundColor: "#F6F6F5"
                }
            }
        }
    }
}
