# 插件名称 

archive

# 功能说明

用于将构建产物归档到云存储中

# 参数说明

| 参数名称 | 类型 | 默认值 | 是否必须 | 含义 |
|---|---|---|---|---|
| provider | string | qcloud | **必须** | aliyun/minio, 对象存储服务 |
| lane | string | jenkins | **必须** | 存储分区，分区规范样例比如： dev/test/qa/prod等 |
| group.id | string | 空 | **必须** | 用于创建归档目录 |
| artifact.id | string | 空 | **必须** | 用于创建归档项目目录 |
| artifact.version | string | 空 | **必须** | 归档版本，如果为空也就是默认值，那么会通过scm.type自动生成 |
| fileset.dir | string | 空 | **必须** | 需要归档的文件目录 |
| fileset.includes | string | 空 | **必须** | 需要归档的文件目录下需要包含的文件模式 |
| fileset.exclude| string | 空 | **必须** | 需要归档的文件目录下需要排除的文件，也就是不需要归档的文件模式 |

# 配置使用样例

```yml
stages:
- name: archive
  tasks:
    - task.id: archive
      lane: 'qa'
      artifact.version: $PIPELINE_VERSION
      fileset.dir: 'resdl'
      fileset.includes: '*.tar.gz,*.md5'
```
