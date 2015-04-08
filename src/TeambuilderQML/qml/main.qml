import QtQuick 2.4
import QtQuick.Controls 1.3
import PokemonOnlineQml 1.0
import QtQuick.Layouts 1.1
import "js/units.js" as U
import "components"
import "ui"
ApplicationWindow {
    id: pokemonOnlineQml
    visible: true
    title: "Pokemon Online"
    width: U.dp(5)
    height: U.dp(7)

    property Action backAction
    property list<Action> actions
    property string pageTitle
    toolBar: ToolBar {
        height: U.dp(0.4)
        Row {
            height: parent.height
            anchors {
                leftMargin: U.dp(0.1)
                left: parent.left
            }
            spacing: U.dp(0.1)
            ToolButton {
                id: backToolButton
                visible: backAction
                text: backAction.text
                onClicked: backAction.trigger()
                iconSource: backAction.iconSource
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: pageTitle
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
            }
        }
        Row {
            height: parent.height
            anchors {
                right: parent.right
                rightMargin: U.dp(0.1)
            }
            Repeater {
                model: actions
                delegate: ToolButton {
                    height: U.dp(0.4)
                    width: height
                    text: actions[index].text
                    iconSource: actions[index].iconSource
                    onClicked: actions[index].trigger()
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    function updateToolbar(page) {
        var page = stackView.currentItem;
        backAction = page.backAction;
        actions = page.actions;
        pageTitle = page.title
    }

    StackView {
        id: stackView
        anchors.fill: parent
    }
    Item {
        id: pageStack
        function push(component) {
            stackView.push(component);
            updateToolbar();
        }
        function pop() {
            var item = stackView.pop();
            updateToolbar();
        }
        Component.onCompleted: pageStack.push(buildTeamPageComponent)   // add on, this is slot
    }
    AnalyzerAccess {
        id: analyserAccess
    }

    Component {
        id: mainMenuPageComponent
        MainMenuPage {
            onBuildTeamClicked: pageStack.push(buildTeamPageComponent);
        }
    }

//    Component {
//        id: serverListPageComponent
//        ServerListPage {
//            onBuildTeamClicked: pokemonOnlineQml.state = "buildTeam";
//        }
//    }

    Component {
        id: buildTeamPageComponent
        BuildTeamPage {
            onRandomGame: pageStack.push(findGamePageComponent)
            onGoFindGame: {
                console.log("Go Find Game")
                pageStack.push(findGamePageComponent)
            }
        }
    }

    Component {
        id: findGamePageComponent
        FindGamePage {
            onGoBack: pageStack.pop()
            onGoToBattle: pageStack.push(battlePageComponent)
        }
    }

    Component {
        id: battlePageComponent
        BattlePage {
            onGoBack: pageStack.pop()
        }
    }
}
