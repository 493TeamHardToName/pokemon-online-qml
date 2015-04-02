// this file is copied from TeamBuilder/battlewindows.h
#include <PokemonInfo/battlestructs.h>
#include <BattleManager/battledatatypes.h>
#include <BattleManager/battlecommandmanager.h>
#include <BattleManager/battledataaccessor.h>
#include <BattleManager/advancedbattledata.h>
#include "libraries/PokemonInfo/networkstructs.h"

#ifndef BATTLEINFO_H
#define BATTLEINFO_H

struct BaseBattleInfo
{
    BaseBattleInfo(const PlayerInfo & me, const PlayerInfo &opp, int mode, int myself=0, int opponent=1);
    /* name [0] = mine, name[1] = other */
    PlayerInfo pInfo[2];
    advbattledata_proxy *data;

    int mode;
    Pokemon::gen gen;

    int myself;
    int opponent;
    int numberOfSlots;

    /* Opponent pokemon */

    QString name(int x) const {
        return pInfo[x].name;
    }
};

class BattleInfo : public BaseBattleInfo
{
public:
    BattleInfo(const TeamBattle &myteam, const PlayerInfo &me, const PlayerInfo &opp, int mode, int myself, int oppo);

    /* Possible choices */
    bool possible;

    QList<BattleChoices> choices;
    QList<BattleChoice> choice;
    QList<bool> available;
    QList<bool> done;

    const PokeProxy &currentPoke(int spot) const;
    PokeProxy &currentPoke(int spot);
    PokeProxy &tempPoke(int spot);

    int currentSlot;
    TeamBattle _myteam;
    TeamProxy &myteam();
    QHash<quint16, quint16>& myitems();
    const TeamProxy &myteam() const;

    bool sent;

    int phase;

    enum Phase {
        Regular,
        ItemPokeSelection,
        ItemAttackSelection,
        ItemFieldPokeSelection
    };


    QList<BattleStats> mystats;

    int lastMove[6];
};

#endif // BATTLEINFO_H
