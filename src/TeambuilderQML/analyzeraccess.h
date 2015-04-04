#ifndef ANALYZERACCESS_H
#define ANALYZERACCESS_H

#include "libraries/PokemonInfo/battlestructs.h"
#include "../Teambuilder/analyze.h"
#include "playerinfolistmodel.h"
#include <QAbstractListModel>

#include "libraries/PokemonInfo/pokemonstructs.h"
#include "libraries/PokemonInfo/teamholder.h"
#include "libraries/PokemonInfo/pokemoninfo.h"
#include <QObject>
#include "libraries/BattleManager/battleinput.h"
#include "libraries/BattleManager/battleclientlog.h"
#include "libraries/BattleManager/battlesceneqtquick.h"
#include "battleinfo.h"
#include "attacklistmodel.h"
#include "pokemonlistmodel.h"
#include <random>
#include <algorithm>

class AnalyzerAccess : public QObject, public BattleCommandManager<AnalyzerAccess>
{
    Q_OBJECT
    Q_PROPERTY(QAbstractItemModel * playersInfoListModel READ playerInfoListModel NOTIFY modelChanged) //前面是前段看到的，后面read之后是后端调用的，notify会告诉bind 的model change
    Q_PROPERTY(QAbstractItemModel * attackListModel READ attackListModel)
    Q_PROPERTY(QAbstractItemModel * pokemonListModel READ pokemonListModel)
    Q_PROPERTY(QObject * battleClientLog READ battleClientLog NOTIFY battleClientLogChanged)
public:
    explicit AnalyzerAccess(QObject *parent = 0);
    Q_INVOKABLE void connectTo(QString host, int port);
    Q_INVOKABLE void sendChallenge(int playerId);
    Q_INVOKABLE void setPlayerName(QString name);
    Q_INVOKABLE void declineChallenge();

    Q_INVOKABLE void setCurrentTeam();
    Q_INVOKABLE void setTeam(int pokonId);
    Q_INVOKABLE void setPos(int pos);
    Q_INVOKABLE int getPokeId(int pos);
    Q_INVOKABLE QString getPokeName(int pos);
    Q_INVOKABLE void generateRandomTeam();
    Q_INVOKABLE void downloadTeam();
    Q_INVOKABLE int userTeamInfo(int id);

    Q_INVOKABLE void acceptChallenge();
    Q_INVOKABLE void attackClicked(int i);
    Q_INVOKABLE void switchClicked(int i);
    Q_INVOKABLE QQuickItem *createBattleSceneItem(QQuickItem *parent);

    QAbstractItemModel *playerInfoListModel();
    QAbstractItemModel *attackListModel();
    QAbstractItemModel *pokemonListModel();
    QObject *battleClientLog();
signals:

    void modelChanged();
    void challengeDeclined();
    void challengeRecieved(QString playerName);
    void battleStarted();

    void battleClientLogChanged();
    void allowAttackSelection();

    void pokemonSelected();

public slots:

    //analyzer signals
    void errorFromNetwork(int, QString);
    void connected();
    void disconnected();
    void printLine(QString);
    void printHtml(QString);
    void printChannelMessage(QString, int, bool);
    void playerReceived(PlayerInfo);
    void playerLogin(PlayerInfo, QStringList);
    void playerLogout(int);
    void challengeStuff(ChallengeInfo);
    void handleBattleStarted(int, Battle, TeamBattle, BattleConfiguration);
    void tiersReceived(QStringList);
    void handleBattleStarted(int, Battle);
    void battleFinished(int, int,int,int);
    void battleCommand(int, QByteArray);
    void askForPass(QByteArray);
    void serverPass(QByteArray);
    void setEnabled(bool);
    void playerKicked(int,int);
    void playerBanned(int,int);
    void playerTempBanned(int,int,int);
    void PMReceived(int,QString);
    void awayChanged(int, bool);
    void ladderChanged(int,bool);
    void watchBattle(int,BattleConfiguration);
    void spectatingBattleMessage(int , QByteArray);
    void stopWatching(int);
    void versionDiff(ProtocolVersion, int);
    void serverNameReceived(QString);
    void tierListReceived(QByteArray);
    void announcementReceived(QString);
    void channelsListReceived(QHash<qint32,QString>);
    void channelPlayers(int,QVector<qint32>);
    void channelCommandReceived(int,int,DataStream*);
    void addChannel(QString,int);
    void removeChannel(int);
    void channelNameChanged(int,QString);
    void setReconnectPass(QByteArray);
    void cleanData();
    void onReconnectFailure(int);
    void sendCommand(QByteArray qba);

    //battle manager
    void onSendOut(int spot, int previndex, ShallowBattlePoke* pokemon, bool silent);
    void onOfferChoice(int, const BattleChoices &c);
    void onChoiceSelection(int player);

private:
    Analyzer * m_analyzer;
    PlayerInfoListModel *m_playerInfoListModel;
    TeamHolder *m_team;
    int currentPos;
    QList<int> userTeam; //新加的
    ChallengeInfo m_cinfo; //store challengeInfo recieved
    int _mid;
    FullBattleConfiguration m_battleConf;
    BattleInput *m_battleInput;
    BattleClientLog *m_battleClientLog;
    BattleInfo *m_battleInfo;
    AttackListModel *m_attackListModel;
    advbattledata_proxy *m_data2;
    int m_battleId;
    PokemonListModel *m_pokemonListModel;
    BattleSceneQtQuick *m_battleSceneQtQuick;

    void sendChoice(const BattleChoice &b);
};

#endif // ANALYZERACCESS_H
