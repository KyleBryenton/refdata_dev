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

| Set        | Directory          | Contents                                                  | Level                           | Refs                                                         |
|------------|--------------------|-----------------------------------------------------------|---------------------------------|--------------------------------------------------------------|
| A24        | 20_a24/            |                                                           |                                 |                                                              |
| ACHC       | 20_achc/           |                                                           |                                 |                                                              |
| BAUZA      | 20_bauza/          |                                                           |                                 |                                                              |
| BBI        | 20_bbi/            | Dimer binding energies (backbone-backbone interactions)   | CCSD(T)-F12/CBS                 | [smith2016],[burns2017]                                      |
| BDES       | 20_bdes/           |                                                           |                                 |                                                              |
| BH         | 20_bh/             |                                                           |                                 |                                                              |
| CT         | 20_ct/             |                                                           |                                 |                                                              |
| G3         | 20_g3/             |                                                           |                                 |                                                              |
| ACONF      | 20_gmtkn_aconf/    |                                                           |                                 |                                                              |
| ADIM6      | 20_gmtkn_adim6/    |                                                           |                                 |                                                              |
| AL2X       | 20_gmtkn_al2x/     |                                                           |                                 |                                                              |
| ALK6       | 20_gmtkn_alk6/     |                                                           |                                 |                                                              |
| BH76       | 20_gmtkn_bh76/     |                                                           |                                 |                                                              |
| BHPERI     | 20_gmtkn_bhperi/   |                                                           |                                 |                                                              |
| BSR36      | 20_gmtkn_bsr36/    |                                                           |                                 |                                                              |
| CYCONF     | 20_gmtkn_cyconf/   |                                                           |                                 |                                                              |
| DARC       | 20_gmtkn_darc/     |                                                           |                                 |                                                              |
| DC9        | 20_gmtkn_dc9/      |                                                           |                                 |                                                              |
| G21EA      | 20_gmtkn_g21ea/    |                                                           |                                 |                                                              |
| G21IP      | 20_gmtkn_g21ip/    |                                                           |                                 |                                                              |
| G2RC       | 20_gmtkn_g2rc/     |                                                           |                                 |                                                              |
| HEAVY28    | 20_gmtkn_heavy28/  |                                                           |                                 |                                                              |
| IDISP      | 20_gmtkn_idisp/    |                                                           |                                 |                                                              |
| ISO34      | 20_gmtkn_iso34/    |                                                           |                                 |                                                              |
| ISOL22     | 20_gmtkn_isol22/   |                                                           |                                 |                                                              |
| MB08-165   | 20_gmtkn_mb08-165/ |                                                           |                                 |                                                              |
| NBPRC      | 20_gmtkn_nbprc/    |                                                           |                                 |                                                              |
| O3ADD6     | 20_gmtkn_o3add6/   |                                                           |                                 |                                                              |
| PA         | 20_gmtkn_pa/       |                                                           |                                 |                                                              |
| PCONF      | 20_gmtkn_pconf/    |                                                           |                                 |                                                              |
| RG6        | 20_gmtkn_rg6/      |                                                           |                                 |                                                              |
| RSE43      | 20_gmtkn_rse43/    |                                                           |                                 |                                                              |
| S22        | 20_gmtkn_s22/      |                                                           |                                 |                                                              |
| SCONF      | 20_gmtkn_sconf/    |                                                           |                                 |                                                              |
| SIE11      | 20_gmtkn_sie11/    |                                                           |                                 |                                                              |
| W4-08      | 20_gmtkn_w4-08/    |                                                           |                                 |                                                              |
| WATER27    | 20_gmtkn_water27/  |                                                           |                                 |                                                              |
| HBC6       | 20_hbc6/           | Dissociation curves double-hydrogen-bonded dimers         | CCSD(T)/CBS                     | [thanthiriwatte2011][marshall2011b]                          |
| HSG        | 20_hsg/            |                                                           |                                 |                                                              |
| IONICHB    | 20_ionichb/        |                                                           |                                 |                                                              |
| ISOM       | 20_isom/           |                                                           |                                 |                                                              |
| KB49       | 20_kb49/           |                                                           |                                 |                                                              |
| KB65       | 20_kb65/           |                                                           |                                 |                                                              |
| L7         | 20_l7/             |                                                           |                                 |                                                              |
| MBCC-VIE   | 20_mbcc_vie/       |                                                           |                                 |                                                              |
| NBC10EXT   | 20_nbc10ext/       |                                                           |                                 |                                                              |
| P26        | 20_p26/            |                                                           |                                 |                                                              |
| PA26       | 20_pa26/           | Adiabatic proton affinities (small molecules)             | W1-F12, W2-F12, CCSD(T)/CBS     | [parthiban2001],[goerigk2017]                                |
| S12L       | 20_s12l/           | Dimer binding energies (large host-guest complexes)       | Back-corrected experimental/QMC | [grimme2012],[risthaus2013],[ambrosetti2015]                 |
| S22        | 20_s22/            | Dimer binding energies (small molecules)                  | CCSD(T)/CBS                     | [jurecka2006],[podeszwa2010],[marchetti2011],[marshall2011a] |
| S22x5      | 20_s22x5/          | S22 with varying intermolecular distances                 | CCSD(T)/CBS                     | [jurecka2006],[grafova2010]                                  |
| S22x7      | 20_s22x7/          | S22 with varying intermolecular distances                 | DW-CCSD(T**)-F12/CBS            | [jurecka2006],[grafova2010],[smith2016]                      |
| S30L       | 20_s30l/           | Dimer binding energies (large host-guest complexes)       | Back-corrected experimental     | [sure2015]                                                   |
| S66        | 20_s66/            | Dimer binding energies (small molecules)                  | CCSD(T)/CBS                     | [rezac2011],[dilabio2013]                                    |
| S66x8      | 20_s66x8/          | S66 with varying intermolecular distances                 | CCSD(F12*)(T)/CBS               | [rezac2011],[brauer2016]                                     |
| S66x10     | 20_s66x10/         | S66 with varying intermolecular distances                 | DW-CCSD(T**)-F12/CBS            | [rezac2011]                                                  |
| SSI        | 20_ssi/            | Dimer binding energies (sidechain-sidechain interactions) | CCSD(T)-F12/CBS                 | [smith2016],[burns2017]                                      |
| SULFURx8   | 20_sulfur_x8/      | Dimer binding energies (molecules with divalent S)        | CCSD(T)/CBS                     | [mintz2012]                                                  |
| TM         | 20_tm/             | Ligand-removal energies of transiton metal complexes      | Back-corrected experimental     | [johnson2009]                                                |
| W4-11      | 20_w4-11/          | Atomization energies (small molecules and radicals)       | W4                              | [karton2011]                                                 |
| WATER      | 20_water/          | Binding energies (water clusters)                         | CCSD(T)/CBS                     | [temelso2011]                                                |
| WATER25x10 | 20_water2510/      | Dimer binding energies (water dimer PES)                  | CCSD(T)/CBS                     | [mas2000][bukowski2007][bukowski2008][smith2016]             |
| X40        | 20_x40/            | Dimer binding energies (halogen-containing molecules)     | CCSD(T)/CBS                     | [rezac2012]                                                  |
| X40x10     | 20_x40x10/         | X40 with varying intermolecular distances                 | CCSD(T)/CBS                     | [rezac2012]                                                  |
| XB18       | 20_xb18/           | Dimer binding energies (halogen-bonded systems)           | CCSD(T)/CBS                     | [kozuch2013]                                                 |
| XB51       | 20_xb51/           | Dimer binding energies (halogen-bonded systems)           | CCSD(T)/CBS                     | [kozuch2013]                                                 |

