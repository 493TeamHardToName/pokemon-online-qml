import QtQuick 2.4
import PokemonOnlineQml 1.0
import "../components"
import "../js/units.js" as U

import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Page {
    signal startGame

    Item {
        width: U.dp(5)
        height: allItems.height
        anchors.centerIn: parent
        Column {
            id: allItems
            Image {
                id: logo
                source: Qt.resolvedUrl("../graphics/pokemonLogo.png")
                width: U.dp(5)
                height: U.dp(2)
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                height: U.dp(4.5)
                Image {
                    id: pikachu
                    source: Qt.resolvedUrl("../graphics/pikachu.png")
                    width: U.dp(3.5)
                    height: U.dp(3.5)
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item {
                    id: buttons
                    width: U.dp(1)
                    height: U.dp(1.2)
                    anchors.verticalCenter: parent.verticalCenter
                    Column {
                        spacing: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            id: startButton
                            width: buttons.width
                            height: buttons.height / 3
                            style: ButtonStyle {
                                background: Rectangle {
                                    radius: 8
                                    gradient: Gradient {
                                            GradientStop { position: 0.0; color: "white" }
                                            GradientStop { position: 1.0; color: control.pressed ? "darkred" : "darkblue"}
                                    }
                                }
                            }

                            Text {
                                text: "Start"
                                font.pointSize: 12
                                color: "white"
                                anchors.centerIn: parent
                            }

                            onClicked: {
                                startGame();
                            }
                        }

                        Button {
                            id: infoButton
                            width: buttons.width
                            height: buttons.height / 3

                            style: ButtonStyle {
                                background: Rectangle {
                                    radius: 8
                                    gradient: Gradient {
                                            GradientStop { position: 0.0; color: "white" }
                                            GradientStop { position: 1.0; color: control.pressed ? "darkred" : "darkblue"}
                                    }
                                }
                            }

                            Text {
                                text: "Info"
                                font.pointSize: 12
                                color: "white"
                                anchors.centerIn: parent
                            }

                            onClicked: {

                            }
                        }
                    }
                }
            }
        }
    }
}

