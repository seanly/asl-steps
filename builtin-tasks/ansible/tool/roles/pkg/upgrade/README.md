# App Upgrade
服务升级角色

# 服务管理方式
## 服务停止和启动（Stop/Start）

-e servic_manager=service -e service_name=xxx

**Notice**

service_manager可能的值是service/systemd/supervisor

## 重载服务(Reload)模式

-e servic_manager=service -e service_name=xxx -e service_state=reloaded

## 无服务(No Service)模式

-e servic_manager=

## Storm 服务模式

-e service_manager=storm -e storm_home=/data/storm \
-e service_name=xxx -e storm_topology_class=com.xxxxx.MainTopology

