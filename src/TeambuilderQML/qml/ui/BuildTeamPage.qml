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
    property bool pokeVis : false
    property bool buttonEn : false
    property bool buttonCancel : false

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

    Image {
       anchors.fill: parent
       opacity: 0.5
       source: Qt.resolvedUrl("../graphics/background2.jpeg")
    }
    Flickable {
        anchors.fill: parent
        contentHeight: mainContentColumn.height +U.dp(0.2)
        contentWidth: width
    Column{
        id: mainContentColumn
        anchors {
            left: parent.left
            right: parent.right
            margins: U.dp(0.15)
            top:parent.top
        }

        Rectangle{
            color: "transparent"
            id: setNameWindow
            width:root.width
            height: root.height/15
            Row{
                spacing: U.dp(0.1)
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
            id: teamWindow
            width:parent.width
            height: myTeamBox.height
            color: "transparent"
            border.color: "darkblue"
            border.width: U.dp(0.03)
            Column{
                id:myTeamBox
                width: parent.width
                anchors.top: teamWindow.top
                anchors.left: teamWindow.left
                anchors.margins: U.dp(0.1)
                Text{font.family: "Apple Chancery"; text: "Your Team:"; font.bold: true; font.pointSize: U.dp(0.2); color: "darkblue" }
                ListView{
                        model: visualModel
                        height: U.dp(1)
                        width: parent.width
                        orientation: ListView.Horizontal
                        interactive: false
                }
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
                        }
                }
                Text{
                    text: "Random Team"
                    font.pointSize: 12
                    anchors.centerIn: parent
                    color: "white"
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

            Button{
                id : chooseButton
                enabled: buttonEn ? true : false
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
                                    GradientStop { position: 1.0; color: buttonEn ? (control.pressed ? "darkred" :"darkblue") : "darkgrey" }
                            }
                        }
                }
                Text{
                    text: buttonCancel ? "Cancel" :  "Choose Pokemon"
                    font.pointSize: 12
                    anchors.centerIn: parent
                    color: "white"
                }
                anchors {
                    left: parent.left
                    leftMargin: U.dp(0.2)
                    verticalCenter: parent.verticalCenter
                 }
                onClicked: {
                    if(!buttonCancel)
                        pokeVis = true;
                    else
                        pokeVis = false;
                    buttonCancel = !buttonCancel;
                }
            }
        }


        Rectangle{
            id: selectWindow
            width:root.width
            height:pokeVis ? root.height/3 : 0
            clip: true
            Behavior on height {
                NumberAnimation { duration: 400 }
            }
            color : "transparent"
            ListView{
                model: fruitModel
                width: selectWindow.width
                height: selectWindow.height
                orientation: ListView.Horizontal
                interactive: true
                delegate:
                Column {
                    id : pokeCard
                    width: fruitModel.width
//                    height: fruitModel.height
                    Image {
                        id: pokeImage
                        width: U.dp(1.25)
                        height: width
                        source: "image://pokeinfo/pokemon/" + analyserAccess.getPokeId(index);
                        MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    pokeInfoWindow.infoModel = analyserAccess.getPokeInfo(index);
                                }
                        }
                    }

                    Button {
                        id: pokeName
                        width:U.dp(1.1)
                        height:pokeCard.height/5
                        checkable: true
                        style: ButtonStyle {
                                background: Rectangle {
                                    id: buttonReg
                                    anchors.fill: parent
                                    border.width: control.activeFocus ? 2 : 1
                                    border.color: "#888"
                                    radius: 8
                                    gradient: Gradient {
                                            GradientStop { position: 0.0; color:  "white" }
                                            GradientStop { position: 1.0; color: control.pressed ? "darkred" :"darkblue" }
                                    }
                                }
                            }
                        Text{
                            text: analyserAccess.getPokeName(index);
                            font.pointSize: 12
                            anchors.centerIn: pokeName
                            color: "white"
                        }
                        anchors.horizontalCenter: pokeImage.horizontalCenter
                        onClicked: {
                            pokeVis = false;
                            buttonCancel = false;
                            analyserAccess.setTeam(index);
                        }
                    }
                }
           }
        }

        Rectangle {
            color: "transparent"
            width:parent.width
            height:pokeInfoWindow.height + U.dp(0.2)
            border.width: 1
            border.color: "blue"
            visible: (pokeInfoWindow.height==0) ? false : true
            PokemonDetails {
                id: pokeInfoWindow
                width: parent.width
                anchors.top : parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.margins: U.dp(0.1)
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
                width : teamWindow.width/6
                height : parent.height
                Item{
                    width: parent.width
                    height: width
                    Image{
                        id: teamImage
                        anchors.fill:parent
                        anchors.margins: item.VisualDataModel.inSelected ? -U.dp(0.35) : 0
                        source: "image://pokeinfo/pokemon/" + analyserAccess.getPokeId(analyserAccess.userTeamInfo(index));
                    }
                    MouseArea {
                            id: mArea
                            anchors.fill: parent
                            Rectangle {
                                       id: backGround
                                       anchors.fill: parent
                                       //border.width: 2
                                       //color: item.VisualDataModel.inSelected ? "grey" : "transparent"
                                       //border.color: item.VisualDataModel.inSelected ? "lightblue " : "transparent"
                                       color: "transparent"
                                   }
                            onClicked: {
                                if (!item.VisualDataModel.inSelected)
                                    selectedGroup.remove(0, selectedGroup.count)
                                item.VisualDataModel.inSelected = !item.VisualDataModel.inSelected
                                buttonEn = item.VisualDataModel.inSelected;
                                if(!buttonEn){
                                    pokeVis = false;
                                    buttonCancel = false;
                                }
                                analyserAccess.setPos(index);
                                pokeInfoWindow.infoModel = analyserAccess.getPokeInfo(analyserAccess.userTeamInfo(index));
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



    }
    }
}
