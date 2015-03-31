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

// inherit battlescene using QtQuick 2.0 instead of QtQuick 1.1

#ifndef BATTLESCENEQTQUICK_H
#define BATTLESCENEQTQUICK_H

#include "battlescene.h"
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>

class BattleSceneQtQuick : public BattleScene
{
    Q_OBJECT
public:
    explicit BattleSceneQtQuick(battledata_ptr data=0, BattleDefaultTheme *theme=0, QVariantMap options = QVariantMap());

    static void registerTypes();
    void setView(QQuickView *view);
    QQuickItem *createItem(QQuickItem *parent);

    virtual int width() const;
    virtual int height() const;
signals:

public slots:

private:
    QQuickView *m_view;
    BattleDefaultTheme *m_theme;
    BattleScene::battledata_ptr m_data;
    QQuickItem *m_item;
};

#endif // BATTLESCENEQTQUICK_H
