# ASL (Ant Script Library)

基于Ant进行包装，开发一套可以复用的构建脚本。

# 测试命令

```bash
./run.sh task sample -Darg1=world
```

命令说明：
sample是一个task模块，可以实现各种功能的task，比如maven, gradle, pkg, archive, ansible等

# 使用方式

日常构建发布可以使用这个库，比如要完成代码的编译，打包，归档，和部署

```bash

./run.sh task maven -Droot.pom=pom.xml -Dgoals='clean package' -Doptions='-Dmaven.test.skip=true' -Dsettings.id=ci -Dmaven.repo.local=/home/jenkins/.mvnrepo

./run.sh task package -Dapp.id=hello -Dapp.version=${PIPELINE_VERSION} -Dfileset.dir=${WORKSPACE}/dist -Dfileset.include='**/*'

./run.sh task archive -Dapp.env=${PIPELINE_ENV} -Dgroup.id=${APP_GROUP} -Dapp.id=hello -Dapp.version=${PIPELINE_VERSION} -Darchive.provider=minio -Dminio.xxxx=xxx

./run.sh task ansible -Dansible.user=${ANSIBLE_SSH_USER} -Dansible.keyfile=${ANSIBLE_SSH_KEYFILE} -Dinventory.hosts='ip,' -Dansible.options='-v -C' -Dplaybook.file=deploy.yml

```

# 通过yaml描述流水线方式执行

```bash
./run.sh pipeline ant.yml -Ddebug=true
```


#如何创建一个task

```bash
./run.sh task gentask -Dws.dir=tmp -Dout.task.name=hello
```

