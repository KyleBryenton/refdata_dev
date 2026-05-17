#! /usr/bin/octave-cli -q

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
# ----
# Edited 2026-05-16 by K. R. Bryenton <kyle.bryenton@gmail.com>
# - Added support for Z damping
# - Added support for BJa20 damping (Niche cases where a2<0 in normal BJ routine)
# - Updated interface and now supports new output format for Z damping
# - Added ProcessFitDriver.sh shell script, which summarizes results and merges BJ/BJ0 entries.
#
# Useful script to collect outputs for dir_e_list:
#     find $(pwd) -type d -name "h2o_h2o" | sed 's/\/h2o_h2o/",.../g' | sed 's/\/home/     "\/home/g' | sort --version-sort
#
# After setting `reader`, `f_damp`, and populating `dir_e_list`, run using:
#     ./fit_driver.m > kb49_bj.results
#
# ProcessFitDriver.m can process these results into a table. 
#   If you generate energy_bj, energy_bj0, and energy_bja20 results, it will automatically merge these for you
#   It will reject a1<0 or a2<0, and replace with the bj0/bja20 result with the lowest RMSP. Run using:
#     ./ProcessFitDriver.sh kb49_bj.results kb49_bj0.results kb49_bja20.results


## Reader routines - Select one by uncommenting.
# reader="reader_castep.m";
# reader="reader_dftbp_critic.m";
 reader="reader_fhiaims.m";
# reader="reader_g09_critic.m";
# reader="reader_g09.m";
# reader="reader_nwchem.m";
# reader="reader_orca.m";
# reader="reader_postg.m";
# reader="reader_postg_orca.m";
# reader="reader_postg_psi4_dhybrid.m";
# reader="reader_postg_psi4.m";
# reader="reader_psi4.m";
# reader="reader_qchem.m";
# reader="reader_qe.m";
# reader="reader_qe_manual_energy.m";
# reader="reader_vasp.m";
source(reader);

## Damping function - Select one by uncommenting.
# f_damp="energy_z.m";
 f_damp="energy_bj.m";
# f_damp="energy_bj0.m";
# f_damp="energy_bja20.m";
# f_damp="energy_bj_atm.m";
# f_damp="energy_bj_only68.m";
# f_damp="energy_bj_only6_atm.m";
# f_damp="energy_bj_only6.m";
# f_damp="energy_tt.m";
source(f_damp);

## din file - Source of benchmark reference energies.
din="../10_din/kb49.din";
#din="../10_din/kb65.din";
#din="../10_din/s22.din";

## data source - List paths (as strings) to your benchmarks to fit XDM to. `...` continues the array to the next line.
dir_e_list={...
#     "/home/kyle/KB49_FitDriver_Testing/BJ_Tight_B86bPBE",...
     "/home/kyle/KB49_FitDriver_Testing/Z_Tight_B86bPBE",...

};

## xyz structure source
dir_s="../20_kb65";

## use c9? False=0, True=1
usec9 = 0; 




#### End of input block ####

## globals
warning("off");
pkg load optim
format long
global hy2kcal e n xc z c6 c8 c9 c10 rc dimers mol1 mol2 be_ref active usec9
hy2kcal=627.51;

## read the din file
[n rr] = load_din(din);
dimers = {};
be_ref = struct();
for i = 1:length(rr)
  dimers{end+1} = rr{i}{2};
  be_ref = setfield(be_ref,rr{i}{2},abs(rr{i}{7}));
endfor

## Choose damping parameter starting points for fit
# For XDM(Z), use z_damp = 100000.0 as the starting point
if (strcmp(f_damp,"energy_z.m"))
  pin=[0.0 100000.0];
# For BJ0, use a1 = 0.0, a2 = 1.4545 A
elseif (strcmp(f_damp,"energy_bj0.m"))
  pin=[0.0 1.4545];
# For BJa20, use a1 = 1.4545, a2 = 0 A
elseif (strcmp(f_damp,"energy_bja20.m"))
  pin=[1.4545 0.0];
# Otherwise, use a1 = 1.0, a2 = 1.4545 A
else
  pin=[1.0 1.4545];
endif

## run the fit
for id = 1:length(dir_e_list)
  dir_e = {dir_e_list{id}};
  printf("## FIT for: %s\n",dir_e{1});
  # collect_for_fit.m will use the reader selected above to collect info
  source("collect_for_fit.m");
  # fit_quiet.m will run the least squares routine to fit XDM
  source("fit_quiet.m");
  # fit_report_full.m will generate the report for the selected f_damp type.
  fit_report_full(pout,yin,yout,f_damp);
endfor

# # global a1fix
# alist = linspace(-1.0,2.0,21);
# for i = 1:length(alist)
#   a1fix = alist(i);
#   pin=[a1fix 4.0];
#   source("fit_quiet.m");
#   ## source("eval_quiet.m");
#   fit_report_full(pout,yin,yout);
# endfor

# # successive fits
# funs = {"bpbe"};
# for iff = 1:length(funs)
#   fun = funs{iff};
#   for jj = 0:10
#     dir_e = {sprintf("/home/alberto/calc/erin/%s-%2.2d",fun,jj)};
#     source("collect_for_fit.m");
#     pin=[0.1 4.0];
#     source("fit_quiet.m");
#     printf("%s %2.2d %.4f %.4f %.2f %.2f\n",fun,jj,...
#            pout,mean(abs(yin-yout)),mean(abs((yin-yout)./yin))*100);
#   endfor
# endfor

# ## gaussian time
# dir_e={"data/10_set65_rest_pbe%tzvp","data/10_set65_rest_pbe%def2tzvp","data/20_basis_12_pc-erin1%pbe"}; 
# for j = 1:length(dir_e)
#   dirr = dir_e{j};
#   tt = 0;
#   for i = 1:n
#     tt = tt + gaussian_time(sprintf("%s/%s.log",dirr,dimers{i}));
#   endfor
#   printf("%s %f\n",dirr,tt/3600);
# endfor

