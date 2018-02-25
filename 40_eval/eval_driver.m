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

## Choose the energy reader and name generator
source("reader_g09-simple.m");
# source("reader_postg-simple.m");
# source("reader_d3-simple.m");
# source("reader_espresso-simple.m");
# source("reader_crystal-simple.m");
# source("reader_siesta-simple.m");
# source("reader_dftb+-simple.m");
# source("reader_sqm-simple.m");
# source("reader_orca-simple.m");
# source("reader_postg_psi4-simple.m");
 
data = {...
         ## "/home/alberto/calc/xdm_opt/15_x23_zerop/b86bpbe-xdm/",... ## x23, b86b result
         ## "/home/alberto/calc/csp_acp/20_x23-pressure",...           ## x23, non-tight result
         ## "/home/alberto/calc/csp_acp/50_eval/prod-20-x",...  ## ACP, sp, b86b
         ## "/home/alberto/calc/csp_acp/50_eval/prod-20-x",...  ## ACP, sp, ref
         ## "/home/alberto/calc/csp_acp/70_opt",... ## ACP, opt, b86b
         ## "/home/alberto/calc/csp_acp/70_opt",... ## ACP, opt, ref

         ## "/home/alberto/calc/xdm_opt/15_ee",... ## ee, b86b results
         ## "/home/alberto/calc/csp_acp/20_ee-pressure",... ## ee, b86b non-tight result
         ## "/home/alberto/calc/csp_acp/50_eval/prod-20-x",...  ## ACP, sp, b86b
         ## "/home/alberto/calc/csp_acp/50_eval/prod-20-x",...  ## ACP, sp, ref
         ## "/home/alberto/calc/csp_acp/70_opt",... ## ACP, opt, b86b
         ## "/home/alberto/calc/csp_acp/70_opt",... ## ACP, opt, ref

         "/home/alberto/calc/bsip-add/15_cbs/w4-11@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/gmtkn_bsr36@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/gmtkn_darc@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/gmtkn_bhperi@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/gmtkn_bh76@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/gmtkn_bh76@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/gmtkn_iso34@blyp",...
         "/home/alberto/calc/bsip-add/15_cbs/pa26@blyp",...
       };
din = {...
        ## "../10_din/x23.din",...
        ## "../10_din/x23_cspacp.din",...
        ## "../10_din/x23_cspacp-b86b.din",...
        ## "../10_din/x23_cspacp.din",...
        ## "../10_din/x23_cspacp-b86b_no21.din",...
        ## "../10_din/x23_cspacp_no21.din",...

        ## "../10_din/ee_cspacp.din",...
        ## "../10_din/ee_cspacp_no21.din",...
        ## "../10_din/ee_cspacp-b86b_no21.din",...
        ## "../10_din/ee_cspacp_no21.din",...
        ## "../10_din/ee_cspacp-b86b.din",...
        ## "../10_din/ee_cspacp.din",...

        "../10_din/w4-11.din",...
        "../10_din/gmtkn_bsr36-rev1.din",...
        "../10_din/gmtkn_darc-rev1.din",...
        "../10_din/gmtkn_bhperi-rev1.din",...
        "../10_din/gmtkn_bh76-rev1.din",...
        "../10_din/gmtkn_bh76rc-rev1.din",...
        "../10_din/gmtkn_iso34-rev1.din",...
        "../10_din/pa26.din",...
      };

#### Now DO stuff ####
warning("off");
format long;

## some checks
if (length(din) != length(data))
  error("Inconsistent lengths of the data and din cell arrays.")
endif
ndin = length(din);

for i = 1:ndin
  ## the din file exists?
  if (!exist(din{i},"file"))
    printf("Error! din file does not exist: %s\n",din{i})
    continue
  endif

  ## Process the outputs
  [n rxn opts] = load_din(din{i});
  [mad,md,rms,mapd,mpd,rmsp,maxad,maxadline,maxapd,maxapdline,elist,lines] = process_din(n,rxn,data{i},0);

  #### Simple output, whole list
  printf("## din file: %s\n",din{i});
  printf("## data file: %s\n",data{i});
  printf("## All results in kcal/mol.\n",din{i});
  printf("| name | Ref. | Calc. | \n");
  for j = 1:n
    yref = rxn{j}{end};
    if (!isfield(opts,"fieldasrxn") || isempty(opts.fieldasrxn) || opts.fieldasrxn == 0)
      str = lines{j};
    elseif (opts.fieldasrxn > 0)
      str = rxn{j}{2*opts.fieldasrxn};
    elseif (opts.fieldasrxn < 0)
      str = rxn{j}{end+1+2*opts.fieldasrxn};
    else
      str = lines{j};
    endif

    printf("| %25s | %10.3f | %10.3f |\n",str,yref,elist(j));
  endfor
  printf("| MAE  | -- | %.3f |\n",mad(1));
  printf("| ME   | -- | %.3f |\n",md(1));
  printf("| MAPE | -- | %.3f |\n",mapd(1));
  printf("| MPE  | -- | %.3f |\n",mpd(1));
  printf("| RMS  | -- | %.3f |\n",rms(1));
  printf("| RMSP | -- | %.3f |\n",rmsp(1));
  printf("\n");
endfor
