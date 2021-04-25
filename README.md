# ASL (Ant Script Library)

基于Ant进行包装，开发一套可以复用的构建脚本。

# 测试命令

```bash
export WORKSPACE=$(pwd);./tools/ant/bin/ant -f run.xml -Dasl.task.id=sample -Dasl.log.level=debug -Dasl.log.locale=zh
```
