# 会员模块表结构说明

## 概述

本 SQL 脚本用于创建会员模块（`yudao-module-member`）所需的所有数据库表。

## 包含的表

本脚本包含以下 11 张表：

### 核心表
1. **`member_user`** - 会员用户表
   - 存储会员的基本信息、账号信息、积分、经验等
   - 包含唯一索引：`uk_mobile`（手机号）

2. **`member_level`** - 会员等级表
   - 配置会员等级信息，包括等级名称、升级经验、折扣等

3. **`member_group`** - 用户分组表
   - 用于对会员进行分组管理

4. **`member_tag`** - 会员标签表
   - 用于给会员打标签

5. **`member_address`** - 用户收件地址表
   - 存储会员的收货地址信息

### 配置表
6. **`member_config`** - 会员配置表
   - 存储会员相关的系统配置，如积分抵扣规则等

### 记录表
7. **`member_point_record`** - 用户积分记录表
   - 记录会员积分的变动历史

8. **`member_level_record`** - 会员等级记录表
   - 记录会员等级变更历史

9. **`member_experience_record`** - 会员经验记录表
   - 记录会员经验变动历史

10. **`member_sign_in_config`** - 签到规则表
    - 配置签到奖励规则

11. **`member_sign_in_record`** - 签到记录表
    - 记录会员签到历史

## 使用方法

### 方式一：使用 MySQL 命令行

```bash
mysql -u root -p your_database < ruoyi-vue-pro/sql/mysql/member_tables.sql
```

### 方式二：使用数据库客户端工具

1. 打开 Navicat、DBeaver、DataGrip 等数据库客户端工具
2. 连接到目标数据库
3. 打开 `member_tables.sql` 文件
4. 执行 SQL 脚本

### 方式三：在 MySQL 客户端中执行

```sql
source /path/to/ruoyi-vue-pro/sql/mysql/member_tables.sql;
```

## 注意事项

1. **执行前备份**：执行 SQL 脚本前，请确保已备份数据库，以防数据丢失。

2. **表已存在**：如果表已存在，脚本会先删除旧表再创建新表（使用 `DROP TABLE IF EXISTS`）。如果表中有数据，请先备份。

3. **多租户支持**：所有表都包含 `tenant_id` 字段，支持多租户功能。

4. **索引**：脚本已为常用查询字段创建了索引，包括：
   - `member_user` 表的 `uk_mobile`（手机号唯一索引）
   - `member_user` 表的 `idx_level_id`、`idx_group_id`
   - `member_point_record` 表的 `idx_user_id`、`idx_biz_id`、`idx_biz_type`
   - 其他表的常用查询字段索引

## 验证

执行 SQL 脚本后，可以通过以下 SQL 验证表是否创建成功：

```sql
-- 检查 member_ 开头的表
SHOW TABLES LIKE 'member_%';

-- 查看表结构
DESC member_user;
DESC member_level;
-- ... 其他表

-- 查看表的记录数（应该都是 0）
SELECT COUNT(*) FROM member_user;
SELECT COUNT(*) FROM member_level;
-- ... 其他表
```

## 相关文档

- 会员模块文档：https://cloud.iocoder.cn/member/
- 芋道源码官网：https://www.iocoder.cn/

## 表结构说明

### member_user 表

会员用户表是核心表，包含以下重要字段：
- `mobile`：手机号（唯一）
- `password`：加密后的密码
- `point`：积分
- `experience`：经验
- `level_id`：会员等级编号
- `group_id`：用户分组编号
- `tag_ids`：会员标签列表（以逗号分隔）

### member_level 表

会员等级表配置了会员等级信息：
- `level`：等级数值
- `experience`：升级所需经验
- `discount_percent`：享受折扣百分比

### 记录表

所有记录表都包含以下字段用于追踪：
- `user_id`：用户编号
- `biz_type`：业务类型
- `biz_id`：业务编号
- `title`：标题
- `description`：描述

## 常见问题

### Q: 执行脚本后提示表已存在？
A: 脚本使用了 `DROP TABLE IF EXISTS`，会先删除旧表再创建。如果表中有重要数据，请先备份。

### Q: 如何添加测试数据？
A: 可以在执行脚本后，手动插入测试数据，或者使用系统提供的初始化脚本。

### Q: tenant_id 字段的作用？
A: `tenant_id` 用于多租户功能，不同租户的数据通过此字段隔离。默认值为 0。

