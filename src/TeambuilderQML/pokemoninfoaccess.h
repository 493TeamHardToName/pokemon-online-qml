#ifndef POKEMONINFOACCESS_H
#define POKEMONINFOACCESS_H

#include <QObject>
#include <QQmlEngine>

class PokemonInfoAccess : public QObject
{
    Q_OBJECT
public:
    explicit PokemonInfoAccess(QObject *parent = 0);

    Q_INVOKABLE QString typeName(int type);
    Q_INVOKABLE QString moveName(int move);
    Q_INVOKABLE QString pokemonName(QString num);
    Q_INVOKABLE QVariantList pokemonBaseStates(QString num, QString gen);

    static QObject *provider(QQmlEngine *engine, QJSEngine *scriptEngine);
signals:

public slots:

};

#endif // POKEMONINFOACCESS_H
