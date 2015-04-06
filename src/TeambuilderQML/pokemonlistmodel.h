#ifndef POKEMONLISTMODEL_H
#define POKEMONLISTMODEL_H

#include <QAbstractListModel>
#include "libraries/BattleManager/battledataaccessor.h"

class PokemonListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    typedef enum {
        RolePokemonName = Qt::UserRole + 1,
        RolePokemonIsKoed
    } Role;

    explicit PokemonListModel(QObject *parent = 0);

    void setTeam(TeamProxy *p);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QHash<int,QByteArray> roleNames() const;
signals:

public slots:

private:
    TeamProxy *m_teamProxy;
};

#endif // POKEMONLISTMODEL_H
