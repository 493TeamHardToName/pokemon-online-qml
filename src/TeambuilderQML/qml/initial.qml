import QtQuick 2.4

Item
{
    width: screenSize().w;
    height: screenSize().h

    function screenSize() {
        var str = battle.scene.option("screensize", "500x400");
        return {"w": str.substr(0, str.indexOf('x')), "h":str.substr(str.indexOf('x')+1)};
    }

    Text {
        text: "A random text on the scene";
    }

    Loader {
        id: loader
    }

    Connections {
        target: battle.scene
        onLaunched: {
            console.log("Battle launched");
            loader.source = "battlescene.qml"
        }
    }
}
