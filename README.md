README for Pokémon Online QML :

This is trying to implement Pokémon Online in pure QML, with no Qt desktop component.

What is implemented: 

We have implemented a page for building pokemon team, a page for finding online payers and a page for game play. We get game play workflow finished. Improvement over style and displaying more explanation are needed.

File ownership:

C++ Codes we created are locate at src/TeambuilderQML. Other C++ code under src directory are copied from original project. We put QML files in src/TeambuilderQML/qml. In resource file src/TeambuilderQML/qml.qrc, the qml files under prefix "/" are created by us. The files under prefix "/battlescene" in qml.qrc is a partial QML work on the battle scene copied from the original Pokemon Online project.

Problem:

We can now run the program on desktop but the build on Android will crash on the battle page. Still trying to figure that out.

Compile:

To build desktop version, You would need libzip to compile and run. For Android build, we will link static library(libzip.a), but on desktop, you would need to install libzip or compile it to run the program. On Ubuntu, you can run apt-get install libzip-dev. On other linux or mac, you need to get libzip source from http://www.nih.at/libzip/,  compile libzip and in this project, run "qmake LIBZIP_PATH=<libzip root path> && make". You can find executable Pokemon_Online under bin.

README for Pokémon Online:

This is Pokémon Online
----------------------
[![Build Status](https://travis-ci.org/po-devs/pokemon-online.png)](https://travis-ci.org/po-devs/pokemon-online)

Homepage: http://pokemon-online.eu/  
Forums: http://pokemon-online.eu/forums/  
Source code: https://github.com/po-devs/pokemon-online/  

Build Instructions, Scripting Guides and more on https://github.com/po-devs/pokemon-online/wiki

To test, `qmake CONFIG+="po_all"` and run `scripts/run-tests.sh` from the main folder.

License GNU General Public License
