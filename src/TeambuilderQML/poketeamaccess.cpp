#include "poketeamaccess.h"
#include "libraries/PokemonInfo/pokemoninfo.h"

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

QString PokeTeamAccess::gen()
{
    return m_pokemonTeam->gen().toString();
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

QVariantList PokeTeamAccess::stats()
{
    return QVariantList()
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

QVariantList PokeTeamAccess::moveTypes()
{
    QVariantList vl;
    for (int i = 0;i < 4; i++) {
        int type = (m_pokemonTeam->move(i) == Move::HiddenPower ?
            HiddenPowerInfo::Type(m_pokemonTeam->gen(),
                m_pokemonTeam->DV(0),
                m_pokemonTeam->DV(1),
                m_pokemonTeam->DV(2),
                m_pokemonTeam->DV(3),
                m_pokemonTeam->DV(4),
                m_pokemonTeam->DV(5))
            : MoveInfo::Type(m_pokemonTeam->move(i), m_pokemonTeam->gen()));
        vl << type;
    }
    return vl;
}
