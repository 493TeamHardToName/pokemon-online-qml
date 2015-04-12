#ifndef PLAYERINFOLISTMODEL_H
#define PLAYERINFOLISTMODEL_H

#include <QAbstractListModel>

#include "libraries/PokemonInfo/networkstructs.h"

class PlayerInfoListModel : public QAbstractListModel
{
    Q_OBJECT

    enum {
        RoleName = Qt::UserRole + 1,
        RolePlayerId,
        RoleIsBattling
    };
public:
    explicit PlayerInfoListModel(QObject *parent = 0);
    void add(PlayerInfo pi);
    void remove(int piId);
    void update(int id1, int id2);
    void clear();
    PlayerInfo findPlayerById(int id);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QHash<int,QByteArray> roleNames() const;

    Q_INVOKABLE QString findPlayerNameById(int id);

signals:

public slots:

private:
    QList<PlayerInfo> m_playerInfoList;
    QHash<int, bool> m_playersCountIn;
};

#endif // PLAYERINFOLISTMODEL_H
