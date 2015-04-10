#include "playerinfolistmodel.h"
#include "libraries/PokemonInfo/networkstructs.h"
PlayerInfoListModel::PlayerInfoListModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

void PlayerInfoListModel::add(PlayerInfo pi)
{
    if(m_playersCountIn.find(pi.id) == m_playersCountIn.end()) {
        emit beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_playersCountIn[pi.id] = true;
        m_playerInfoList.append(pi);
        emit endInsertRows();
    }
}

void PlayerInfoListModel::remove(int piId)
{
    int row = 0;
    for(auto i = m_playerInfoList.begin(); i < m_playerInfoList.end(); ++i) {
        if(piId == i->id) {
            row = i - m_playerInfoList.begin();
            emit beginRemoveRows(QModelIndex(), row, row);
            m_playerInfoList.removeAt(row);
            emit endRemoveRows();
            break;
        }
    }
}

void PlayerInfoListModel::update(int id1, int id2)
{
    for(auto i = m_playerInfoList.begin(); i < m_playerInfoList.end(); ++i) {
        if(i->id == id1 || i->id == id2) {
            i->flags.setFlag(PlayerInfo::Battling, true);
            emit dataChanged(index(i - m_playerInfoList.begin()), index(i - m_playerInfoList.begin()));
        }
    }
}

void PlayerInfoListModel::clear()
{
    m_playerInfoList.clear();
    m_playersCountIn.clear();
}

PlayerInfo PlayerInfoListModel::findPlayerById(int id)
{
    //TODO use hash table
    for (int i = 0; i < m_playerInfoList.size(); i++) {
        if (m_playerInfoList.at(i).id == id) {
            return m_playerInfoList.at(i);
        }
    }
    return PlayerInfo();
}

int PlayerInfoListModel::rowCount(const QModelIndex &parent) const
{
    return m_playerInfoList.size();
}

QVariant PlayerInfoListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
    case RoleName:
        return m_playerInfoList[index.row()].name;
    case RolePlayerId:
        return m_playerInfoList[index.row()].id;
    case RoleIsBattling:
        return m_playerInfoList[index.row()].battling();
    }
    return QVariant();
}

QHash<int, QByteArray> PlayerInfoListModel::roleNames() const
{
    QHash<int, QByteArray> r;
    r[RoleName] = "name"; //后面那个是qml调用的
    r[RolePlayerId] = "playerId";
    r[RoleIsBattling] = "isBattling";
    return r;
}

QString PlayerInfoListModel::findPlayerNameById(int id)
{
    return findPlayerById(id).name;
}
