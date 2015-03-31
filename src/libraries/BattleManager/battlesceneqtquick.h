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
    explicit BattleSceneQtQuick(battledata_ptr data=0, BattleDefaultTheme *theme=0, QVariantMap options = QVariantMap(), QQuickView *view = 0);

    Q_INVOKABLE QQuickItem *createItem();

signals:

public slots:

};

#endif // BATTLESCENEQTQUICK_H
