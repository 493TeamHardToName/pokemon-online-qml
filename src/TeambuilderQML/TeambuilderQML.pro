TEMPLATE = app
QT += gui quick multimedia

TARGET = Pokemon-Online
CONFIG += c++11

SOURCES =   main.cpp \
            serverchoicemodel.cpp \
            ../Teambuilder/analyze.cpp \
            analyzeraccess.cpp \
            playerinfolistmodel.cpp \
            battleinfo.cpp

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
            battleinfo.h

INCLUDEPATH += "../libraries"

RESOURCES += \
    qml.qrc

include(../Shared/Common.pri)
exists ($$LIBZIP_PATH) {
    LIBS += -L$$LIBZIP_PATH/lib/.libs -lzip
}


LIBS += $$teambuilder
