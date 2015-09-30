#! /usr/bin/octave -q

format long

[s out] = system("ls *xyz");
list = strsplit(out);
list = list(1:end-1);

for i = 1:length(list)
  mol = mol_readxyz(list{i});
  aux = strsplit(list{i},".");
  name = aux{1};
  fid = fopen(sprintf("%s.nw",name),"w");

  [s out] = system(sprintf("awk 'NR==2{print $1, $2}' %s.xyz",name));
  aux = str2num(out);
  q = aux(1);
  mult = aux(2);
  
  fprintf(fid,"memory 2400 mb heap 500 mb global 1000 mb\n");
  fprintf(fid,"title %s\n",name);
  fprintf(fid,"start %s\n",name);
  fprintf(fid,"geometry noautoz\n");
  for j = 1:mol.nat
    fprintf(fid,"  %s %.15f %.15f %.15f\n",mol.atname{j},mol.atxyz(:,j));
  endfor
  fprintf(fid,"end\n");
  fprintf(fid,"basis spherical\n");
  fprintf(fid,"* library aug-cc-pvtz\n");
  fprintf(fid,"end\n");
  fprintf(fid,"dft\n");
  fprintf(fid,"  maxiter 200\n");
  fprintf(fid,"  xc xpbe96 cpbe96\n");
  fprintf(fid,"  direct\n");
  fprintf(fid,"  grid xfine\n");
  fprintf(fid,"  xdm a1 1.0 a2 1.0\n");
  fprintf(fid,"end\n");
  fprintf(fid,"task dft energy\n");
  fprintf(fid,"\n");
  fclose(fid);
endfor

