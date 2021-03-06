#!/bin/csh -f
setenv CCSMROOT /glade/p/work/huyong/cesm1_2_2
setenv MYRUNS /glade/scratch/huyong


foreach cores ( 48 192 384 )
  setenv CASE1 $MYRUNS/gT62.g16.core$cores

  #cd $CCSMROOT/scripts
  #./create_newcase -mach yellowstone -res ne30_g16_rx1 -compset G_NORMAL_YEAR -case $CASE1
  cd $CASE1
  #source $CASE1/Tools/ccsm_getenv


  ##cp ~/TEMPLATE/models/atm/datm/bld/namelist_files/namelist_defaults_datm.xml $CODEROOT/atm/datm/bld/namelist_files/

  #./xmlchange -file env_mach_pes.xml -id NTASKS_ATM -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_LND -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_ICE -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_OCN -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_CPL -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_GLC -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_ROF -val $cores 
  #./xmlchange -file env_mach_pes.xml -id NTASKS_WAV -val $cores 

  #./xmlchange -file env_mach_pes.xml -id NTHRDS_ATM -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_LND -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_ICE -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_OCN -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_CPL -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_GLC -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_ROF -val 1
  #./xmlchange -file env_mach_pes.xml -id NTHRDS_WAV -val 1

  #./xmlchange -file env_run.xml -id RUN_TYPE -val hybrid
  #./xmlchange -file env_run.xml -id RUN_REFCASE -val g.e12.G.T62_g16.001
  #./xmlchange -file env_run.xml -id RUN_REFDATE -val 1001-01-01


  #./xmlchange -file env_run.xml -id STOP_OPTION -val nyears
  #./xmlchange -file env_run.xml -id STOP_N -val 3

  #./cesm_setup
  #cp ~/POPPertubationNCL/CHANGES/PertT_cesm1.2.2/* $CASE1/SourceMods/src.pop2/

  #echo "init_ts_perturb = 0.0"   >> user_nl_pop2

  #./preview_namelists

  #$CASE1/*.build 

  ##CHECK IF THE LOG FILE EXISTS
  ##ls $LOGDIR
  #cp $WORK/1001-01-01-00000/* $CASE1/run

  ##CHECK RUN
  #sed -i "s/ 4:00/ 6:00/g" $CASE1/*.run
  ##sed -i "s/ regular/ premium/g" $CASE1/*.run
  #sed -i "s/ P00000000/ P93300612/g" $CASE1/*.run
  #sed -i "s/ptile=15/ptile=16/g" $CASE1/*.run

  ./*.submit
end 
