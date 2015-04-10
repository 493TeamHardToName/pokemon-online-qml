import QtQuick 2.4
import QtQuick.Controls 1.3
import PokemonOnlineQml 1.0
import "../js/units.js" as U

Item {
    id: root
    height: infoModel ? col.height : 0
    clip: true
    property var infoModel: null

    Behavior on height {
        NumberAnimation { duration: 400 }
    }

    Button {
        iconSource: Qt.resolvedUrl("../graphics/glyphicons_free/glyphicons/png/glyphicons-601-chevron-up.png")
        onClicked: infoModel = null
        height: U.dp(0.3)
        width: height
        anchors {
            top: parent.top
            right: parent.right
            margins: U.dp(0.1)
        }
    }

    Column {
        id: col
        width: parent.width
        spacing: U.dp(0.1)

        Row {
            height: iconCol.height
            spacing: U.dp(0.5)
            Column {
                id: iconCol
                width: U.dp(1)
                Image {
                    source: "image://pokeinfo/pokemon/" + infoModel.num.split(":")[0];
                    width: U.dp(1)
                    height: width
                }

                Label {
                    text: PokemonInfoAccess.pokemonName(infoModel.num)
                }
                Label {
                    text: "Lv. " + root.infoModel.level
                }
                Row {
                    id: typeList
                    TypeBox {
                        type: root.infoModel.types[0]
                    }

                    TypeBox {
                        type: root.infoModel.types[1] ? root.infoModel.types[1] : 18
                    }
                }
            }
            Column {
                width: col.width - iconCol.width
                StatBox {
                    width: parent.width
                    stats: PokemonInfoAccess.pokemonBaseStates(infoModel.num, infoModel.gen)
                }
            }
        }

        Flow {
            width: parent.width
            spacing: U.dp(0.05)
            Repeater {
                model: infoModel.moves
                delegate: Rectangle {
                    width: U.dp(1.1)
                    height: U.dp(0.4)
                    radius: U.dp(0.05)
                    color: battleTheme.typeColor(infoModel.moveTypes[index]);
                    Label {
                        text: PokemonInfoAccess.moveName(modelData)
                        anchors.centerIn: parent
                    }
                }
            }
        }

    }
}
