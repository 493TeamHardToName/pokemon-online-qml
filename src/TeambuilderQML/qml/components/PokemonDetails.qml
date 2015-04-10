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
        height: U.dp(0.4)
        width: height
        anchors {
            top: parent.top
            right: parent.right
            margins: U.dp(0.2)
        }
    }

    Column {
        id: col
        width: parent.width

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
        //TODO Align
        Label {
            text: "HP: " + root.infoModel.stats[0]
        }
        Label {
            text: "Attack: " + root.infoModel.stats[1]
        }
        Label {
            text: "Defense: " + root.infoModel.stats[2]
        }
        Label {
            text: "Special Attack: " + root.infoModel.stats[3]
        }
        Label {
            text: "Special Defense: " + root.infoModel.stats[4]
        }
        Label {
            text: "Speed: " + root.infoModel.stats[5]
        }
        Label {
            text: "Moves: "
        }
        Repeater {
            model: root.infoModel.moves
            delegate: Label {
                text: "        " + PokemonInfoAccess.moveName(modelData)
            }
        }

    }
}
