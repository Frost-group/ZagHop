rm -r qm
mkdir qm
cp -a qm.inp mol.xyz qm/

ORCA_ROOT="/usr/local/bin/orca_6_1_1_linux_x86-64_shared_openmpi418/" ../../build/bin/zaghop ./example_dynamics.in
