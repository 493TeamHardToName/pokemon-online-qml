/* Copyright (C) 2015 Boren Zhang <zhangbr@umich.edu>

   This file is part of PokemonOnlineQML

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public version 3
   License as published by the Free Software Foundation;

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef POKEMONINFOACCESSORQTQUICK_H
#define POKEMONINFOACCESSORQTQUICK_H

#include <QtQuick/QQuickImageProvider>

class PokemonInfoAccessorQtQuick : public QQuickImageProvider
{
public:
    explicit PokemonInfoAccessorQtQuick();

    virtual QPixmap requestPixmap(const QString &id, QSize *size, const QSize& requestedSize);
signals:

public slots:

};

#endif // POKEMONINFOACCESSORQTQUICK_H
