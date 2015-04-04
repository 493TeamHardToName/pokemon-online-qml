#include <QGuiApplication>
#include <QQuickView>
#include <QScreen>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQml/QtQml>
#include "serverchoicemodel.h"
#include "libraries/TeambuilderLibrary/poketablemodel.h"
#include "libraries/TeambuilderLibrary/theme.h"
#include "libraries/PokemonInfo/teamholder.h"
#include "libraries/PokemonInfo/pokemoninfo.h"
#include "libraries/PokemonInfo/movesetchecker.h"
#include "libraries/BattleManager/pokemoninfoaccessorqtquick.h"
#include "analyzeraccess.h"

QQuickView *qQuickView;

void reloadPokemonDatabase() {
    QSettings s;

    GenInfo::init("db/gens/");
    PokemonInfo::init("db/pokes/");
    MoveSetChecker::init("db/pokes/", s.value("TeamBuilder/EnforceMinLevels").toBool());
    ItemInfo::init("db/items/");
    MoveInfo::init("db/moves/");
    TypeInfo::init("db/types/");
    NatureInfo::init("db/natures/");
    CategoryInfo::init("db/categories/");
    AbilityInfo::init("db/abilities/");
    GenderInfo::init("db/genders/");
    HiddenPowerInfo::init("db/types/");
    StatInfo::init("db/status/");
}

int main(int argc, char *argv[])
{
    reloadPokemonDatabase();

    QGuiApplication app(argc, argv);
    Theme::init();
    qreal dpi = QGuiApplication::screens().at(0)->logicalDotsPerInch() * app.devicePixelRatio();
    Q_INIT_RESOURCE(qml);

    qQuickView = new QQuickView();

    qRegisterMetaType<QAbstractItemModel *>();  //qml

    qmlRegisterType<PokemonOnlineQML::ServerChoiceModel>("PokemonOnlineQml", 1, 0, "ServerChoiceModel");  //qian  <方括号是后台里的类>， （里都是text）
    qmlRegisterType<PokeTableModel>("PokemonOnlineQml", 1, 0, "PokeTableModel");
    qmlRegisterType<TeamHolder>("PokemonOnlineQml", 1, 0, "TeamHolder");
    qQuickView->engine()->addImageProvider("pokeinfo", new PokemonInfoAccessorQtQuick());
    qmlRegisterType<AnalyzerAccess>("PokemonOnlineQml", 1, 0, "AnalyzerAccess");
    qQuickView->engine()->rootContext()->setContextProperty("screenDpi", dpi);

    qQuickView->setResizeMode(QQuickView::SizeRootObjectToView);
    qQuickView->setTitle("Pokemon online");
    qQuickView->setSource(QUrl("qrc:/qml/main.qml"));
    qQuickView->show();
    return app.exec();
}
