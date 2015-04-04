#include "themeaccessorqtquick.h"

ThemeAccessorQtQuick::ThemeAccessorQtQuick(BattleDefaultTheme *theme)
    : QQuickImageProvider(QQuickImageProvider::Pixmap), m_theme(theme)
{
}

QPixmap ThemeAccessorQtQuick::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    (void) requestedSize;

    QPixmap ret;

    if (id.startsWith("avatar/")) {
        return m_theme->trainerSprite(id.section("/", 1).toInt());
    }

    *size = ret.size();

    return ret;
}
