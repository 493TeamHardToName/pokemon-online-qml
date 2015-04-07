import QtQuick 2.0
import PokemonOnlineQml 1.0
import "../components"
import "../js/units.js" as U

import QtQuick.Controls 1.3
Page {
    id: root
    signal goBack;
    signal randomGame;
    signal goFindGame;

    property var fruitModel: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    property var vegetableModel: [0,0,0,0,0,0]
    anchors.fill: parent

    title: "Build team"
    actions: [
        Action {
            text: "Login"
            onTriggered: {
                analyserAccess.setCurrentTeam();
                goFindGame();
            }
        }
    ]

    TeamHolder {
        id: teamHolder
    }

    PokeTableModel {
        id: pokeTableModel;
        //hold a list of all pokemons
    }

    Flickable {
        anchors.fill: parent
        contentWidth: flow.width
        contentHeight: flow.height

    Flow {
        id: flow
        width: root.width
        Text {
            text: "Build team"
        }
        Text { text: "Choose your characters" }
        Button{
            text: "Random Build Team"
            onClicked: {
                analyserAccess.generateRandomTeam();
            }
        }

        Repeater {
            model: fruitModel
            delegate:
            Column {
                Image {
                    id: pokeImage
                    width: 75
                    height: 75
                    source: "image://pokeinfo/pokemon/" + analyserAccess.getPokeId(index);
                    MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pokeImage.source = "image://pokeinfo/pokemon/5"
                            }
                    }
                }

                Button {
                    text: analyserAccess.getPokeName(index);//"Pos" + (index+1)
                    anchors.horizontalCenter: pokeImage.horizontalCenter
                    onClicked: analyserAccess.setTeam(index);
                }
            }
        }

        Repeater{
            model: vegetableModel

            delegate:
            Column{
                Image{
                    id: teamImage
                    width :50
                    height: 50
                    source: "image://pokeinfo/pokemon/" + analyserAccess.getPokeId(analyserAccess.userTeamInfo(index));
                }

                Connections {
                    target: analyserAccess
                    onPokemonSelected: {
                               teamImage.source="image://pokeinfo/pokemon/" + analyserAccess.getPokeId(analyserAccess.userTeamInfo(index));
                    }
                }

                Button {
                  text: "Pos" + (index+1)
                  anchors.horizontalCenter: teamImage.horizontalCenter
                  onClicked: analyserAccess.setPos(index);
                }
            }
        }
//        Button {
//            text: "Confirm Team"
//            onClicked: analyserAccess.setCurrentTeam();
//        }

//        Button {
//            text: "Download Team"
//            onClicked: analyserAccess.downloadTeam();
//        }

//        Button {
//            text: "Back to server list"
//            onClicked: goBack();
//        }


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
    }
   }
 }
