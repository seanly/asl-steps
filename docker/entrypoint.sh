#! /bin/sh

for K in $(env | cut -d= -f1)
do
    VAL=$(eval echo \$$K)
    echo "${K}=\"${VAL}\"" >> /etc/envvars
done

function start_dockerd() {
  dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --iptables=false --ip-masq=false > /dev/null 2>&1 &
}

if [ $# -eq 0 ]; then
    exec /usr/bin/runsvinit
fi

[ "$1" == '--' ] && shift
start_dockerd
exec $@

    
