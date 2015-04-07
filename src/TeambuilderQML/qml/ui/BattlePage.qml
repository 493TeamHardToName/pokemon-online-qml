import QtQuick 2.0
import QtQuick.Controls 1.3
import QtWebKit 3.0
import "../components" as Comp
import "../js/units.js" as U

Comp.Page {
    id: root

    property bool switchEnabled:  true
    property string logHtml: ""
    signal goBack();
    signal disable();

    backAction: Action {
        text: "Forfeit"
        onTriggered: {
            onClicked: {
                //TODO forfeit
                goBack();
            }
        }
    }

    onDisable: console.log("root disabled")
    anchors.fill: parent

    Connections {
        target: analyserAccess.battleClientLog
        onLineToBePrinted: {
            logWebview.loadHtml(logHtml);
            logHtml += line + "\n"
        }
    }

    Connections {
        target: analyserAccess
        onSwitchAllowed: switchEnabled = true;
    }

    Item {
        width: parent.width
        Column {
            id: battleSceneContainer
            width: parent.width
            Component.onCompleted: analyserAccess.createBattleSceneItem(battleSceneContainer)
        }

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
                    text: name
                    enabled: switchEnabled && !isKoed
                    onClicked: {
                        disable()
                        switchEnabled = false
                        analyserAccess.switchClicked(index)
                    }
                }
            }
        }

        WebView {
            id: logWebview
            width: parent.width
            height: U.dp(1)
            onLoadingChanged: {
                if (!loading) {
                    setContentYTimer.restart();
                }
            }
        }

        TextArea {
            id: logTextArea
            width: parent.width
            height: U.dp(3)
        }
    }
    Timer {
        id: setContentYTimer
        property int contentYTarget: 0
        interval: 100
        repeat: false
        onTriggered: logWebview.contentY = logWebview.contentHeight - logWebview.height
    }
}
