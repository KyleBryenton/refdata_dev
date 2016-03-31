#! /usr/bin/octave-cli -q

# Copyright (c) 2016 Alberto Otero de la Roza <alberto@fluor.quimica.uniovi.es>
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
      "../10_din/g3_99.din",...
    };
names={...
        "g3",...
      };
dirs={...
       "../20_g3",...
     };

## globals
format long;
hy2kcal=627.51;

source("load_din.m");

for idin = 1:length(din)
  [n rxn] = load_din(din{idin});

  ## write the db files
  for i = 1:n
    name = sprintf("%s_%s",names{idin},rxn{i}{2});
    fid = fopen(sprintf("%s.db",name),"w");
    fprintf(fid,"type reaction_frozen");
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
=======
[n rxn] = load_din(din);

# list only the product and the energy
for i = 1:n
  name = rxn{i}{2};
  fid = fopen(sprintf("bde03_%s.db",name),"w");
  fprintf(fid,"type be_frozen_monomer\n");
  fprintf(fid,"ref %.4f\n",rxn{i}{7});

  mol = mol_readxyz(sprintf("%s/%s.xyz",sdir,rxn{i}{2}));
  xx = str2num(mol.name);
  q = xx(1); m = xx(2);
  fprintf(fid,"mol %d %d\n",q,m);
  for j = 1:mol.nat
    fprintf(fid,"%s %.10f %.10f %.10f\n",mol.atname{j},mol.atxyz(:,j));
  endfor
  fprintf(fid,"end\n");

  mol = mol_readxyz(sprintf("%s/%s.xyz",sdir,rxn{i}{4}));
  xx = str2num(mol.name);
  q = xx(1); m = xx(2);
  fprintf(fid,"mon1 %d %d\n",q,m);
  for j = 1:mol.nat
    fprintf(fid,"%s %.10f %.10f %.10f\n",mol.atname{j},mol.atxyz(:,j));
  endfor
  fprintf(fid,"end\n");

  mol = mol_readxyz(sprintf("%s/%s.xyz",sdir,rxn{i}{6}));
  xx = str2num(mol.name);
  q = xx(1); m = xx(2);
  fprintf(fid,"mon2 %d %d\n",q,m);
  for j = 1:mol.nat
    fprintf(fid,"%s %.10f %.10f %.10f\n",mol.atname{j},mol.atxyz(:,j));
  endfor
  fprintf(fid,"end\n");

  fclose(fid);
>>>>>>> 0ecc79dc4523552240b3beb29d5ccffba7bbbb12
endfor
