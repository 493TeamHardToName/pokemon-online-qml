import QtQuick 2.4
import QtQuick.Controls 1.3
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
                    analyserAccess.forfeit();
                }
                goBack();
            }
        }
    }

    anchors.fill: parent

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted: {
            logHtml += line + "\n"
            logWebview.text = logHtml;
            logWebview.flickableItem.contentY = logWebview.flickableItem.contentHeight - logWebview.height
        }
    }

    Connections {
        target: analyserAccess
        onSwitchAllowed: switchEnabled = true;
        onBattleEnded: {
            battleEnded = true;
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

    Column {
        id: stuffAtBottom
        anchors.bottom: parent.bottom
        width: parent.width
        Flow {
            width: parent.width
            Repeater {
                model: analyserAccess.attackListModel
                delegate: Button {
                    id: atkButton
                    enabled: true
                    text: name + " " + pp + "/" + maxpp
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
                    text: name + " " + hp + "/" + hpMax
                    enabled: switchEnabled && !isKoed && index != 0
                    onClicked: {
                        disable()
                        switchEnabled = false
                        analyserAccess.switchClicked(index)
                    }
                }
            }
        }

        TextArea {
            id: logWebview
            width: parent.width
            height: U.dp(1)
        }
    }
}
