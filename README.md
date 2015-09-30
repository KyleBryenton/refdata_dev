=== Refdata ===

This repository provides a collection of benchmark databases for
quantum mechanical methods. The bulk of the repository are the 20_xx
directories, which contain the structures for several popular
benchmark sets for which highly accurate reference data are known. The
structures are provided in xyz, Gaussian input format (gjf), and,
occasionally, in nwchem input format (nw). I'll go adding more formats
as I need them.

The reference energies for these sets are in the 10_din directory, in
din format, along with the literature source for the data. The
05_conversion directory contains bits and pieces that I used to
convert the reference data from the source's format.

The 40_xx directories contain octave scripts to manipulate the din and
the structures, and to perform and evaluate the benchmark
calculations. 40_eval reads the calculations for a given set from an
arbitrary directory and compares the results to the reference
data. 

40_fit contains routines for running XDM parametrizations. The
xdm.param is the master list of XDM parameters.

