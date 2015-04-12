import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    anchors.fill: parent
    property Action backAction;
    property list<Action> actions;
    property string title;
    Image {
        property bool fitHeight: implicitWidth / implicitHeight > parent.width / parent.height
        width: fitHeight ? (implicitWidth / implicitHeight * parent.height) : parent.width
        height: fitHeight ? parent.height :  implicitHeight * parent.width / implicitWidth
        anchors.centerIn: parent
        opacity: 0.5
       source: Qt.resolvedUrl("../graphics/background2.jpeg")
    }
}
