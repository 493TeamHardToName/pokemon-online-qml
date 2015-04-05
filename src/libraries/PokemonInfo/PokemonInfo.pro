TARGET = po-pokemoninfo
TEMPLATE = lib
QT += xml
SOURCES += pokemonstructs.cpp \
    pokemoninfo.cpp \
    networkstructs.cpp \
    movesetchecker.cpp \
    battlestructs.cpp \
    teamsaver.cpp \
    pokemon.cpp \
    teamholder.cpp
HEADERS += pokemonstructs.h \
    pokemoninfo.h \
    networkstructs.h \
    movesetchecker.h \
    battlestructs.h \
    teamsaver.h \
    enums.h \
    ../Shared/config.h \
    geninfo.h \
    pokemon.h \
    teamholder.h \
    teamholderinterface.h

include(../../Shared/Common.pri)

LIBS += $$utilities

exists ($$LIBZIP_PATH) {
    LIBS += -L$$LIBZIP_PATH/lib/.libs/ -lzip#$$LIBZIP_PATH/lib/.libs/libzip.a
    INCLUDEPATH += $$LIBZIP_PATH/lib
}

!exists ($$LIBZIP_PATH) {
windows: { LIBS += -L$$bin -lzip-2 }
!windows: { LIBS += -lzip }
}

OTHER_FILES += 
