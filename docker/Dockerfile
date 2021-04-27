# vim: set ft=dockerfile:
ARG CR_URL=registry.cn-hangzhou.aliyuncs.com
FROM $CR_URL/k8ops/pkg-runsvinit:0.1 as runsvinit

ARG CR_URL=registry.cn-hangzhou.aliyuncs.com
FROM $CR_URL/k8ops/pkg-docker:19.03.8 as docker

RUN set -eux;\
  mkdir -p /docker \
  && tar --extract --file /docker.tgz --strip-components 1 --directory /docker

FROM $CR_URL/k8ops-base/centos:7-v2

MAINTAINER seanly <seanly@aliyun.com>
LABEL name="jenkins slave jnlp-dind" \
  vender="k8ops"

COPY --from=runsvinit /usr/bin/runsvinit /usr/bin/runsvinit
COPY --from=docker /docker/ /usr/sbin/

COPY ./rootfs /

ENV DOCKER_CLI_EXPERIMENTAL=enabled

RUN set -eux \
  && install_packages btrfs-progs e2fsprogs e2fsprogs-extra iptables xfsprogs xz pigz git subversion rsync bzip2 sudo \
  && tar --extract --file /opt/runit-2.1.2-1.tar.gz --strip-components 1 --directory /usr/sbin/; \
    dockerd -v; docker -v; rm -rf /opt/docker.tgz /opt/runit-2.1.2-1.tar.gz \
  && groupadd -r dockremap \
  && useradd -r -g dockremap dockremap \
  && echo 'dockremap:165536:65536' >> /etc/subuid \
  && echo 'dockremap:165536:65536' >> /etc/subgid \
  && groupadd -r docker \
  && useradd -r -g docker docker

VOLUME /var/lib/docker
EXPOSE 2375

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

