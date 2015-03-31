#include "battlesceneqtquick.h"
#include <QtQml/QQmlEngine>
#include <QtQml/QQmlContext>
#include <QtQml/qqml.h>
#include "moveinfoaccessor.h"
#include "pokemoninfoaccessorqtquick.h"
#include "themeaccessorqtquick.h"
BattleSceneQtQuick::BattleSceneQtQuick(BattleScene::battledata_ptr data,
                                       BattleDefaultTheme *theme, QVariantMap options, QQuickView *view)
    : BattleScene(data, theme, options)
{

    qmlRegisterType<ProxyDataContainer>("pokemononline.battlemanager.proxies", 1, 0, "BattleData");
    qmlRegisterType<TeamProxy>("pokemononline.battlemanager.proxies", 1, 0, "TeamData");
    qmlRegisterType<PokeProxy>("pokemononline.battlemanager.proxies", 1, 0, "PokeData");
    qmlRegisterType<MoveProxy>("pokemononline.battlemanager.proxies", 1, 0, "MoveData");
    qmlRegisterType<PokemonInfoAccessorQtQuick>();
    qmlRegisterType<BattleSceneProxy>();
    qmlRegisterType<MoveInfoAccessor>("pokemononline.battlemanager.proxies", 1, 0, "MoveInfo");
    qmlRegisterType<BattleDefaultTheme>("pokemononline.battlemanager.proxies", 1, 0, "Theme");
    qmlRegisterType<AuxPokeDataProxy>("pokemononline.battlemanager.proxies", 1, 0, "FieldPokeData");
    qmlRegisterType<FieldProxy>("pokemononline.battlemanager.proxies", 1, 0, "FieldData");
    qmlRegisterType<ZoneProxy>("pokemononline.battlemanager.proxies", 1, 0, "ZoneData");
    qmlRegisterType<BattleScene>("pokemononline.battlemanager.proxies", 1, 0, "BattleScene");

    view->engine()->rootContext()->setContextProperty("battle", mOwnProxy);
    view->engine()->addImageProvider("pokeinfo", new PokemonInfoAccessorQtQuick());
    view->engine()->addImageProvider("themeinfo", new ThemeAccessorQtQuick(theme));
    view->engine()->rootContext()->setContextProperty("moveInfo", new MoveInfoAccessor(this, data()->gen()));
    view->engine()->rootContext()->setContextProperty("theme", theme);
//    mWidget->setSource(QString("qml/initial.qml"));
}

QQuickItem *BattleSceneQtQuick::getItem()
{

}
