# 结构说明

| 目录       | 说明                                               |
| :--------- | -------------------------------------------------- |
| inventory/ | 用于记录团队应用的主机列表                         |
| site.yml   | 更新/回滚统一入口                                  |
| vars/      | 每个团队应用的配置文件、定制执行任务和相关基础变量 |

# 部署命令

```bash
ansible-playbook site.yml -i inventory/test/hosts.ini -l php --key-file=~/.ssh/sshkey/jenkins  --user=root -e team_id=test -e app_name=test -e artifact_version=xxx -e osspkg_access_key=osspkg -e osspkg_secret_key=osspkg123    -t upgrade -v
```

说明

| 参数                                   | 说明                                |
| :------------------------------------- | :---------------------------------- |
| -i inventory/test/hosts.ini            | 服务部署的机器列表                  |
| -l php                                 | 限制当前部署机器列表                |
| --key-file and --user                  | 部署用户和认证key                   |
| -e team_id/app_name/artifact_version   | 部署相关扩展信息                    |
| -e osspkg_access_key/osspkg_secret_key | 归档下载需要的key信息               |
| -t upgrade/rollback                    | 部署动作，升级还是回滚（通过tag来） |

# 全局配置

| 变量            | 默认值                       | 说明                             |
| --------------- | ---------------------------- | -------------------------------- |
| alioss_endpoint | oss-cn-hangzhou.aliyuncs.com | 阿里对象存储地址                 |
| alioss_bucket   | jenkinspkg                | 对象存储桶名称（构建归档的位置） |
| artifact_lane   | tag                          | 归档分区                         |

 # 应用配置

| 变量            | 说明                                       |
| --------------- | ------------------------------------------ |
| group_id        | 归档组id                                   |
| artifact_id     | 归档包id                                   |
| run_as_user     | 运行用户                                   |
| install_dir     | 服务安装路径                               |
| service_name    | 服务名称                                   |
| service_manager | 服务管理工具名称supervisor/systemd/service |


# bastion config

```
deploy:
  envvars:
    PROXY_OPTS: --ssh-extra-args='-F /tmp/ssh.config'
  steps:
  - ansible-deploy:
      docker.run.img: k8ops-build/tool-ansible:2.5
      docker.run.options: >-
        -v ${CIMC_SSHCONFIG}:/tmp/cimc.config
        -v ${CIMC_NODE_SSH_KEYFILE}:/tmp/node.pem
      inventory: 127.0.0.1,
      playbook: ci.yml
      options: >-
        ${PROXY_OPTS}
        -e artifact_lane=${APP_ENV}
        -e group_id=${APP_GROUP}
        -e artifact_id=${APP_NAME}
        -e artifact_version=${APP_VERSION}
        -e app_name=${APP_NAME}
        -e run_as_user=${APP_RUN_AS_USER}
        -e app_install_dir=${APP_INSTALL_DIR}
        -e service_name=${APP_NAME}
        ${PUBLISH_OPTIONS}
        -t upgrade

      

```
