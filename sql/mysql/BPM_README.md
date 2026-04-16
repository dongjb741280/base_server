# BPM 工作流模块表结构导入说明

## 问题说明

如果遇到以下错误：
```
[工作流模块 yudao-module-bpm - 表结构未导入][参考 https://cloud.iocoder.cn/bpm/ 开启]
```

这表示数据库中缺少 BPM 模块的表结构。

## 解决方案

### 1. 执行 SQL 脚本

在数据库中执行 `bpm_tables.sql` 文件：

```bash
# MySQL 命令行方式
mysql -u root -p your_database < sql/mysql/bpm_tables.sql

# 或者使用数据库客户端工具（如 Navicat、DBeaver 等）直接执行 SQL 文件
```

### 2. 需要创建的表

BPM 模块包含以下业务表：

- `bpm_category` - 流程分类表
- `bpm_form` - 流程表单表
- `bpm_user_group` - 用户组表
- `bpm_process_definition_info` - 流程定义信息表
- `bpm_process_expression` - 流程表达式表
- `bpm_process_listener` - 流程监听器表
- `bpm_process_instance_copy` - 流程实例抄送表
- `bpm_oa_leave` - OA 请假申请表

### 3. Flowable 引擎表

**注意**：除了上述业务表，BPM 模块还依赖 Flowable 工作流引擎的表。

Flowable 的表会在应用启动时自动创建（如果配置了 `flowable.database-schema-update: true`）。

如果 Flowable 表未自动创建，可以参考：
- Flowable 官方 SQL 脚本：https://github.com/flowable/flowable-sql
- 或者将配置改为 `flowable.database-schema-update: true` 让系统自动创建

### 4. 验证

执行完 SQL 脚本后，重启应用，错误应该消失。

如果仍有问题，请检查：
1. 数据库连接配置是否正确
2. 是否有执行权限
3. 表是否成功创建（可以通过 `SHOW TABLES LIKE 'bpm_%';` 查看）

## 参考文档

- BPM 模块文档：https://cloud.iocoder.cn/bpm/
- Flowable 官方文档：https://www.flowable.com/open-source/docs/

