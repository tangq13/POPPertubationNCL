#!/bin/bash

usage() {
  echo 'USAGE: validation_test.sh -pop_out pop_OUTPUT_FILE -ensemble ENSEMBLE_FILE [-verbose]'
  echo ''
  echo 'Required flags:'
  echo '-pop_out     Location of the pop history file output by ensemble.sh'
  echo '-ensemble    Location of the ensemble file to compare the single run to'
  echo ''
  echo 'Optional flag:'
  echo '-verbose     Output RMSZ score for all variables, not just those that exceed maximum from ensemble'
}

while [ $# -gt 0 ]; do
  case $1 in
    -pop_out )
      pop_OUT=$2
      shift
      if [ ! -e $pop_OUT ]; then
        echo "ERROR: pop output file not found."
        exit 1
      fi
    ;;
    -ensemble )
      ENS_FILE=$2
      shift
      if [ ! -e $ENS_FILE ]; then
        echo "ERROR: ensemble file not found."
        exit 1
      fi
    ;;
    -month | -monthly )
      MONTHLY='monthly=True'
    ;;
    -verbose )
      VERBOSE='verbose=True'
    ;;
    -h )
      usage
      exit 0
    ;;
    * )
      echo "ERROR: invalid argument $1"
      echo ''
      usage
      exit 1
    ;;
  esac
  shift
done

if [ -z "$pop_OUT" ]; then
  echo "ERROR: You must specify a pop history file!"
  echo ''
  usage
  exit 1
fi

if [ -z "$ENS_FILE" ]; then
  echo "ERROR: You must specify an ensemble file!"
  echo ''
  usage
  exit 1
fi

ThisDir=$( cd `dirname $0`; pwd )
### This is for global case and opeansea
NCLSCRIPT=${ThisDir}/test_run_against_ensemble.ncl

### This is for  regional and seas cases
#NCLSCRIPT=${ThisDir}/test_run_against_ensemble_region.ncl

echo $NCLSCRIPT
if [ ! -e $NCLSCRIPT ]; then
  echo "ERROR: can not find test_run_against_ensemble.ncl file!"
  exit 1
fi

export NCL_VALID_LIB_DIR=$PWD/ncl_library
ncl $NCLSCRIPT run_file=\"${pop_OUT}\" ens_file=\"${ENS_FILE}\" $MONTHLY $VERBOSE
