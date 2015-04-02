#include "pokemonlistmodel.h"

PokemonListModel::PokemonListModel(QObject *parent) :
    QAbstractListModel(parent), m_teamProxy(0)
{
}

void PokemonListModel::setTeam(TeamProxy *p)
{
    m_teamProxy = p;
    emit dataChanged(index(0), index(3));
}

int PokemonListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 6;
}

QVariant PokemonListModel::data(const QModelIndex &index, int role) const
{
    if (!m_teamProxy || !index.isValid())
        return QVariant();
    switch (role) {
    case RolePokemonName:
        return PokemonInfo::Name(m_teamProxy->poke(index.row())->num());
    }
    return QVariant();
}

QHash<int, QByteArray> PokemonListModel::roleNames() const
{
    QHash<int, QByteArray> retVal;
    retVal[RolePokemonName] = "name";
    return retVal;
}
