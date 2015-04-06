#ifndef ATTACHLISTMODEL_H
#define ATTACHLISTMODEL_H

#include <QAbstractListModel>
#include "libraries/BattleManager/battledataaccessor.h"

class AttackListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    typedef enum {
        RoleAttackName = Qt::UserRole + 1,
        RolePP,
        RoleMaxPP,
        RoleDamageClass, // Physical, Special or Null
        RoleCategory, // grass
        RolePower,
        RoleAccuracy,
        RoleDescription
    } Role;
    explicit AttackListModel(QObject *parent = 0);

    void setPoke(PokeProxy *p);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QHash<int,QByteArray> roleNames() const;
signals:

public slots:

private:
    PokeProxy *m_pokeProxy;

};

#endif // ATTACHLISTMODEL_H
