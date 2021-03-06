#!/bin/csh -f
setenv CCSMROOT /glade/p/cesm/cseg/collections/cesm1_2_0
setenv GSCRATCH /glade/scratch/huyong

setenv MYRUNS $GSCRATCH

setenv CASE1 $MYRUNS/perturb.g40.T.year

cd $CCSMROOT/scripts
./create_newcase -mach yellowstone -res ne30_g16_rx1 -compset G_NORMAL_YEAR -case $CASE1
cd $CASE1
source $CASE1/Tools/ccsm_getenv

#cp ~/TEMPLATE/models/atm/datm/bld/namelist_files/namelist_defaults_datm.xml $CODEROOT/atm/datm/bld/namelist_files/

./xmlchange -file env_mach_pes.xml -id NTASKS_ATM -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_LND -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_ICE -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_OCN -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_CPL -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_GLC -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_ROF -val 96 
./xmlchange -file env_mach_pes.xml -id NTASKS_WAV -val 96 

./xmlchange -file env_mach_pes.xml -id NTHRDS_ATM -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_LND -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_ICE -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_OCN -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_CPL -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_GLC -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_ROF -val 1
./xmlchange -file env_mach_pes.xml -id NTHRDS_WAV -val 1

./xmlchange -file env_run.xml -id RUN_TYPE -val hybrid
./xmlchange -file env_run.xml -id RUN_REFCASE -val g.e12.G.T62_g16.001
./xmlchange -file env_run.xml -id RUN_REFDATE -val 1001-01-01


./xmlchange -file env_run.xml -id STOP_OPTION -val nyears
./xmlchange -file env_run.xml -id STOP_N -val 1

./cesm_setup
cp ~/CHANGES/Perturbation_T/* $CASE1/SourceMods/src.pop2/

echo "init_ts_perturb = 1.0e-$pert"   >> user_nl_pop2
./preview_namelists

$CASE1/*.build 

#CHECK IF THE LOG FILE EXISTS
#ls $LOGDIR
cp ~/1001-01-01-00000/* $CASE1/run

#CHECK RUN
sed -i "s/ 4:00/ 6:00/g" $CASE1/*.run
#sed -i "s/ regular/ premium/g" $CASE1/*.run
sed -i "s/ P00000000/ P93300612/g" $CASE1/*.run
sed -i "s/ptile=15/ptile=16/g" $CASE1/*.run
bsub < $CASE1/*.run

