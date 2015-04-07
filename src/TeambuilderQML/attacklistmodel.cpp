#include "attacklistmodel.h"

AttackListModel::AttackListModel(QObject *parent) :
    QAbstractListModel(parent), m_pokeProxy(0)
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
    case RolePP:
        return m_pokeProxy->move(index.row())->exposedData().PP();
    case RoleMaxPP:
        return m_pokeProxy->move(index.row())->exposedData().totalPP();
    case RoleDamageClass:
        return CategoryInfo::Name(MoveInfo::Category(m_pokeProxy->move(index.row())->exposedData().num(),  m_pokeProxy->gen()));
    case RoleCategory:
        return TypeInfo::Name(MoveInfo::Type(m_pokeProxy->move(index.row())->exposedData().num(),  m_pokeProxy->gen()));
    case RoleDescription:
        return MoveInfo::Description(m_pokeProxy->move(index.row())->exposedData().num(),  m_pokeProxy->gen());
    case RolePower:
        return MoveInfo::PowerS(m_pokeProxy->move(index.row())->exposedData().num(),  m_pokeProxy->gen());
    case RoleAccuracy:
        return MoveInfo::AccS(m_pokeProxy->move(index.row())->exposedData().num(),  m_pokeProxy->gen());
    }
    return QVariant();
}

QHash<int, QByteArray> AttackListModel::roleNames() const
{
    QHash<int, QByteArray> retVal;
    retVal[RoleAttackName] = "name";
    retVal[RolePP] = "pp";
    retVal[RoleMaxPP] = "maxpp";
    retVal[RoleDamageClass] = "damageClass"; // Physical, Special or Null
    retVal[RoleCategory] = "category"; // grass
    retVal[RolePower] = "power";
    retVal[RoleDescription] = "description";
    retVal[RoleAccuracy] = "accuracy";
    return retVal;
}
