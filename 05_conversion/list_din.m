#! /usr/bin/octave-cli -q

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

din="../10_din/g3_99.din";

## globals
format long;
hy2kcal=627.51;

source("load_din.m");
[n rxn] = load_din(din);

# list only the product and the energy
for i = 1:n
  printf(" %30s  %10.3f\n",rxn{i}{2},rxn{i}{end});
endfor

# # list only the product and the energy
# for i = 1:n
#   printf("|-\n");
#   r = rxn{i};
#   nn = length(r);
#   str1 = str2 = "";
#   list = {};
#   for j = 1:2:nn-1
#     if (r{j} > 0)
#       if (isempty(str1))
#         str1 = r{j+1};
#       else
#         str1 = sprintf("%s + %s",str1,r{j+1});
#       endif
#     else
#       if (isempty(str2))
#         str2 = sprintf("%d %s",abs(r{j}),r{j+1});
#       else
#         str2 = sprintf("%s + %d %s",str2,abs(r{j}),r{j+1});
#       endif
#       list = {list{:}, r{j+1}};
#     endif
#   endfor
#   printf("| %s\n",str1);
#   printf("| %s\n",str2);
#   printf("| %.2f\n",r{end});
#   printf("| [http://gatsby.ucmerced.edu/downloads/bdes/%s.gjf mol] ",str1);
#   printf("[http://gatsby.ucmerced.edu/downloads/bdes/%s.xyz xyz] ",str1);
#   for j = 1:length(list)
#     printf("[http://gatsby.ucmerced.edu/downloads/bdes/%s.gjf m%d] ",list{j},j);
#   endfor
#   printf("\n");
#   # printf(" %30s  %10.3f\n",rxn{i}{end-1},rxn{i}{end});
# endfor
