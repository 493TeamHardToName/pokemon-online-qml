import QtQuick 2.4
import QtQuick.Dialogs 1.2
import "../components"
import PokemonOnlineQml 1.0
import "../js/units.js" as U
import QtQuick.Controls 1.3

Page {
    property int playerid;
    property string adversaryName;
    signal goBack;
    signal goToBattle;
    anchors.fill: parent

    title: 'Game Lobby'

    backAction: Action {
        text: "Back"
        iconSource: Qt.resolvedUrl("../graphics/glyphicons_free/glyphicons/png/glyphicons-225-chevron-left.png")
        onTriggered: {
            analyserAccess.logout();
            goBack();
        }
    }

    //Component.onCompleted: analyserAccess.connectTo("188.165.244.152", 5080)

    Connections {
        target: analyserAccess
        onChallengeRecieved: {
            challengeDialog.playerName = playerName;
            challengeDialog.open();
        }
        onBattleStarted: {
            waitingDialog.close();
            goToBattle();
        }
        onChallengeDeclined: {
            waitingDialog.text = "Player " + waitingDialog.playerName.substring(9) + " declined your challenge. ";
            waitingDialog.standardButtons = StandardButton.Close;
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

        delegate: Item {
            id: item
            height: (name.indexOf("poqmtest") === 0 && playerId !== analyserAccess.currentPlayerId()) ? 30 : 0 //name is a variable of playersInfoListModel
            width: parent.width
            clip: true

            Row {
                spacing: 10

                Column {
                    height: parent.height
                    width: 15
                }

                Image {
                    id: statusImg
                    source: {
                        var path = Qt.resolvedUrl("../../Themes/Classic/client/uAvailable.png")
                        if(isBattling)
                            path = Qt.resolvedUrl("../../Themes/Classic/client/uBattle.png")
                        return path
                    }
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    font.pointSize: 16
                    text: {
                        color = "darkblue"
                        var text = name.substring(9)
                        if(isBattling)
                            color = "grey"
                        return text;
                    }
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(!isBattling) {
                        playerid = playerId;
                        adversaryName = name;
                        waitingDialog.playerName = name;
                        challengeMenu.popup();
                    }
                }
            }
        }
    }

    Column {
        width: parent.width
        spacing: 10

        Row {
            height: 10
            width: 100
        }

        Label {
            font.pointSize: 20
            text: "Your ID: " + analyserAccess.playersInfoListModel.findPlayerNameById(
                      analyserAccess.currentPlayerId()).substring(9)
            color: "darkblue"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            width: parent.width
            height: 2
            color: "darkblue"
        }

        Row {
            spacing: 10
            Column {
                height: parent.height
                width: 15
            }
            Label {
                font.pointSize: 16
                text: "Online Players"
                color: "darkblue"
            }
        }

        ListView {
            width: parent.width
            height: U.dp(4)
            model: visualModel
        }

        Row {
            height: 10
            width: 100
        }
    }

    ChallengeDialog{
        id: challengeDialog
        onAccept: analyserAccess.acceptChallenge();
        onDecline: analyserAccess.declineChallenge();
    }

    WaitingDialog {
        id: waitingDialog
    }

    Menu {
        id: challengeMenu
        MenuItem {
            text: "Challenge to " + adversaryName.substring(9)
            onTriggered: {
                waitingDialog.open()
                analyserAccess.sendChallenge(playerid)
                challengeMenu.visible = false
            }
        }
    }
}
