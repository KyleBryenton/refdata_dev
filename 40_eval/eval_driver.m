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

## Choose the file reader
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
 
## Source directory
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

## din files
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

## Separator character in the output
## sep="|";
## sep=" ";
sep=",";

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

  ## First pass, reassign the lines based on the fieldasrxn option
  if (isfield(opts,"fieldasrxn") && !isempty(opts.fieldasrxn) && opts.fieldasrxn != 0)
    for j = 1:n
      if (opts.fieldasrxn > 0)
        str = rxn{j}{2*opts.fieldasrxn};
      elseif (opts.fieldasrxn < 0)
        str = rxn{j}{end+1+2*opts.fieldasrxn};
      endif
      lines{j} = str;
    endfor
  endif

  ## Second pass, calculate the maximum length
  maxlen = 10;
  for j = 1:n
    maxlen = max(maxlen,length(lines{j}));
  endfor

  #### Simple output, whole list
  printf("## din file: %s\n",din{i});
  printf("## data file: %s\n",data{i});
  printf("## All results in kcal/mol.\n",din{i});
  printf("%s %*s %s %10s %s %10s %s \n",sep,maxlen,"Name",sep,"Ref.",sep,"Calc.",sep);
  for j = 1:n
    yref = rxn{j}{end};
    printf("%s %*s %s %10.3f %s %10.3f %s\n",sep,maxlen,lines{j},sep,yref,sep,elist(j),sep);
  endfor
  printf("%s %*s %s      ---   %s %10.3f %s\n",sep,maxlen,"MAE",sep,sep,mad(1),sep);
  printf("%s %*s %s      ---   %s %10.3f %s\n",sep,maxlen,"ME",sep,sep,md(1),sep);
  printf("%s %*s %s      ---   %s %10.3f %s\n",sep,maxlen,"MAPE",sep,sep,mapd(1),sep);
  printf("%s %*s %s      ---   %s %10.3f %s\n",sep,maxlen,"MPE",sep,sep,mpd(1),sep);
  printf("%s %*s %s      ---   %s %10.3f %s\n",sep,maxlen,"RMS",sep,sep,rms(1),sep);
  printf("%s %*s %s      ---   %s %10.3f %s\n",sep,maxlen,"RMSP",sep,sep,rmsp(1),sep);
  printf("\n");
endfor
