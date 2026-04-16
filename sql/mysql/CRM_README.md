# CRM 模块表结构说明

## 概述

本 SQL 脚本用于创建 CRM 模块（客户关系管理，Customer Relationship Management）所需的所有数据库表。

CRM 模块是用于管理客户、线索、联系人、商机、合同、回款等业务数据的核心模块。

## 包含的表

本脚本包含以下 19 张表：

### 客户相关（3 张表）
1. **`crm_customer`** - CRM 客户表
   - 存储客户的基本信息、联系方式、跟进状态等
   - 核心业务表

2. **`crm_customer_pool_config`** - 客户公海配置表
   - 配置客户公海规则，包括未跟进/未成交放入公海天数、提醒设置等

3. **`crm_customer_limit_config`** - 客户限制配置表
   - 配置客户数量限制规则，包括适用人群、部门、数量上限等

### 线索相关（1 张表）
4. **`crm_clue`** - CRM 线索表
   - 存储线索信息，可以转化为客户

### 联系人相关（2 张表）
5. **`crm_contact`** - CRM 联系人表
   - 存储联系人信息，关联客户
   - 支持树形结构（通过 `parent_id` 字段表示直属上级）

6. **`crm_contact_business`** - 联系人与商机关联表
   - 多对多关系表，关联联系人和商机
   - 包含唯一索引：`uk_contact_id_business_id`

### 商机相关（4 张表）
7. **`crm_business`** - CRM 商机表
   - 存储商机信息，关联客户
   - 包含商机金额、预计成交日期、状态等

8. **`crm_business_status`** - CRM 商机状态表
   - 配置表，存储商机状态信息
   - 包含赢单率、排序等

9. **`crm_business_status_type`** - CRM 商机状态组表
   - 配置表，存储商机状态组信息
   - 支持按部门配置不同的状态组

10. **`crm_business_product`** - CRM 商机产品关联表
    - 关联商机和产品，存储产品数量、价格等信息

### 合同相关（3 张表）
11. **`crm_contract`** - CRM 合同表
    - 存储合同信息，关联客户和商机
    - 包含合同金额、签约人、审批状态等
    - 支持工作流审批

12. **`crm_contract_product`** - CRM 合同产品关联表
    - 关联合同和产品，存储产品数量、价格等信息

13. **`crm_contract_config`** - 合同配置表
    - 配置合同相关设置，如提前提醒天数等

### 回款相关（2 张表）
14. **`crm_receivable`** - 回款表
    - 存储回款信息，关联客户和合同
    - 支持工作流审批

15. **`crm_receivable_plan`** - CRM 回款计划表
    - 存储回款计划信息，可以关联实际回款记录

### 产品相关（2 张表）
16. **`crm_product`** - CRM 产品表
    - 存储产品信息，包括名称、编码、价格、状态等

17. **`crm_product_category`** - 产品分类表
    - 存储产品分类信息，支持树形结构（最多 2 级）

### 其他（2 张表）
18. **`crm_follow_up_record`** - 跟进记录表
    - 存储客户、联系人等的跟进记录
    - 支持关联商机、联系人
    - 支持图片和附件

19. **`crm_permission`** - CRM 数据权限表
    - 存储数据权限信息，控制用户对 CRM 数据的访问权限
    - 包含唯一索引：`uk_biz_type_biz_id_user_id`

## 使用方法

### 方式一：使用 MySQL 命令行

```bash
mysql -u root -p your_database < ruoyi-vue-pro/sql/mysql/crm_tables.sql
```

### 方式二：使用数据库客户端工具

1. 打开 Navicat、DBeaver、DataGrip 等数据库客户端工具
2. 连接到目标数据库
3. 打开 `crm_tables.sql` 文件
4. 执行 SQL 脚本

### 方式三：在 MySQL 客户端中执行

```sql
source /path/to/ruoyi-vue-pro/sql/mysql/crm_tables.sql;
```

## 注意事项

1. **执行前备份**：执行 SQL 脚本前，请确保已备份数据库，以防数据丢失。

2. **表已存在**：如果表已存在，脚本会先删除旧表再创建新表（使用 `DROP TABLE IF EXISTS`）。如果表中有数据，请先备份。

3. **多租户支持**：所有表都包含 `tenant_id` 字段，支持多租户功能。

4. **索引**：脚本已为常用查询字段创建了索引，包括：
   - 外键字段索引（如 `customer_id`、`owner_user_id` 等）
   - 业务字段索引（如 `deal_time`、`return_time`、`contact_next_time` 等）
   - 唯一索引（如 `uk_contact_id_business_id`、`uk_biz_type_biz_id_user_id` 等）

5. **金额字段**：
   - 大部分金额字段使用 `decimal(20, 2)` 类型，单位：元
   - 注意：`crm_contract.total_price` 字段单位是分（根据注释）

