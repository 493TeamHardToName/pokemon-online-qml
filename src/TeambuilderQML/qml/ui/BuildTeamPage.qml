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
            iconSource: Qt.resolvedUrl("../graphics/glyphicons_free/glyphicons/png/glyphicons-387-log-in.png")
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

    Column{
        Rectangle{
            id: setNameWindow
            width:root.width
            height: root.height/12
            Row{
                    Text{
                        text:"Team name:"
                    }

                    Rectangle {
                        width: U.dp(2)
                        height: U.dp(0.3)
                        border {
                            color: "black"
                            width: 2
                        }
                        TextField {
                            id: nameInput
                            anchors.fill: parent
                            onTextChanged: analyserAccess.setPlayerName(text)
                        }
                    }
                }
             }

        Rectangle{
         id: titleWindow
         width:root.width
         height: root.height/12
         Text{
             anchors.centerIn: parent
             font.pointSize: 16
             text:"Build your Team"
         }
        }
        Rectangle{
            id: selectWindow
            width:root.width
            height:root.height/3
            ListView{
                model: fruitModel
                anchors.fill: parent
                orientation: ListView.Horizontal
                interactive: true
                delegate:
                Column {
                    Image {
                        id: pokeImage
                        width: 100
                        height: 100
                        source: "image://pokeinfo/pokemon/" + analyserAccess.getPokeId(index);
                        MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    //pokeImage.source = "image://pokeinfo/pokemon/5"
                                    //get move information;
                                    analyserAccess.getMoves(index);
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
        }



        Rectangle{
            id: pokeInfoWindow
            width:root.width
            height:root.height/6
            border.width: 1
            border.color: "lightblue"

            Column{
                Text{
                    text: "Pokemon Info:"
                }
            }
        }

        VisualDataModel{
            id: visualModel
            model: vegetableModel
            groups: [
                VisualDataGroup {
                    id: selectedGroup
                    name: "selected"
                }
            ]
            delegate:
            Column{
                id : item
                width : root.width/6
                Image{
                    id: teamImage
                    width: parent.width
                    height: width
                    source: "image://pokeinfo/pokemon/" + analyserAccess.getPokeId(analyserAccess.userTeamInfo(index));
                    MouseArea {
                            id: mArea
                            anchors.fill: parent
                            Rectangle {
                                       id: backGround
                                       anchors.fill: parent
                                       border.width: 2
                                       border.color: item.VisualDataModel.inSelected ? "red " : "transparent"
                                       color: "transparent"
                                   }
                            onClicked: {
                                if (!item.VisualDataModel.inSelected)
                                    selectedGroup.remove(0, selectedGroup.count)
                                item.VisualDataModel.inSelected = !item.VisualDataModel.inSelected
                                analyserAccess.setPos(index);
                            }
                    }
                }
                Connections {
                    target: analyserAccess
                    onPokemonSelected: {
                               teamImage.source="image://pokeinfo/pokemon/" + analyserAccess.getPokeId(analyserAccess.userTeamInfo(index));
                    }
                }
            }
        }


        Rectangle{
            id: teamWindow
            width:root.width
            height: root.height/6
            ListView{
                model: visualModel
                anchors.fill: parent
                orientation: ListView.Horizontal
                interactive: false        
            }
        }

        Rectangle{
            id: bottom
            width: root.width
            height: root.height/12
            Button{
                width: parent.width/4
                anchors {
                    right: parent.right
                    rightMargin: U.dp(0.2)
                    verticalCenter: parent.verticalCenter
                 }

                text: "Random Team"
                onClicked: {
                    analyserAccess.generateRandomTeam();
                }
            }
        }

    }
}
