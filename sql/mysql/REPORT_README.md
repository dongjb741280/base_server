# 报表模块表结构导入说明

## 问题说明

如果遇到以下错误：
```
[报表模块 yudao-module-report - 表结构未导入][参考 https://cloud.iocoder.cn/report/ 开启]
```

这表示数据库中缺少报表模块的表结构。

## 解决方案

### 1. 执行 SQL 脚本

在数据库中执行 `report_tables.sql` 文件：

```bash
# MySQL 命令行方式
mysql -u root -p your_database < sql/mysql/report_tables.sql

# 或者使用数据库客户端工具（如 Navicat、DBeaver 等）直接执行 SQL 文件
```

### 2. 需要创建的表

报表模块包含以下业务表：

#### GoView 相关表
- `report_go_view_project` - GoView 项目表（用于大屏报表）

#### JimuReport（积木报表）相关表
- `jimu_report_category` - 积木报表分类表
- `jimu_report` - 积木报表主表
- `jimu_report_data_source` - 积木报表数据源表
- `jimu_dict` - 积木报表字典表
- `onl_drag_page` - 在线拖拽页面表（用于大屏设计）

### 3. 多租户支持

表已包含 `tenant_id` 字段，支持多租户功能。

### 4. 验证

执行完 SQL 脚本后，重启应用，错误应该消失。

如果仍有问题，请检查：
1. 数据库连接配置是否正确
2. 是否有执行权限
3. 表是否成功创建（可以通过 `SHOW TABLES LIKE 'report_%';` 查看）

## 参考文档

- 报表模块文档：https://cloud.iocoder.cn/report/
- GoView 官方文档：https://www.mtruning.com/guide/

