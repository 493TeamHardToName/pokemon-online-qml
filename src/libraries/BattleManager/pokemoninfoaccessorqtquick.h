#ifndef POKEMONINFOACCESSORQTQUICK_H
#define POKEMONINFOACCESSORQTQUICK_H

#include <QtQuick/QQuickImageProvider>

class PokemonInfoAccessorQtQuick : public QQuickImageProvider
{
public:
    explicit PokemonInfoAccessorQtQuick(QObject *parent = 0);

    virtual QPixmap requestPixmap(const QString &id, QSize *size, const QSize& requestedSize);
signals:

public slots:

};

#endif // POKEMONINFOACCESSORQTQUICK_H
