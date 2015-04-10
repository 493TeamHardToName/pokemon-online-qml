TEMPLATE = app
QT += gui quick multimedia

TARGET = Pokemon-Online
CONFIG += c++11

SOURCES =   main.cpp \
            serverchoicemodel.cpp \
            ../Teambuilder/analyze.cpp \
            analyzeraccess.cpp \
    playerinfolistmodel.cpp  \
            battleinfo.cpp \
            attacklistmodel.cpp \
    pokemonlistmodel.cpp \
    poketeamaccess.cpp \
    pokemoninfoaccess.cpp

HEADERS =   serverchoicemodel.h \
            ../Teambuilder/analyze.h \
            ../libraries/TeambuilderLibrary/poketablemodel.h \
            ../libraries/PokemonInfo/teamholder.h \
            ../libraries/PokemonInfo/pokemoninfo.h \
            ../libraries/PokemonInfo/movesetchecker.h \
            ../libraries/PokemonInfo/battlestructs.h \
            ../libraries/PokemonInfo/networkstructs.h \
            analyzeraccess.h \
            playerinfolistmodel.h \
            battleinfo.h \
            attacklistmodel.h \
    pokemonlistmodel.h \
    poketeamaccess.h \
    pokemoninfoaccess.h

INCLUDEPATH += "../libraries"

RESOURCES += \
    qml.qrc \
    db1.qrc \
    dbpoke1.qrc \
    dbpoke2.qrc \
    dbpoke3.qrc \
    dbpoke4.qrc \
    dbpoke5.qrc \
    dbpoke6.qrc \
    dbcry.qrc \
    defaultteam.qrc \
    theme.qrc

include(../Shared/Common.pri)
exists ($$LIBZIP_PATH){
!android {
    LIBS += -L$$LIBZIP_PATH/lib/.libs/ -lzip
}
android {
    LIBS += $$LIBZIP_PATH/lib/.libs/libzip.a
}
}

LIBS += $$teambuilder
