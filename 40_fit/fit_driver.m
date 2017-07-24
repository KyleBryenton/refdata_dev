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

## Reader routines
#source("reader_vasp.m");
#source("reader_qe.m");
source("reader_postg.m");
#source("reader_postg_psi4.m");
#source("reader_orca.m");
#source("reader_psi4.m");
#source("reader_qchem.m");
#source("reader_nwchem.m");
#source("reader_dftbp_critic.m");
#source("reader_g09_critic.m");

## Damping function
#source("energy_bj0.m");
source("energy_bj.m");
#source("energy_bj_only6.m");
#source("energy_tt.m");

## din file
#din="../10_din/temp.din";
din="../10_din/kb49.din";
#din="../10_din/kb65.din";
#din="../10_din/bleh.din";
#din="../10_din/s22.din";

## data source
dir_e={"/home/alberto/calc/xdm/erin1"};
## dir_e={"/home/alberto/calc/dcp/15_xdm/chon_pc1_scan6%hf"};
## dir_e={"/home/alberto/calc/dcp/15_xdm/hf-3c"};
## dir_e={"../30_run/hf_pc2spd"};
## dir_e={"/home/alberto/calc/psi4/kb49_b86bpbe"};
## dir_e={"/home/alberto/calc/ncifun/kb49_wb86bpbe_0.6"};
## dir_e={"/home/alberto/calc/critic2/dftb_fits/dftb_g09_wfn"};
## dir_e={"/home/alberto/calc/critic2/dftb_fits/dftb_g09"};
## dir_e={"/home/alberto/calc/ncifun/10_kb49/kb49_lcwb86b_0.0/"};
## dir_e={"/home/alberto/calc/jake/postg_fitting/6-31Gss_fittingsets/blyp_fitset/70HF_fitset"};
## dir_e={"/home/alberto/git/refdata/30_run/6311+g2d2p-blyp"};
## dir_e={"/home/alberto/calc/erin/pople"};
## dir_e={"/home/alberto/calc/xdm/psi4-wb86bpbe-0.4"};

## xyz structure source
dir_s="../20_kb65";

#### End of input block ####

## globals
warning("off");
pkg load optim
format long
global hy2kcal e n xc z c6 c8 c10 rc dimers mol1 mol2 be_ref active
hy2kcal=627.51;

## read the din file
[n rr] = load_din(din);
dimers = {};
be_ref = struct();
for i = 1:length(rr)
  dimers{end+1} = rr{i}{2};
  be_ref = setfield(be_ref,rr{i}{2},abs(rr{i}{7}));
endfor

## run the fit
source("collect_for_fit.m");
pin=[0.0 1.4545];
source("fit_quiet.m");
source("fit_report.m");
fit_report_full(pout,yin,yout);

# # global a1fix
# alist = linspace(-1.0,2.0,21);
# for i = 1:length(alist)
#   a1fix = alist(i);
#   pin=[a1fix 4.0];
#   source("fit_quiet.m");
#   ## source("eval_quiet.m");
#   source("fit_report.m");
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

