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

QString PokemonInfoAccess::moveDescription(int moveNum, QString genString)
{
    Pokemon::gen gen(QString(genString.split("-")[0]).toInt(),
            QString(genString.split("-")[1]).toInt());

    QString power = MoveInfo::PowerS(moveNum, gen);

    QString moveCategory;
    moveCategory = CategoryInfo::Name(MoveInfo::Category(moveNum, gen));
    QString ttext = tr("%1\n\nType:%2\nPower: %3\nAccuracy: %4\nCategory: %5\nPP: %6\n\nDescription: %7")
            .arg(MoveInfo::Name(moveNum),
                 TypeInfo::Name(MoveInfo::Type(moveNum, gen)),
                 power,
                MoveInfo::AccS(moveNum, gen), moveCategory,
                 QString::number(MoveInfo::PP(moveNum, gen)),
                MoveInfo::Description(moveNum, gen));


    return ttext;
}

QObject *PokemonInfoAccess::provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    return new PokemonInfoAccess();
}
