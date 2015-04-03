#ifndef THEMEACCESSORQTQUICK_H
#define THEMEACCESSORQTQUICK_H

#include <QtQuick/QQuickImageProvider>
#include "defaulttheme.h"

class ThemeAccessorQtQuick : public QQuickImageProvider
{
public:
    explicit ThemeAccessorQtQuick(BattleDefaultTheme *theme);

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

private:
    BattleDefaultTheme *m_theme;

};

#endif // THEMEACCESSORQTQUICK_H
