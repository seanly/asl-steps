# docker download
https://download.docker.com/linux/static/stable/x86_64/

# dockerd 启动方式

后台启动
```bash
dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --iptables=false --ip-masq=false > /dev/null 2>&1 &
```

