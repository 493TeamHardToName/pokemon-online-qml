#include "attacklistmodel.h"

AttackListModel::AttackListModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

void AttackListModel::setPoke(PokeProxy *p)
{
    m_pokeProxy = p;
    qDebug() << "m_pokeProxy" << m_pokeProxy->move(0)->exposedData().num()
                << m_pokeProxy->move(1)->exposedData().num()
                   << m_pokeProxy->move(2)->exposedData().num()
                      << m_pokeProxy->move(3)->exposedData().num();
    emit dataChanged(index(0), index(3));
}

int AttackListModel::rowCount(const QModelIndex &parent) const
{
    return 4;
}

QVariant AttackListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !m_pokeProxy) {
        return QVariant();
    }
    switch (role) {
    case RoleAttackName:
        return MoveInfo::Name(m_pokeProxy->move(index.row())->exposedData().num());
    }
    return QVariant();
}

QHash<int, QByteArray> AttackListModel::roleNames() const
{
    QHash<int, QByteArray> retVal;
    retVal[RoleAttackName] = "name";
    return retVal;
}
