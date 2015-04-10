import QtQuick 2.4
import "../js/units.js" as U
import PokemonOnlineQml 1.0
import QtQuick.Controls 1.3

Rectangle {
    property int type: 18
    visible: type < 18
    color: battleTheme.typeColor(type)
    radius: U.dp(0.02)
    width: name.width + U.dp(0.04)
    height: name.height + U.dp(0.04)
    Label {
        id: name
        text: PokemonInfoAccess.typeName(type)
        anchors.centerIn: parent
    }
}