[mas2000]: https://dx.doi.org/10.1063/1.1311289
[parthiban2001]: https://dx.doi.org/10.1063/1.1356014
[jurecka2006]: http://dx.doi.org/10.1039/B600027D
[bukowski2007]: http://dx.doi.org/10.1126/science.1136371
[bukowski2008]: https://dx.doi.org/10.1063/1.2832746
[johnson2009]: https://dx.doi.org/10.1139/V09-102
[goerigk2017]: https://dx.doi.org/10.1039/C7CP04913G
[grafova2010]: https://dx.doi.org/10.1021/ct1002253
[podeszwa2010]: http://dx.doi.org/10.1039/B926808A
[karton2011]: https://dx.doi.org/10.1016/j.cplett.2011.05.007
[marchetti2011]: http://dx.doi.org/10.1039/B804334E
[marshall2011a]: http://dx.doi.org/10.1063/1.3659142
[marshall2011b]: https://dx.doi.org/10.1063/1.3659142
[temelso2011]: https://dx.doi.org/10.1021/jp2069489
[thanthiriwatte2011]: https://dx.doi.org/10.1021/ct100469b
[rezac2011]: https://dx.doi.org/10.1021/ct2002946
[grimme2012]: https://dx.doi.org/10.1002/chem.201200497
[mintz2012]: https://dx.doi.org/10.1021/jp209536e
[rezac2012]: https://dx.doi.org/10.1021/ct300647k
[dilabio2013]: https://dx.doi.org/10.1039/C3CP51559A
[kozuch2013]: https://dx.doi.org/10.1021/ct301064t
[risthaus2013]: https://dx.doi.org/10.1021/ct301081n
[ambrosetti2015]: https://dx.doi.org/10.1021/jz402663k
[sure2015]: https://dx.doi.org/10.1021/acs.jctc.5b00296
[brauer2016]: http://dx.doi.org/10.1039/c6cp00688d
[smith2016]: http://dx.doi.org/10.1021/acs.jpclett.6b00780
[burns2017]: https://dx.doi.org/10.1063/1.5001028

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

