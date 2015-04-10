#include "pokemoninfoaccess.h"
#include "libraries/PokemonInfo/pokemoninfo.h"

PokemonInfoAccess::PokemonInfoAccess(QObject *parent) :
    QObject(parent)
{
}

QString PokemonInfoAccess::typeName(int type)
{
    return TypeInfo::Name(type);
}

QString PokemonInfoAccess::moveName(int move)
{
    return MoveInfo::Name(move);
}

QString PokemonInfoAccess::pokemonName(QString num)
{
    return PokemonInfo::Name(Pokemon::uniqueId(num));
}

QVariantList PokemonInfoAccess::pokemonBaseStates(QString num, QString gen)
{
    PokeBaseStats pbs = PokemonInfo::BaseStats(Pokemon::uniqueId(num),
                                               Pokemon::gen(QString(gen.split("-")[0]).toInt(),
                                                            QString(gen.split("-")[1]).toInt()));
    return QVariantList() << pbs.baseHp() << pbs.baseAttack() << pbs.baseDefense() << pbs.baseSpAttack() << pbs.baseSpDefense() << pbs.baseSpeed();
}

QObject *PokemonInfoAccess::provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    return new PokemonInfoAccess();
}
