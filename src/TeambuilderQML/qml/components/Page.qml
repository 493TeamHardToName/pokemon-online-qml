import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    anchors.fill: parent
    property Action backAction;
    property list<Action> actions;
    property string title;
}
