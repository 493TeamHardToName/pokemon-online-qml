#ifndef POKETEAMACCESS_H
#define POKETEAMACCESS_H

#include <QObject>
#include "libraries/PokemonInfo/pokemonstructs.h"

class PokeTeamAccess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int level READ level NOTIFY dataChanged)
    Q_PROPERTY(QList<int> types READ types NOTIFY dataChanged)
    Q_PROPERTY(QList<int> stats READ stats NOTIFY dataChanged)
    Q_PROPERTY(QVariantList moves READ moves NOTIFY dataChanged)
    Q_PROPERTY(QString num READ num NOTIFY dataChanged)
public:
    explicit PokeTeamAccess(QObject *parent = 0);

    void setPokeTeam(PokeTeam *pokemonTeam);

    int level();
    QString num();
    QList<int> types();
    QList<int> stats();
    QVariantList moves();
signals:
    void dataChanged();
public slots:

private:
    PokeTeam *m_pokemonTeam;
};

#endif // POKETEAMACCESS_H
