#!/bin/bash

if [ -f /etc/redhat-release ]; then
  cat /etc/redhat-release
fi

echo 'hi, docker'
