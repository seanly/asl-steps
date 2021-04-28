#!/bin/bash

#set -eux
set -eu

WORKSPACE=$(pwd)
echo "--//INFO: ws.dir: ${WORKSPACE}"

ASL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ANT_HOME=${ASL_DIR}/tools/ant
_ANT_EXEC=${ANT_HOME}/bin/ant

TASKS_DIRS=${ASL_DIR}/tasks

if [ -n "$1" ]; then
  TASK=$1
  if [ ! -d "${TASKS_DIRS}/${TASK}" ]; then
    echo "--//INFO: please check task.name"
    exit -1
  fi
  shift
else
  echo "--//INFO: please set task.name"
  exit -1
fi

RUN_BUILDFILE=${ASL_DIR}/run.xml
exec ${_ANT_EXEC} -f ${RUN_BUILDFILE} -logger org.apache.tools.ant.NoBannerLogger -Dasl.task.id=${TASK} $@
