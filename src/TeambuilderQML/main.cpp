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
#include "analyzeraccess.h"

QQuickView *qQuickView;

void reloadPokemonDatabase() {
    QSettings s;

    PokemonInfoConfig::setDataRepo(":/");
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

    QGuiApplication app(argc, argv);

    qreal dpi = QGuiApplication::screens().at(0)->logicalDotsPerInch() * app.devicePixelRatio();
    Q_INIT_RESOURCE(qml);

    Q_INIT_RESOURCE(db1);
    Q_INIT_RESOURCE(dbpoke1);
    Q_INIT_RESOURCE(dbpoke2);
    Q_INIT_RESOURCE(dbpoke3);
    Q_INIT_RESOURCE(dbpoke4);
    Q_INIT_RESOURCE(dbpoke5);
    Q_INIT_RESOURCE(dbpoke6);
    Q_INIT_RESOURCE(dbcry);

    reloadPokemonDatabase();
    Theme::init();

    qQuickView = new QQuickView();

    qRegisterMetaType<QAbstractItemModel *>();

    qmlRegisterType<PokemonOnlineQML::ServerChoiceModel>("PokemonOnlineQml", 1, 0, "ServerChoiceModel");
    qmlRegisterType<PokeTableModel>("PokemonOnlineQml", 1, 0, "PokeTableModel");
    qmlRegisterType<TeamHolder>("PokemonOnlineQml", 1, 0, "TeamHolder");
    qmlRegisterType<AnalyzerAccess>("PokemonOnlineQml", 1, 0, "AnalyzerAccess");
    qQuickView->engine()->rootContext()->setContextProperty("screenDpi", dpi);

    qQuickView->setResizeMode(QQuickView::SizeRootObjectToView);
    qQuickView->setTitle("Pokemon online");
    qQuickView->setSource(QUrl("qrc:/qml/main.qml"));
    qQuickView->show();
    return app.exec();
}
