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
    signal goBack();
    signal disable();

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
            tabView.currentIndex = 1;
        }
    }

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted: {
            logHtml += line.replace(/<(?:.|\n)*?>/gm, '').replace("&apos;", '\''); + "\n"
            stuffAtBottom.currentIndex = 2;
        }
    }

    Item {
        id: battleSceneContainer
        width: parent.width
        anchors {
            top: parent.top
            bottom: stuffAtBottom.top
        }

        Component.onCompleted: analyserAccess.createBattleSceneItem(battleSceneContainer)
    }

    SplitView {
        id: stuffAtBottom
        width: parent.width
        height: U.dp(3)
        anchors.bottom: parent.bottom
        Item {
            id: tabView
            width: parent.width / 2
            height: parent.height
            property int currentIndex: 0
            Row {
                id: tabButtons
                height: moveB.height
                Button {
                    id: moveB
                    text: "Moves"
                    onClicked: tabView.currentIndex = 0;
                }
                Button {
                    text: "Pokemons"
                    onClicked: tabView.currentIndex = 1;
                }
            }

            Item {
                id: attackTab
                visible: tabView.currentIndex == 0
                anchors {
                    top: tabButtons.bottom
                    bottom: parent.bottom
                }
                width: parent.width
                ListView {
                    anchors.fill: parent
                    model: analyserAccess.attackListModel
                    delegate: Button {
                        id: atkButton
                        enabled: true
                        width: parent.width
                        height: attackTab.height / 4

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
                visible: tabView.currentIndex == 1
                anchors {
                    top: tabButtons.bottom
                    bottom: parent.bottom
                }
                width: parent.width
                ListView {
                    id: pokesColumn
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                        leftMargin: U.dp(0.1)
                        rightMargin: U.dp(0.1)
                    }
                    spacing: U.dp(0.1)
                    model: analyserAccess.pokemonListModel
                    clip: true
                    delegate: Button {
                        height: U.dp(0.6)
                        width: parent.width
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
                            tabView.currentIndex = 0;
                            disable()
                            switchEnabled = false
                            analyserAccess.switchClicked(index)
                        }
                    }
                }
            }
        }
        TextArea {
            id: logWebview
            width: parent.width / 2
            height: parent.height
            text: logHtml
            onTextChanged: flickableItem.contentY = flickableItem.contentHeight - height
        }
    }
}
