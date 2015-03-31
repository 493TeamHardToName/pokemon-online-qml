#ifndef THEMEACCESSORQTQUICK_H
#define THEMEACCESSORQTQUICK_H

#include <QtQuick/QQuickImageProvider>

class ThemeAccessorQtQuick : public QQuickImageProvider
{
    Q_OBJECT
public:
    explicit ThemeAccessorQtQuick(QObject *parent = 0);

signals:

public slots:

};

#endif // THEMEACCESSORQTQUICK_H
