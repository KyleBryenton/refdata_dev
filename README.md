# Refdata

## Overview

This repository provides a collection of databases for benchmarking
quantum mechanical methods. The bulk of the repository are the `20_xx`
directories, which contain the structures for several popular
benchmark sets for which highly accurate reference data (or maybe
otherwise) are known. The structures are provided in xyz, Gaussian
input format (gjf), and, occasionally, in nwchem input format (nw). We
will go adding more formats as needed.

The `25_xx` directories contain crystal structures. In this case,
there are several subdirectories, corresponding to different
geometries. The `expt` directory is the experimental structure
(usually in cif format), and the `b86bpbe-xdm` directory contains the
B86bPBE-XDM equilibrium geometry, given as a Quantum ESPRESSO output
(scf.out, you can use
[critic2](https://github.com/aoterodelaroza/critic2) to convert
between the two).

The complete list of `20_xx` and `25_xx` databases is given below. The
list grows as we calculate new benchmark sets from the literature, but
contributions are very much welcome. 

The reference energies for these sets are in the `10_din` directory,
in din format. Din files contain a header at the top of the file with
the literature source for the reference data. Din files are plain-text
files that contain reference energies in kcal/mol for various
properties (reaction energies, binding energies, etc.). After the
header (a sequence of comments that start with `#`) the din file has a
sequence of blocks such as:

  ```
  -1
  A
  1
  B
  2
  C
  0
  6.493
  ```

This din-file block says that the energy for the reaction:
  
  ```
  A -> B + 2C
  ```

is 6.493 kcal/mol. (kcal/mol is the default unit in all inputs and
outputs of this repository.) Given this din file, the associated
scripts (in `40_*`, see below) will try to find output files of
calculations corresponding to the entries in the block. For instance,
in a Gaussian calculation, the script will fetch the energies from
A.log, B.log, and C.log, then calculate the reaction energy using the
din-file coefficients, and compare to the reference energy.

The `05_conversion` directory contains various bits and pieces. For
instance, scripts that I used to convert the literature reference data
from the format in the original papers to din files.

The `40_xx` directories contain octave scripts to manipulate the din
file and the structures, and to perform and evaluate the benchmark
calculations. Almost all scripts in this repository are written in
octave, with the occasional bash or awk script. The main script in
`40_eval` is `eval_driver.m`, which accepts a din file, a target
directory, and an interpretation recipe (e.g. read Quantum ESPRESSO
outputs). `eval_driver.m` will read and parse the din file, find all
the necessary energies from the output files in the target directory,
calculate the corresponding reaction energies, compare to the
reference energies, and print out a table and some useful statistics.

The `40_fit` directory contains routines for running XDM
parametrizations. The main script is `fit_driver.m`, which works
pretty much the same as `eval_driver.m`, except in this case the
intent is to find the XDM damping function coefficients for a given
set (usually, `20_kb49` but occasionally `20_kb65`). The `xdm.param`
file in the root of this repository contains the master list of XDM
parameters, and is exactly the same as the equivalent file in the
[postg](https://github.com/aoterodelaroza/postg) repository.

## Manifest (molecules)

| Set        | Directory          | Contents                                        | Level                           | Refs                                                        |
|------------|--------------------|-------------------------------------------------|---------------------------------|-------------------------------------------------------------|
| A24        | 20_a24/            |                                                 |                                 |                                                             |
| ACHC       | 20_achc/           |                                                 |                                 |                                                             |
| BAUZA      | 20_bauza/          |                                                 |                                 |                                                             |
| BBI        | 20_bbi/            |                                                 |                                 |                                                             |
| BDES       | 20_bdes/           |                                                 |                                 |                                                             |
| BH         | 20_bh/             |                                                 |                                 |                                                             |
| CT         | 20_ct/             |                                                 |                                 |                                                             |
| G3         | 20_g3/             |                                                 |                                 |                                                             |
| ACONF      | 20_gmtkn_aconf/    |                                                 |                                 |                                                             |
| ADIM6      | 20_gmtkn_adim6/    |                                                 |                                 |                                                             |
| AL2X       | 20_gmtkn_al2x/     |                                                 |                                 |                                                             |
| ALK6       | 20_gmtkn_alk6/     |                                                 |                                 |                                                             |
| BH76       | 20_gmtkn_bh76/     |                                                 |                                 |                                                             |
| BHPERI     | 20_gmtkn_bhperi/   |                                                 |                                 |                                                             |
| BSR36      | 20_gmtkn_bsr36/    |                                                 |                                 |                                                             |
| CYCONF     | 20_gmtkn_cyconf/   |                                                 |                                 |                                                             |
| DARC       | 20_gmtkn_darc/     |                                                 |                                 |                                                             |
| DC9        | 20_gmtkn_dc9/      |                                                 |                                 |                                                             |
| G21EA      | 20_gmtkn_g21ea/    |                                                 |                                 |                                                             |
| G21IP      | 20_gmtkn_g21ip/    |                                                 |                                 |                                                             |
| G2RC       | 20_gmtkn_g2rc/     |                                                 |                                 |                                                             |
| HEAVY28    | 20_gmtkn_heavy28/  |                                                 |                                 |                                                             |
| IDISP      | 20_gmtkn_idisp/    |                                                 |                                 |                                                             |
| ISO34      | 20_gmtkn_iso34/    |                                                 |                                 |                                                             |
| ISOL22     | 20_gmtkn_isol22/   |                                                 |                                 |                                                             |
| MB08-165   | 20_gmtkn_mb08-165/ |                                                 |                                 |                                                             |
| NBPRC      | 20_gmtkn_nbprc/    |                                                 |                                 |                                                             |
| O3ADD6     | 20_gmtkn_o3add6/   |                                                 |                                 |                                                             |
| PA         | 20_gmtkn_pa/       |                                                 |                                 |                                                             |
| PCONF      | 20_gmtkn_pconf/    |                                                 |                                 |                                                             |
| RG6        | 20_gmtkn_rg6/      |                                                 |                                 |                                                             |
| RSE43      | 20_gmtkn_rse43/    |                                                 |                                 |                                                             |
| S22        | 20_gmtkn_s22/      |                                                 |                                 |                                                             |
| SCONF      | 20_gmtkn_sconf/    |                                                 |                                 |                                                             |
| SIE11      | 20_gmtkn_sie11/    |                                                 |                                 |                                                             |
| W4-08      | 20_gmtkn_w4-08/    |                                                 |                                 |                                                             |
| WATER27    | 20_gmtkn_water27/  |                                                 |                                 |                                                             |
| HBC6       | 20_hbc6/           |                                                 |                                 |                                                             |
| HSG        | 20_hsg/            |                                                 |                                 |                                                             |
| IONICHB    | 20_ionichb/        |                                                 |                                 |                                                             |
| ISOM       | 20_isom/           |                                                 |                                 |                                                             |
| KB49       | 20_kb49/           |                                                 |                                 |                                                             |
| KB65       | 20_kb65/           |                                                 |                                 |                                                             |
| L7         | 20_l7/             |                                                 |                                 |                                                             |
| MBCC-VIE   | 20_mbcc_vie/       |                                                 |                                 |                                                             |
| NBC10EXT   | 20_nbc10ext/       |                                                 |                                 |                                                             |
| P26        | 20_p26/            |                                                 |                                 |                                                             |
| PA26       | 20_pa26/           |                                                 |                                 |                                                             |
| S12L       | 20_s12l/           | Binding energies of large host-guest complexes  | Back-corrected experimental/QMC | [grimme2012],[risthaus2013],[ambrosetti2015]                |
| S22        | 20_s22/            | Intermolecular binding energies of small dimers | CCSD(T)/CBS                     | [jurecka2006],[podeszwa2010],[marchetti2011],[marshall2011] |
| S22x5      | 20_s22x5/          | S22 with varying intermolecular distances       | CCSD(T)/CBS                     | [jurecka2006],[grafova2010]                                 |
| S22x7      | 20_s22x7/          | S22 with varying intermolecular distances       | DW-CCSD(T**)-F12/CBS            | [jurecka2006],[grafova2010],[sherrill2016]                  |
| S30L       | 20_s30l/           | Binding energies of large host-guest complexes  | Back-corrected experimental     | [sure2015]                                                  |
| S66        | 20_s66/            | Intermolecular binding energies of small dimers | CCSD(T)/CBS                     | [rezac2011],[dilabio2013]                                   |
| S66x8      | 20_s66x8/          | S66 with varying intermolecular distances       | CCSD(F12*)(T)/CBS               | [rezac2011],[brauer2016]                                    |
| S66x10     | 20_s66x10/         | S66 with varying intermolecular distances       | DW-CCSD(T**)-F12/CBS            | [rezac2011]                                                 |
| SSI        | 20_ssi/            |                                                 |                                 |                                                             |
| SULFURx8   | 20_sulfur_x8/      |                                                 |                                 |                                                             |
| TM         | 20_tm/             |                                                 |                                 |                                                             |
| W4-11      | 20_w4-11/          |                                                 |                                 |                                                             |
| WATER      | 20_water/          |                                                 |                                 |                                                             |
| WATER25x10 | 20_water2510/      |                                                 |                                 |                                                             |
| X40        | 20_x40/            |                                                 |                                 |                                                             |
| X40x10     | 20_x40x10/         |                                                 |                                 |                                                             |
| XB18       | 20_xb18/           |                                                 |                                 |                                                             |
| XB51       | 20_xb51/           |                                                 |                                 |                                                             |

[jurecka2006]: http://dx.doi.org/10.1039/B600027D
[grafova2010]: https://pubs.acs.org/doi/abs/10.1021/ct1002253
[podeszwa2010]: http://dx.doi.org/10.1039/B926808A
[marchetti2011]: http://dx.doi.org/10.1039/B804334E
[marshall2011]: http://dx.doi.org/10.1063/1.3659142
[rezac2011]: https://dx.doi.org/10.1021/ct2002946
[grimme2012]: https://onlinelibrary.wiley.com/doi/abs/10.1002/chem.201200497
[dilabio2013]: https://dx.doi.org/10.1039/C3CP51559A
[risthaus2013]: https://pubs.acs.org/doi/abs/10.1021/ct301081n
[ambrosetti2015]: https://pubs.acs.org/doi/abs/10.1021/jz402663k
[sure2015]: https://dx.doi.org/10.1021/acs.jctc.5b00296
[brauer2016]: http://dx.doi.org/10.1039/c6cp00688d
[sherrill2016]: http://dx.doi.org/10.1021/acs.jpclett.6b00780

## Manifest (crystals)

| Set       | Directory     | Contents                                                            | Level                       | Refs                   |
|-----------|---------------|---------------------------------------------------------------------|-----------------------------|------------------------|
| EE        | 25_ee/        | Enantiomeric excess in solution at the triple point                 | B86bPBE-XDM or experimental | [aor2014],[aor2016]    |
| POLYMORPH | 25_polymorph/ | First three candidates from all groups for first 5 CCDC blind tests | B86bPBE-XDM                 | [aor2017a],[aor2017b]  |
| X23       | 25_x23/       | Lattice energies of small molecular crystals                        | Back-corrected experimental | [aor2012],[reilly2013] |

[aor2012]: https://dx.doi.org/10.1063/1.4738961
[reilly2013]: https://dx.doi.org/10.1063/1.4812819
[aor2014]: https://dx.doi.org/10.1002/anie.201403541
[aor2016]: https://dx.doi.org/10.1021/acs.cgd.6b01088
[aor2017a]: https://dx.doi.org/10.1021/acs.jctc.6b00679
[aor2017b]: https://dx.doi.org/10.1021/acs.jctc.7b00715

