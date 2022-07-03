#! /usr/bin/octave-cli -q

tref = 298.15; ## rt in kelvin
R = 8.3144598; ## gas constant in J/K/mol
RT = R * tref / 1000 / 4.184;

eeexp=[
 60.4 ## ala       
  0.7 ## asp       
 58.4 ## cys       
  0.7 ## glu       
 93.7 ## his       
 87.9 ## leu       
 44.4 ## pro       
100.0 ## ser       
 51.7 ## tyr       
 44.1 ## val       
 34.0 ## aldol     
 62.0 ## black     
 74.0 ## nhelic    
100.0 ## tetrazole 
];

list = {...
         {"ala_l","ala_dl"},...
         {"asp_l","asp_dl"},...
         {"cys_l","cys_dl"},...
         ## {"gln_l","gln_dl"},...
         {"glu_l","glu_dl"},...
         {"his_l","his_dl"},...
         ## {"ile_l","ile_dl"},...
         {"leu_l","leu_dl"},...
         {"pro_l","pro_dl"},...
         {"ser_l","ser_dl"},...
         {"tyr_l","tyr_dl"},...
         {"val_l","val_dl"},...
         {"aldol_l","aldol_dl"},...
         {"black_l","black_dl"},...
         {"nhelic_l","nhelic_dl"},...
         {"tetrazole_l","tetrazole_dl"},...
       };

function [ee Z] = qe_stuff(name)
  file = sprintf("%s/%s.scf.out",name,name);
  if (exist(file,"file"))
    [s out] = system(sprintf("grep -a ! %s | tail -n 1 | awk '{print $5}'",file));
    ee = str2num(out);
    [s out] = system(sprintf("cat %s/Z",name));
    Z = str2num(out);
  else
    Z = ee = 0;
  endif
endfunction

RT = 8.3144598 * 293.15 / 1000;

eeold = eenew = zeros(length(list),1);
printf("## de < 0 -> conglomerate more stable \n");
printf("|   ena  |   rac  |   de   | ee(old) | ee(new) | ee(exp) |\n");
for i = 1:length(list)
    pair = list{i};
    [e1 Z1] = qe_stuff(pair{1});
    [e2 Z2] = qe_stuff(pair{2});
    de = (e1/Z1-e2/Z2) / 2 * 627.50947 * 4.184;
    alp = exp(de / RT);
    eeold(i) = max((alp^2-1) / (alp^2+1) * 100,0);
    eenew(i) = max((alp^2-4) / (alp^2+4) * 100,0);
    printf("| %s | %s | %10.3f | %8.2f | %8.2f | %8.2f |\n",pair{1},pair{2},de,eeold(i),eenew(i),eeexp(i));
endfor
printf("| MAE | | | %.2f | %.2f | |\n",mean(abs(eeold-eeexp)),mean(abs(eenew-eeexp)));
printf("\n");

## convert back to energies
printf("## In terms of energies (kJ/mol)\n");
printf("|   ena  |   rac  |   de   | de(old) | de(new) |\n");
mold = mnew = 0;
n = 0;
for i = 1:length(list)
  pair = list{i};
  [e1 Z1] = qe_stuff(pair{1});
  [e2 Z2] = qe_stuff(pair{2});
  de = (e1/Z1-e2/Z2) / 2 * 627.50947 * 4.184;
  if (eeexp(i) < 1)
    deold = " < 0";
    denew = " < 0";
  elseif (eeexp(i) > 99)
    deold = " large ";
    denew = " large ";
  else
    x = eeexp(i)/100;
    aold = RT * log(sqrt((1+x)/(1-x)));
    anew = RT * log(sqrt((4+4*x)/(1-x)));
    deold = sprintf("%10.3f",aold);
    denew = sprintf("%10.3f",anew);
    mold = mold + abs(aold - de);
    mnew = mnew + abs(anew - de);
    n++;
  endif
  printf("| %s | %s | %10.3f | %s | %s |\n",pair{1},pair{2},de,deold,denew);
endfor
mold = mold / n;
mnew = mnew / n;
printf("|  |  |  | %10.3f | %10.3f |\n",mold,mnew);
