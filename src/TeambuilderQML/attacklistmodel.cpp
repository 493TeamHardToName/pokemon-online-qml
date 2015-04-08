#include "attacklistmodel.h"
#include "TeambuilderLibrary/theme.h"

AttackListModel::AttackListModel(QObject *parent) :
    QAbstractListModel(parent), m_pokeProxy(0)
{
}

void AttackListModel::setPoke(PokeProxy *p)
{
    m_pokeProxy = p;
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
    BattleMove bm = m_pokeProxy->move(index.row())->exposedData();
    switch (role) {
    case RoleAttackName:
        return MoveInfo::Name(bm.num());
    case RolePP:
        return bm.PP();
    case RoleMaxPP:
        return bm.totalPP();
    case RoleDamageClass:
        return CategoryInfo::Name(MoveInfo::Category(bm.num(),  m_pokeProxy->gen()));
    case RoleCategory:
        return TypeInfo::Name(MoveInfo::Type(bm.num(),  m_pokeProxy->gen()));
    case RoleDescription:
        return MoveInfo::Description(bm.num(),  m_pokeProxy->gen());
    case RolePower:
        return MoveInfo::PowerS(bm.num(),  m_pokeProxy->gen());
    case RoleAccuracy:
        return MoveInfo::AccS(bm.num(),  m_pokeProxy->gen());
    case RoleAttackColor:
        int type = bm.num() == Move::HiddenPower ?
            HiddenPowerInfo::Type(m_pokeProxy->gen(),
                m_pokeProxy->dvs()[0],
                m_pokeProxy->dvs()[1],
                m_pokeProxy->dvs()[2],
                m_pokeProxy->dvs()[3],
                m_pokeProxy->dvs()[4],
                m_pokeProxy->dvs()[5])
                : MoveInfo::Type(bm.num(), m_pokeProxy->gen());
        return Theme::TypeColor(type).name();
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
    retVal[RoleAttackColor] = "attackColor";
    return retVal;
}