6. **List 字段**：部分字段存储 List 类型数据（如 `user_ids`、`dept_ids`、`business_ids`、`contact_ids`、`pic_urls`、`file_urls` 等），这些字段使用 `varchar` 或 `text` 类型，通过 TypeHandler 处理。

7. **Boolean 字段**：使用 `bit(1)` 类型，`NULL` 表示未设置，`b'0'` 表示 false，`b'1'` 表示 true。

8. **时间字段**：使用 `datetime` 类型，支持 `NULL`。

## 验证

执行 SQL 脚本后，可以通过以下 SQL 验证表是否创建成功：

```sql
-- 检查 crm_ 开头的表
SHOW TABLES LIKE 'crm_%';

-- 查看表结构
DESC crm_customer;
DESC crm_business;
DESC crm_contract;
DESC crm_receivable;

-- 查看表的记录数（应该都是 0）
SELECT COUNT(*) FROM crm_customer;
SELECT COUNT(*) FROM crm_business;
SELECT COUNT(*) FROM crm_contract;
SELECT COUNT(*) FROM crm_receivable;
```

## 相关文档

- 芋道源码官网：https://www.iocoder.cn/

## 表结构说明

### 核心业务表

#### crm_customer 表

客户表是 CRM 模块的核心表，包含以下重要字段：
- `name`：客户名称
- `owner_user_id`：负责人的用户编号
- `follow_up_status`：跟进状态
- `contact_last_time`：最后跟进时间
- `contact_next_time`：下次联系时间
- `deal_status`：成交状态
- `lock_status`：锁定状态
- `mobile`、`telephone`、`email`、`qq`、`wechat`：联系方式
- `area_id`、`detail_address`：地址信息
- `industry_id`、`level`、`source`：行业、等级、来源（字典值）

#### crm_business 表

商机表包含以下重要字段：
- `name`：商机名称
- `customer_id`：客户编号
- `owner_user_id`：负责人用户编号
- `status_type_id`：商机状态组编号
- `status_id`：商机状态编号
- `end_status`：结束状态
- `deal_time`：预计成交日期
- `total_price`：商机总金额（单位：元）
- `total_product_price`：产品总金额（单位：元）
- `discount_percent`：整单折扣（百分比）

#### crm_contract 表

合同表包含以下重要字段：
- `name`：合同名称
- `no`：合同编号
- `customer_id`：客户编号
- `business_id`：商机编号（可选）
- `owner_user_id`：负责人用户编号
- `process_instance_id`：工作流编号
- `audit_status`：审批状态
- `order_date`：下单日期
- `start_time`、`end_time`：合同开始/结束时间
- `total_price`：合同总金额（单位：分）
- `sign_contact_id`：客户签约人
- `sign_user_id`：公司签约人

#### crm_receivable 表

回款表包含以下重要字段：
- `no`：回款编号
- `plan_id`：回款计划编号（可选）
- `customer_id`：客户编号
- `contract_id`：合同编号
- `owner_user_id`：负责人编号
- `return_time`：回款日期
- `return_type`：回款方式
- `price`：计划回款金额（单位：元）
- `process_instance_id`：工作流编号
- `audit_status`：审批状态

### 配置表

#### crm_customer_pool_config 表

客户公海配置表，用于配置客户公海规则：
- `enabled`：是否启用客户公海
- `contact_expire_days`：未跟进放入公海天数
- `deal_expire_days`：未成交放入公海天数
- `notify_enabled`：是否开启提前提醒
- `notify_days`：提前提醒天数

#### crm_business_status_type 和 crm_business_status 表

商机状态配置表：
- `crm_business_status_type`：状态组表，支持按部门配置不同的状态组
- `crm_business_status`：状态表，包含状态名、赢单率、排序等

#### crm_contract_config 表

合同配置表：
- `notify_enabled`：是否开启提前提醒
- `notify_days`：提前提醒天数

### 关联表

#### crm_contact_business 表

联系人与商机关联表，多对多关系：
- `contact_id`：联系人编号
- `business_id`：商机编号
- 包含唯一索引：`uk_contact_id_business_id`

#### crm_business_product 表

商机产品关联表：
- `business_id`：商机编号
- `product_id`：产品编号
- `product_price`：产品单价（单位：元）
- `business_price`：商机价格（单位：元）
- `count`：数量
- `total_price`：总计价格（单位：元）

#### crm_contract_product 表

合同产品关联表：
- `contract_id`：合同编号
- `product_id`：产品编号
- `product_price`：产品单价（单位：元）
- `contract_price`：合同价格（单位：元）
- `count`：数量
- `total_price`：总计价格（单位：元）

### 权限表

#### crm_permission 表

