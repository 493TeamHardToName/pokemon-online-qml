import QtQuick 2.0
import PokemonOnlineQml 1.0
import "../components"
import "../js/units.js" as U

import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
Page {
    id: root
    signal goBack;
    signal randomGame;
    signal goFindGame;
    property bool attempConnect : false

    property var fruitModel: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    property var vegetableModel: [0,0,0,0,0,0]
    anchors.fill: parent

    title: "Build team"
    actions: [
        Action {
            text: "Login"
            iconSource: Qt.resolvedUrl("../graphics/glyphicons_free/glyphicons/png/glyphicons-387-log-in.png")
            onTriggered: {
                attempConnect = true;
                analyserAccess.setCurrentTeam();
                analyserAccess.connectTo("188.165.244.152", 5080)
                //if(analyserAccess.isConnect == true){
                  //     goFindGame();
                //}
                //goFindGame();
            }
        }
    ]

    Connections{
        target: analyserAccess
        onLoggedIn: {
            goFindGame();
            error_text.text = ""
            attempConnect = false;
        }
        onLogInFailed: {
            if(attempConnect){
               error_text.text = error_msg
                attempConnect = false;
            }
        }
    }

    TeamHolder {
        id: teamHolder
    }

    PokeTableModel {
        id: pokeTableModel;
        //hold a list of all pokemons
    }

    Rectangle{
        width: root.width
        height: root.height
    Image {
               anchors.fill: parent
               opacity: 0.5
               source: Qt.resolvedUrl("../graphics/background2.jpeg")

            }


    Column{
        Rectangle{
            color: "transparent"
            id: setNameWindow
            width:root.width
            height: root.height/15
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
        Text{
            id : error_text
            color: "red"
        }

        Rectangle{
         id: titleWindow
         color: "transparent"
         width:root.width
         height: root.height/8

         Text{
             anchors.centerIn: parent
             font.pointSize: 25
             color: "darkblue"
             text:"Build your Team"
         }
        }
        Rectangle{
            id: selectWindow
            width:root.width
            height:root.height/3
            color : "transparent"
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
                        id: pokeName
                        width:75
                        height:root.height/16
                        checkable: true
                        style: ButtonStyle {
                                background: Rectangle {
                                    id: buttonReg
                                    implicitWidth: pokeName.width
                                    implicitHeight: pokeName.height
                                    border.width: control.activeFocus ? 2 : 1
                                    border.color: "#888"
                                    radius: 8
                                    gradient: Gradient {
                                            GradientStop { position: 0.0; color:  "white" }
                                            GradientStop { position: 1.0; color: control.pressed ? "darkred" :"darkblue" }
                                    }
                                    Text{
                                        text: analyserAccess.getPokeName(index);
                                        font.pointSize: 12
                                        anchors.centerIn: parent
                                        color: "white"
                                    }
                                }
                            }

                        //text: analyserAccess.getPokeName(index);//"Pos" + (index+1)
                        anchors.horizontalCenter: pokeImage.horizontalCenter
                        onClicked: analyserAccess.setTeam(index);
                    }
                }
           }
        }



        Rectangle{
            id: pokeInfoWindow
            color: "transparent"
            width:root.width
            height:root.height/6
            border.width: 1
            border.color: "blue"

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
            height: root.height/7
            color: "transparent"
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
            color: "transparent"
            Button{
                width: parent.width/3
                height:parent.height/1.5
                style: ButtonStyle {
                        background: Rectangle {
                            anchors.fill: parent
                            border.width: control.activeFocus ? 2 : 1
                            border.color: "#888"
                            radius: 8
                            gradient: Gradient {
                                    GradientStop { position: 0.0; color: "white" }
                                    GradientStop { position: 1.0; color: control.pressed ? "darkred" :"darkblue" }
                            }
                            Text{
                                text: "Random Team"
                                font.pointSize: 12
                                anchors.centerIn: parent
                                color: "white"
                            }
                        }
                }
                anchors {
                    right: parent.right
                    rightMargin: U.dp(0.2)
                    verticalCenter: parent.verticalCenter
                 }
                onClicked: {
                    analyserAccess.generateRandomTeam();
                }
            }
        }

    }
    }
}
