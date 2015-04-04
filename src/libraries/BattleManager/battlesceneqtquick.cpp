/* Copyright (C) 2015 Boren Zhang <zhangbr@umich.edu>

   This file is part of PokemonOnlineQML

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public version 3
   License as published by the Free Software Foundation;

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "battlesceneqtquick.h"
#include <QtQml/QQmlEngine>
#include <QtQml/QQmlContext>
#include <QtQml/qqml.h>
#include "moveinfoaccessor.h"
#include "pokemoninfoaccessorqtquick.h"
#include "themeaccessorqtquick.h"
#include "battlesceneproxy.h"
BattleSceneQtQuick::BattleSceneQtQuick(BattleScene::battledata_ptr data,
                                       BattleDefaultTheme *theme, QVariantMap options)
    : BattleScene(data, theme, options), m_theme(theme), m_data(data)
{

}

void BattleSceneQtQuick::registerTypes()
{
    qmlRegisterType<ProxyDataContainer>("pokemononline.battlemanager.proxies", 1, 0, "BattleData");
    qmlRegisterType<TeamProxy>("pokemononline.battlemanager.proxies", 1, 0, "TeamData");
    qmlRegisterType<PokeProxy>("pokemononline.battlemanager.proxies", 1, 0, "PokeData");
    qmlRegisterType<MoveProxy>("pokemononline.battlemanager.proxies", 1, 0, "MoveData");
    qmlRegisterType<BattleSceneProxy>();
    qmlRegisterType<MoveInfoAccessor>("pokemononline.battlemanager.proxies", 1, 0, "MoveInfo");
    qmlRegisterType<BattleDefaultTheme>("pokemononline.battlemanager.proxies", 1, 0, "Theme");
    qmlRegisterType<AuxPokeDataProxy>("pokemononline.battlemanager.proxies", 1, 0, "FieldPokeData");
    qmlRegisterType<FieldProxy>("pokemononline.battlemanager.proxies", 1, 0, "FieldData");
    qmlRegisterType<ZoneProxy>("pokemononline.battlemanager.proxies", 1, 0, "ZoneData");
    qmlRegisterType<BattleScene>("pokemononline.battlemanager.proxies", 1, 0, "BattleScene");
}

void BattleSceneQtQuick::setView(QQuickView *view)
{
    m_view = view;

    view->engine()->removeImageProvider("pokeinfo");
    view->engine()->removeImageProvider("themeinfo");
    view->engine()->addImageProvider("pokeinfo", new PokemonInfoAccessorQtQuick());
    view->engine()->addImageProvider("themeinfo", new ThemeAccessorQtQuick(m_theme));
    view->engine()->rootContext()->setContextProperty("battle", mOwnProxy);
    view->engine()->rootContext()->setContextProperty("moveInfo", new MoveInfoAccessor(this, m_data->gen()));
    view->engine()->rootContext()->setContextProperty("theme", m_theme);
}

QQuickItem *BattleSceneQtQuick::createItem(QQuickItem *parent)
{
    ProxyDataContainer *data_ptr = getDataProxy();
    for (int i = 0; i < 2; i++) {
        QQmlEngine::setObjectOwnership(data_ptr->team(i), QQmlEngine::CppOwnership);
        for (int j = 0; j < 6; j++) {
            QQmlEngine::setObjectOwnership(data_ptr->team(i)->poke(j), QQmlEngine::CppOwnership);
        }
        for (int j = 0; j < m_data->numberOfSlots()/2; j++) {
            QQmlEngine::setObjectOwnership(data_ptr->field()->poke(j*2+i), QQmlEngine::CppOwnership);
        }
    }

    QQmlComponent comp(m_view->engine(), QUrl::fromLocalFile("qml/initial.qml"));
    m_item = qobject_cast<QQuickItem *>(comp.create(m_view->rootContext()));
    m_item->setParent(parent);
    m_item->setParentItem(parent);
    launch();
    return m_item;
}

int BattleSceneQtQuick::width() const
{
    return m_item->width();
}

int BattleSceneQtQuick::height() const
{
    return m_item->height();
}
