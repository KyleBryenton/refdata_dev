#! /usr/bin/octave-cli -q

# Copyright (c) 2016 Alberto Otero de la Roza <aoterodelaroza@gmail.com>
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

din={...
      "../10_din/s22x5.din",...
      "../10_din/s66x8.din",...
    };
names={...
      "s225",...
      "s668",...
      };
nref=[2 2];
dirs={...
       "../20_s22x5/",...
       "../20_s66x8/",...
     };


## globals
format long;
hy2kcal=627.51;

for idin = 1:length(din)
  [n rxn] = load_din(din{idin});

  ## write the db files
  for i = 1:n
    if (nref(idin) > 0)
      name = sprintf("%s_%s",names{idin},rxn{i}{nref(idin)});
    else
      name = sprintf("%s_%3.3d",names{idin},i);
    endif
    fid = fopen(sprintf("%s.db",name),"w");
    fprintf(fid,"type reaction_frozen\n");
    fprintf(fid,"ref %.4f\n",rxn{i}{end});
    for j = 1:(length(rxn{i})-1)/2
      mol = mol_readxyz(sprintf("%s/%s.xyz",dirs{idin},rxn{i}{2*j}));
      [q m] = sscanf(mol.name,"%d %d","C");
      fprintf(fid,"molc %.1f %d %d\n",rxn{i}{2*j-1},q,m);
      for k = 1:mol.nat
        fprintf(fid,"%s %.10f %.10f %.10f\n",mol.atname{k},mol.atxyz(:,k));
      endfor
      fprintf(fid,"end\n");
    endfor
    fclose(fid);
  endfor
endfor
