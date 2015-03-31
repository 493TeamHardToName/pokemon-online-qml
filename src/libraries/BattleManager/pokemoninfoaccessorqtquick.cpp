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

#include "pokemoninfoaccessorqtquick.h"

#include <PokemonInfo/pokemoninfo.h>

PokemonInfoAccessorQtQuick::PokemonInfoAccessorQtQuick() :
    QQuickImageProvider(QQuickImageProvider::Pixmap)
{
}

QPixmap PokemonInfoAccessorQtQuick::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    (void) requestedSize;

    QPixmap ret;

    if (id.startsWith("icon/")) {
        ret = PokemonInfo::Icon(id.section("/", 1).toInt());
    } else if (id.startsWith("pokemon/")){
        ret = PokemonInfo::Picture(id.section('/', 1));
    } else if (id.startsWith("item/")) {
        ret = ItemInfo::Icon(id.section("/", 1).toInt());
    }

    *size = ret.size();

    return ret;
}
