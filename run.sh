#!/bin/bash

#set -eux

ASL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ANT_HOME=${ASL_DIR}/tools/ant
_ANT_EXEC=${ANT_HOME}/bin/ant

RUN_BUILDFILE=${ASL_DIR}/run.xml

step() {

  if [ -n "$1" ]; then
    TASK=$1
    shift
  else
    echo "--//INFO: please set step.name"
    exit -1
  fi

  exec ${_ANT_EXEC} -f ${RUN_BUILDFILE} step \
    -logger cn.k8ops.ant.asl.AslLogger \
    -Dstep.id=${TASK} $@
}

pipeline() {
  if [ -n "$1" ]; then
    PIPELINE_FILE=$1
    if [ ! -f "${PIPELINE_FILE}" ]; then
      echo "--//INFO: please check pipeline.file"
      exit -1
    fi
    shift
  else
    echo "--//INFO: please set pipeline.file"
    exit -1
  fi

  exec ${_ANT_EXEC} -f ${RUN_BUILDFILE} pipeline \
    -logger cn.k8ops.ant.asl.AslLogger \
    -Dpipeline.file=$PIPELINE_FILE $@
}

# ---不可变部分----
fname=`declare -f -F $1`
if [ -n "$fname" ]; then
  $@
else 
  echo "--//ERR: func $1 is not exists."
fi

status=$?

# **注意** 修改工作空间权限，避免Jenkins任务权限问题
if [[ -n "$DAPPER_UID" && -n "$DAPPER_GID" ]]; then
  chown -R $DAPPER_UID:$DAPPER_GID .
fi

exit $status

