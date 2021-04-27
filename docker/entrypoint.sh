#! /bin/sh

for K in $(env | cut -d= -f1)
do
    VAL=$(eval echo \$$K)
    echo "${K}=\"${VAL}\"" >> /etc/envvars
done

if [ $# -eq 0 ]; then
    exec /usr/bin/runsvinit
fi

[ "$1" == '--' ] && shift
exec $@

    
