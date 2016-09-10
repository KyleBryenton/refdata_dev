#! /usr/bin/octave -q

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

format long

[s out] = system("ls *xyz");
list = strsplit(out);
list = list(1:end-1);

for i = 1:length(list)
  mol = mol_readxyz(list{i});
  aux = strsplit(list{i},".");
  name = aux{1};
  fid = fopen(sprintf("%s.gjf",name),"w");

  [s out] = system(sprintf("awk 'NR==2{print $1, $2}' %s.xyz",name));
  aux = str2num(out);
  q = 0;
  mult = 1;
  
  fprintf(fid,"%%nprocs=4\n");
  fprintf(fid,"%%mem=4GB\n");
  fprintf(fid,"#p pbepbe aug-cc-pvtz output=wfx scf=(conver=6) int=(grid=ultrafine)\n");
  fprintf(fid,"\n");
  fprintf(fid,"title\n");
  fprintf(fid,"\n");
  fprintf(fid,"%d %d\n",q,mult);
  for j = 1:mol.nat
    fprintf(fid,"%s %.15f %.15f %.15f\n",mol.atname{j},mol.atxyz(:,j));
  endfor
  fprintf(fid,"\n");
  fprintf(fid,"%s.wfx\n",name);
  fprintf(fid,"\n");
  fclose(fid);
endfor

