#!/bin/bash
# Convert a bare XYZ file (no header - like generated with jkp_extract_geom_awk
# from a Gaussian optimisation) to ZagHop geom and veloc files.
# Usage: bash xyz2zaghop.sh mol.xyz
# Produces: geom and veloc in current directory.

XYZ="${1:?Usage: xyz2zaghop.sh <file.xyz>}"

echo "“As a matter of fact, it hasn’t been debugged yet,” --- Brothers Strugatsky"

awk '
BEGIN {
    # atomic masses (Da)
    m["H"]=1.008; 
    m["C"]=12.011; 
    m["N"]=14.007; 
    m["O"]=15.999; 
    m["S"]=32.060; 
    m["P"]=30.974; 
    m["F"]=18.998;
    m["Cl"]=35.450; 
    m["Br"]=79.904;
    m["Se"]=78.971; 
    m["I"]=126.904;
    
    A2B = 1.8897259886  # angstrom to bohr
}
NF==4 {
    printf "%-2s  %7.3f  %14.8f  %14.8f  %14.8f  q\n", \
        $1, m[$1], $2*A2B, $3*A2B, $4*A2B
}
' "$XYZ" > geom

# zero velocities; use Maxwell-Boltzmann distribution built into Zaghop
# `velocity mb 300.0`
awk 'NF==4 { print "  0.000000  0.000000  0.000000" }' "$XYZ" > veloc

echo "Wrote geom ($(wc -l < geom) atoms) and veloc"

echo "I hope you know what you are doing..."

