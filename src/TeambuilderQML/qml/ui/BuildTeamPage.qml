import QtQuick 2.0
import PokemonOnlineQml 1.0
import "../components"
import "../js/units.js" as U
Rectangle {
    signal goBack;
    signal randomGame;
    signal goFindGame;

    anchors.fill: parent

    TeamHolder {
        id: teamHolder
    }

    PokeTableModel {
        id: pokeTableModel;
        //hold a list of all pokemons
    }

    Flow {
        anchors.fill: parent
        Text {
            text: "Build team"
        }
        Text{text: "Choose your characters"}
        Button{
            text: "Random Build Team"
            onTriggered: {
                analyserAccess.setCurrentTeam();
                //call random build team function
                //display team member
            }
        }


        Button {
            text: "Pos1"
            onTriggered: analyserAccess.setPos(0);
        }
        Button {
            text: "Pos2"
            onTriggered: analyserAccess.setPos(1);
        }
        Button {
            text: "Pos3"
            onTriggered: analyserAccess.setPos(2);
        }
        Button {
            text: "Pos4"
            onTriggered: analyserAccess.setPos(3);
        }
        Button {
            text: "Pos5"
            onTriggered: analyserAccess.setPos(4);
        }
        Button {
            text: "Pos6"
            onTriggered: analyserAccess.setPos(5);
        }

        Button {
            text: "Pokon1"
            onTriggered: analyserAccess.setTeam(0);
        }
        Button {
            text: "Pokon2"
            onTriggered: analyserAccess.setTeam(1);
        }
        Button {
            text: "Pokon3"
            onTriggered: analyserAccess.setTeam(2);
        }
        Button {
            text: "Pokon4"
            onTriggered: analyserAccess.setTeam(3);
        }
        Button {
            text: "Pokon5"
            onTriggered: analyserAccess.setTeam(4);
        }
        Button {
            text: "Pokon6"
            onTriggered: analyserAccess.setTeam(5);
        }
        Button {
            text: "Pokon7"
            onTriggered: analyserAccess.setTeam(6);
        }
        Button {
            text: "Pokon8"
            onTriggered: analyserAccess.setTeam(7);
        }
        Button {
            text: "Pokon9"
            onTriggered: analyserAccess.setTeam(8);
        }
        Button {
            text: "Pokon10"
            onTriggered: analyserAccess.setTeam(9);
        }
        Button {
            text: "Pokon11"
            onTriggered: analyserAccess.setTeam(10);
        }
        Button {
            text: "Pokon12"
            onTriggered: analyserAccess.setTeam(11);
        }
        Button {
            text: "Pokon13"
            onTriggered: analyserAccess.setTeam(12);
        }
        Button {
            text: "Pokon14"
            onTriggered: analyserAccess.setTeam(13);
        }
        Button {
            text: "Pokon15"
            onTriggered: analyserAccess.setTeam(14);
        }
        Button {
            text: "Pokon16"
            onTriggered: analyserAccess.setTeam(15);
        }
        Button {
            text: "Pokon17"
            onTriggered: analyserAccess.setTeam(16);
        }
        Button {
            text: "Pokon18"
            onTriggered: analyserAccess.setTeam(17);
        }

        Button {
            text: "Confirm Team"
            onTriggered: analyserAccess.setCurrentTeam();
        }

        Button {
            text: "Download Team"
            onTriggered: analyserAccess.downloadTeam();
        }

        Button {
            text: "Back to server list"
            onTriggered: goBack();
        }


        Rectangle {
            width: U.dp(2)
            height: U.dp(0.3)
            border {
                color: "black"
                width: 2
            }

            TextInput {
                id: nameInput
                anchors.fill: parent
                onTextChanged: analyserAccess.setPlayerName(text)
            }
        }

        Button {
            text: "Find game"
            onTriggered: goFindGame();
        }
    }
}
