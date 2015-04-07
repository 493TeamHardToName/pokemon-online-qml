import QtQuick 2.4

Item
{
    width: (parent.width * 0.8 < parent.height) ? parent.width : parent.height / 0.8 //screenSize().w;
    height: width * 0.8 //screenSize().h

    anchors.centerIn: parent
    function screenSize() {
        var str = battle.scene.option("screensize", "500x400");
        return {"w": str.substr(0, str.indexOf('x')), "h":str.substr(str.indexOf('x')+1)};
    }

    Text {
        text: "A random text on the scene";
    }

    Loader {
        id: loader
        anchors.fill: parent
    }

    Connections {
        target: battle.scene
        onLaunched: {
            console.log("Battle launched");
            loader.source = "battlescene.qml"
        }
    }
}
