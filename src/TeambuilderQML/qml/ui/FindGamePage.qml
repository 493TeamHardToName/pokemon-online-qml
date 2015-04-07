import QtQuick 2.4
import "../components"
import PokemonOnlineQml 1.0
import "../js/units.js" as U
import QtQuick.Controls 1.3

Page {
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
            height: name.indexOf("poqmtest") == 0 ? 25 : 0//name is a variable of playersInfoListModel
            width: 500

            clip: true
            Text {
                text: {
                    var text = "Name: " + name + " IsBattling: " + isBattling
                    if (item.VisualDataModel.inSelected)
                        text += " (" + item.VisualDataModel.selectedIndex + ")"
                    return text;
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!item.VisualDataModel.inSelected)
                        selectedGroup.remove(0, selectedGroup.count)
                    item.VisualDataModel.inSelected = !item.VisualDataModel.inSelected
                }
            }
        }
    }
    Column {
        width: parent.width
        Text {
            text: "Online players"
        }
        ListView {
            width: parent.width
            height: U.dp(4)
            model: visualModel
        }
        Button {
            id: challengeButton
            text: "Challenge"
            onClicked:  {
//                text = "Challenging"
//                analyserAccess.challengeDeclined.connect(function (){
//                    challengeButton.text = "Challenge";
//                });
                waitingDialog.visible = true

                analyserAccess.sendChallenge(selectedGroup.get(0).model.playerId)
            }
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
}
