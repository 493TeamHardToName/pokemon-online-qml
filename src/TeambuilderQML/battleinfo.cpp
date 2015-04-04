#include "battleinfo.h"

BaseBattleInfo::BaseBattleInfo(const PlayerInfo &me, const PlayerInfo &opp, int mode, int myself, int opponent)
    : myself(myself), opponent(opponent)
{
    this->mode =  mode;
    if (mode == ChallengeInfo::Doubles) {
        numberOfSlots = 4;
    } else if (mode == ChallengeInfo::Triples) {
        numberOfSlots = 6;
    } else {
        numberOfSlots = 2;
    }

    pInfo[myself] = me;
    pInfo[opponent] = opp;
}

BattleInfo::BattleInfo(const TeamBattle &team, const PlayerInfo &me, const PlayerInfo &opp, int mode, int my, int op)
    : BaseBattleInfo(me, opp, mode, my, op)
{
    possible = false;
    sent = true;
    _myteam = team;
    phase = Regular;

    currentSlot = data->spot(myself);

    for (int i = 0; i < numberOfSlots/2; i++) {
        choices.push_back(BattleChoices());
        choice.push_back(BattleChoice());
        available.push_back(false);
        done.push_back(false);
    }

    memset(lastMove, 0, sizeof(lastMove));
}

QHash<quint16, quint16>& BattleInfo::myitems()
{
    return data->items(myself);
}

TeamProxy &BattleInfo::myteam()
{
    return data->team(myself);
}

const TeamProxy &BattleInfo::myteam() const
{
    return data->team(myself);
}

PokeProxy &BattleInfo::tempPoke(int spot)
{
    //return m_tempPoke[number(spot)];
    return data->tempPoke(spot);
}

const PokeProxy & BattleInfo::currentPoke(int spot) const
{
    return data->poke(spot);
}

PokeProxy & BattleInfo::currentPoke(int spot)
{
    return data->poke(spot);
}
