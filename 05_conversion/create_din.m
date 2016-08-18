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

dimers = {\
          "he_he","he_ne","he_ar","he_kr","ne_ne","ne_ar","ne_kr","ar_ar",\
          "ar_kr","kr_kr","he_n2_l","he_n2_t","he_fcl","fcl_he","ch4_c2h4",\
          "cf4_cf4","sih4_ch4","ocs_ocs","c10h8_c10h8_p","c10h8_c10h8_pc",\
          "c10h8_c10h8_t","c10h8_c10h8_tc","sih4_hf","ch4_nh3","ch4_hf",\
          "c2h4_hf","ch3f_ch3f","h2co_h2co","ch3cn_ch3cn","hcn_hf","co2_co2",\
          "nh3_nh3","h2o_h2o","h2co2_h2co2","formamide_formamide","uracil_uracil_hb",\
          "pyridoxine_aminopyridine","adenine_thymine_wcc1","ch4_ch4","c2h4_c2h4",\
          "c6h6_ch4","c6h6_c6h6_pd","pyrazine_pyrazine","uracil_uracil_stack",\
          "indole_c6h6_stack","adenine_thymine_stack","c2h4_c2h2","c6h6_h2o",\
          "c6h6_nh3","c6h6_hcn","c6h6_c6h6_t","indole_c6h6_t","phenol_phenol",\
          "hf_hf","nh3_h2o","h2s_h2s","hcl_hcl","h2s_hcl","ch3cl_hcl","hcn_ch3sh",\
          "ch3sh_hcl","ch4_ne","c6h6_ne","c2h2_c2h2","c6h6_c6h6_stack"};
be = [\
      0.022, 0.041, 0.059, 0.062, 0.084, 0.132, 0.141, 0.285, 0.333, 0.400,\
      0.053, 0.066, 0.097, 0.182, 0.49, 0.87, 0.79, 1.72, 4.070, 5.725, 5.173,\
      3.939, 0.76, 0.74, 1.61, 4.47, 2.38, 3.42, 6.19, 7.42, 1.44, 3.133, 4.989,\
      18.753, 16.062, 20.641, 16.934, 16.660, 0.527, 1.472, 1.448, 2.654,\
      4.255, 9.805, 4.524, 11.730, 1.496, 3.275, 2.312, 4.541, 2.717, 5.627,\
      7.097, 4.57, 6.41, 1.66, 2.01, 3.35, 3.55, 3.59, 4.88, 0.22, 0.47, 1.34, 1.81];

for i = 1:length(be)
  printf("1\n");
  printf("%s\n",dimers{i});
  printf("-1\n");
  printf("%s_1\n",dimers{i});
  printf("-1\n");
  printf("%s_2\n",dimers{i});
  printf("0\n");
  printf("%.3f\n",-be(i));
endfor
