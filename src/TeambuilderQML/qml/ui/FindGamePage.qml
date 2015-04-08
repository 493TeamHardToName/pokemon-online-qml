import QtQuick 2.4
import "../components"
import PokemonOnlineQml 1.0
import "../js/units.js" as U
import QtQuick.Controls 1.3

Page {
    property int playerid;
    signal goBack;
    signal goToBattle;
    anchors.fill: parent

    title: 'Online Players'

    backAction: Action {
        text: "Back"
        onTriggered: {
            analyserAccess.logout();
            goBack();
        }
    }

    Component.onCompleted: analyserAccess.connectTo("188.165.244.152", 5080)

    Component {
        id: challengePopupComponent
        ChallengeDialog {
            onDecline: analyserAccess.declineChallenge();
            onAccept: analyserAccess.acceptChallenge();
        }
    }

    Connections {
        target: analyserAccess
        onChallengeRecieved: challengePopupComponent.createObject(
                                 pokemonOnlineQml, {
                                    playerName: playerName
                                 });
        onBattleStarted: {
            goToBattle();
            waitingDialog.visible = false;
        }
        onChallengeDeclined: {
            waitingDialog.visible = false;
        }
    }

    VisualDataModel {
        id: visualModel
        model: analyserAccess.playersInfoListModel
        groups: [
            VisualDataGroup {
                id: selectedGroup
                name: "selected"
            }
        ]
        delegate: Rectangle {
            id: item
            height: name.indexOf("poqmtest") == 0 ? 25 : 0 //name is a variable of playersInfoListModel
            width: 250

            clip: true
            Text {
                text: {
                    var text = "Name: " + name.substring(9)
                    if(isBattling)
                        color = "grey"
                    return text;
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(!isBattling) {
                        challengeMenu.popup()
                        playerid = playerId
                    }
                }
            }
        }
    }
    Column {
        width: parent.width
        ListView {
            width: parent.width
            height: U.dp(4)
            model: visualModel
        }
    }

    WaitingDialog {
        id: waitingDialog
        visible: false
    }

    MouseArea {
        id: blockArea
        anchors.fill: parent
        onClicked: {}
        enabled: waitingDialog.visible
    }

    Menu {
        id: challengeMenu
        MenuItem {
            text: "Challenge"
            onTriggered: {
                waitingDialog.visible = true
                analyserAccess.sendChallenge(playerid)
                challengeMenu.visible = false
            }
        }
    }
}
