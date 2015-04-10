#include "poketeamaccess.h"

PokeTeamAccess::PokeTeamAccess(QObject *parent) :
    QObject(parent), m_pokemonTeam(0)
{
}

void PokeTeamAccess::setPokeTeam(PokeTeam *pokemonTeam)
{
    m_pokemonTeam = pokemonTeam;
    emit dataChanged();
}

int PokeTeamAccess::level()
{
    return m_pokemonTeam->level();
}

QString PokeTeamAccess::num()
{
    return m_pokemonTeam->num().toString();
}

QList<int> PokeTeamAccess::types()
{
    QList<int> il;
    return il << m_pokemonTeam->type1();
    if (m_pokemonTeam->type2() != 18) {
        il << m_pokemonTeam->type2();
    }
    return il;
}

QList<int> PokeTeamAccess::stats()
{
    return QList<int>()
            << m_pokemonTeam->stat(0)
            << m_pokemonTeam->stat(1)
            << m_pokemonTeam->stat(2)
            << m_pokemonTeam->stat(3)
            << m_pokemonTeam->stat(4)
            << m_pokemonTeam->stat(5);
}

QVariantList PokeTeamAccess::moves()
{
    return QVariantList()
                << m_pokemonTeam->move(0)
                << m_pokemonTeam->move(1)
                << m_pokemonTeam->move(2)
                << m_pokemonTeam->move(3);
}
