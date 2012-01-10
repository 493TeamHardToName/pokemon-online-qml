#include <QStackedWidget>
#include <QTabBar>
#include <QGridLayout>

#include "../PokemonInfo/pokemoninfo.h"
#include "teammenu.h"
#include "pokeedit.h"

TeamMenu::TeamMenu(TeamHolder *team, int index) :
    ui(new _ui()), m_team(team)
{
    setupUi();

    switchToTab(index);
}

void TeamMenu::setupUi()
{
    QGridLayout *grid = new QGridLayout(this);
    grid->addWidget(ui->stack = new QStackedWidget(), 0, 0, 1, 1);
    grid->addWidget(ui->pokemonTabs = new QTabBar(), 0, 0, 1, 1, Qt::AlignLeft|Qt::AlignTop);

    for (int i = 0; i < 6; i++) {
        ui->pokemonTabs->addTab(PokemonInfo::Icon(i+1), tr("Slot #&%1").arg(i+1));
    }
    ui->pokemonTabs->setCurrentIndex(0);

    connect(ui->pokemonTabs, SIGNAL(currentChanged(int)), SLOT(switchToTab(int)));
}

void TeamMenu::switchToTab(int index)
{
    if (ui->pokemonTabs->currentIndex() != index) {
        /* The signal/slot connection will call us again, thus we return */
        ui->pokemonTabs->setCurrentIndex(index);
        return;
    }
    if (!ui->pokemons.contains(index)) {
        ui->stack->addWidget(ui->pokemons[index]= new PokeEdit());
        connect(ui->pokemons[index], SIGNAL(switchToTrainer()), SIGNAL(switchToTrainer()));
    }
    ui->stack->setCurrentWidget(ui->pokemons[index]);
}

TeamMenu::~TeamMenu()
{
    delete ui;
}