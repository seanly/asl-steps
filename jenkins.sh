#!/bin/bash

build() {
  echo "--//INFO: build...."
}

function test() {
  echo "--//INFO: test...."
  if [ -f /etc/redhat-release ]; then
    cat /etc/redhat-release
  fi
  echo 'hi, docker'
}

function package() {
  echo "--// package ...."
  git archive --format tar.gz --output "./ant-asl.tar.gz" master
}

if [ "$#" == 0 ]; then
  echo "--//ERR: please set function name"
  exit 2
fi


# ---不可变部分----
fname=`declare -f -F $1`
if [ -n "$fname" ]; then
  $@
else 
  echo 1
fi

status=$?

# **注意** 修改工作空间权限，避免Jenkins任务权限问题
if [[ -n "$DAPPER_UID" && -n "$DAPPER_GID" ]]; then
  chown -R $DAPPER_UID:$DAPPER_GID .
fi

exit $status

