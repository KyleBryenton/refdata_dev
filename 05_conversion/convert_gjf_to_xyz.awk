#! /usr/bin/awk -f

# Copyright (c) 2015 Alberto Otero de la Roza <aoterodelaroza@gmail.com>
#
# refdata is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

/^ *$/{nblank++}
nblank == 2{
    getline
    q = $1
    mult = $2
    getline
    for (;$0 !~ /^ *$/;getline){
	nat++
	at[nat] = $1
	x[nat] = $2
	y[nat] = $3
	z[nat] = $4
    }
    nblank = 3
}
END{
    print nat
    print q, mult
    for (i=1;i<=nat;i++)
	print at[i], x[i], y[i], z[i]
}
