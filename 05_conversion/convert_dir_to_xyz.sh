#! /bin/bash

# Copyright (c) 2015 Alberto Otero de la Roza <alberto@fluor.quimica.uniovi.es>
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

for i in * ; do

    awk '
/coord/,/end/{
    if (NF == 4){
	   printf "%s %.15f %.15f %.15f\n", $4, $1*0.52917720859, $2*0.52917720859, $3*0.52917720859
       }
}
' $i > $i.tmp

    wc -l $i.tmp | awk '{print $1}' > $i.xyz

    if [ -f mult ] ; then
	mult=$(awk "\$1 == \"$i\"{print \$NF+1}" mult)
    fi
    mult=${mult:-1}

    if [ -f charge ] ; then
	q=$(awk "\$1 == \"$i\"{print \$NF+0}" charge)
    fi
    q=${q:-0}

    echo $q $mult >> $i.xyz
    cat $i.tmp >> $i.xyz
    rm $i.tmp
done