CRM 数据权限表，控制用户对 CRM 数据的访问权限：
- `biz_type`：数据类型（枚举值，如客户、商机、合同等）
- `biz_id`：数据编号
- `user_id`：用户编号
- `level`：权限级别（如只读、读写等）
- 包含唯一索引：`uk_biz_type_biz_id_user_id`

## 表关系说明

```
crm_customer (客户)
    ↓
crm_clue (线索) → 可转化为 → crm_customer
    ↓
crm_contact (联系人) → 关联 → crm_customer
    ↓
crm_business (商机) → 关联 → crm_customer
    ↓
crm_contract (合同) → 关联 → crm_customer, crm_business
    ↓
crm_receivable_plan (回款计划) → 关联 → crm_contract
    ↓
crm_receivable (回款) → 关联 → crm_receivable_plan, crm_contract

crm_product (产品)
    ↓
crm_business_product (商机产品关联) → 关联 → crm_business, crm_product
crm_contract_product (合同产品关联) → 关联 → crm_contract, crm_product

crm_follow_up_record (跟进记录) → 可关联 → crm_customer, crm_contact, crm_business
crm_permission (数据权限) → 控制 → 所有 CRM 数据
```

## 常见问题

### Q: 执行脚本后提示表已存在？
A: 脚本使用了 `DROP TABLE IF EXISTS`，会先删除旧表再创建。如果表中有重要数据，请先备份。

### Q: 如何添加测试数据？
A: 可以在执行脚本后，手动插入测试数据，或者使用系统提供的初始化脚本。

### Q: tenant_id 字段的作用？
A: `tenant_id` 用于多租户功能，不同租户的数据通过此字段隔离。默认值为 0。

### Q: List 字段如何存储？
A: List 字段使用 `varchar` 或 `text` 类型存储，通过 MyBatis Plus 的 TypeHandler（如 `LongListTypeHandler`、`StringListTypeHandler`）自动处理序列化和反序列化。

### Q: 金额字段的单位是什么？
A: 
- 大部分金额字段单位是**元**，使用 `decimal(20, 2)` 类型
- 注意：`crm_contract.total_price` 字段单位是**分**（根据注释）

### Q: 商机状态和状态组的关系？
A: 
- `crm_business_status_type` 是状态组表，一个状态组可以包含多个状态
- `crm_business_status` 是状态表，每个状态属于一个状态组（通过 `type_id` 关联）
- 商机（`crm_business`）通过 `status_type_id` 和 `status_id` 关联状态组和状态

### Q: 跟进记录表如何关联不同的业务对象？
A: 
- `crm_follow_up_record` 表通过 `biz_type` 和 `biz_id` 字段关联不同的业务对象
- `biz_type` 是枚举值，表示数据类型（如客户、联系人、商机等）
- `biz_id` 是对应业务对象的 ID

### Q: 数据权限表如何工作？
A: 
- `crm_permission` 表通过 `biz_type`、`biz_id`、`user_id` 和 `level` 字段控制用户对数据的访问权限
- 系统在查询数据时会根据权限表过滤数据，只返回用户有权限访问的数据

### Q: 客户公海是什么？
A: 客户公海是指没有负责人的客户池。当客户满足一定条件（如未跟进超过 X 天、未成交超过 X 天）时，会自动放入公海，其他销售人员可以从公海中领取客户。

### Q: 线索如何转化为客户？
A: 线索（`crm_clue`）可以通过转化操作转化为客户（`crm_customer`）。转化时，会更新线索的 `transform_status` 为 true，并设置 `customer_id` 字段。

## 数据初始化建议

执行 SQL 脚本后，建议初始化以下数据：

1. **产品分类数据**：在 `crm_product_category` 表中添加产品分类数据
2. **商机状态组和状态**：在 `crm_business_status_type` 和 `crm_business_status` 表中添加商机状态配置
3. **客户公海配置**：在 `crm_customer_pool_config` 表中配置客户公海规则
4. **合同配置**：在 `crm_contract_config` 表中配置合同相关设置
5. **客户限制配置**：在 `crm_customer_limit_config` 表中配置客户数量限制规则

## 性能优化建议

1. **索引优化**：脚本已创建常用查询字段的索引，如需优化，可以根据实际查询场景添加复合索引。

2. **数据归档**：对于历史数据（如已完成的合同、回款等），建议定期归档到历史表，避免主表数据过多。

3. **分表策略**：对于数据量特别大的表（如 `crm_follow_up_record`），可以考虑按时间分表。

4. **读写分离**：对于高并发场景，建议使用读写分离，将统计查询等读操作分流到从库。

5. **缓存策略**：对于配置表（如 `crm_business_status_type`、`crm_business_status`、`crm_product_category` 等），建议使用缓存，减少数据库查询。

