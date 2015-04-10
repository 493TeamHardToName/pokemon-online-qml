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

QObject *PokemonInfoAccess::provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    return new PokemonInfoAccess();
}
