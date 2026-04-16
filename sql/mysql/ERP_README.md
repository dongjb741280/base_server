# ERP 模块表结构说明

## 概述

本 SQL 脚本用于创建 ERP 模块（企业资源管理，Enterprise Resource Planning）所需的所有数据库表。

ERP 模块是用于管理企业采购、销售、库存、财务、产品等业务数据的核心模块。

## 包含的表

本脚本包含以下 33 张表：

### 产品相关（3 张表）
1. **`erp_product`** - ERP 产品表
   - 存储产品的基本信息，包括名称、条码、分类、单位、价格等
   - 核心业务表

2. **`erp_product_category`** - ERP 产品分类表
   - 存储产品分类信息，支持树形结构

3. **`erp_product_unit`** - ERP 产品单位表
   - 存储产品单位信息，如个、箱、件等

### 销售相关（7 张表）
4. **`erp_customer`** - ERP 客户表
   - 存储客户的基本信息，包括联系方式、税务信息、银行信息等

5. **`erp_sale_order`** - ERP 销售订单表
   - 存储销售订单信息，包括客户、金额、状态等
   - 包含唯一索引：`uk_no`（销售订单号）

6. **`erp_sale_order_items`** - ERP 销售订单项表
   - 存储销售订单的明细项，包括产品、数量、价格等

7. **`erp_sale_out`** - ERP 销售出库表
   - 存储销售出库单信息，关联销售订单
   - 包含唯一索引：`uk_no`（销售出库单号）

8. **`erp_sale_out_items`** - ERP 销售出库项表
   - 存储销售出库单的明细项

9. **`erp_sale_return`** - ERP 销售退货表
   - 存储销售退货单信息，关联销售订单
   - 包含唯一索引：`uk_no`（销售退货单号）

10. **`erp_sale_return_items`** - ERP 销售退货项表
    - 存储销售退货单的明细项

### 采购相关（7 张表）
11. **`erp_supplier`** - ERP 供应商表
    - 存储供应商的基本信息，包括联系方式、税务信息、银行信息等

12. **`erp_purchase_order`** - ERP 采购订单表
    - 存储采购订单信息，包括供应商、金额、状态等
    - 包含唯一索引：`uk_no`（采购订单号）

13. **`erp_purchase_order_items`** - ERP 采购订单项表
    - 存储采购订单的明细项，包括产品、数量、价格等

14. **`erp_purchase_in`** - ERP 采购入库表
    - 存储采购入库单信息，关联采购订单
    - 包含唯一索引：`uk_no`（采购入库单号）

15. **`erp_purchase_in_items`** - ERP 采购入库项表
    - 存储采购入库单的明细项

16. **`erp_purchase_return`** - ERP 采购退货表
    - 存储采购退货单信息，关联采购订单
    - 包含唯一索引：`uk_no`（采购退货单号）

17. **`erp_purchase_return_items`** - ERP 采购退货项表
    - 存储采购退货单的明细项

### 库存相关（11 张表）
18. **`erp_warehouse`** - ERP 仓库表
    - 存储仓库的基本信息，包括名称、地址、负责人、费用等

19. **`erp_stock`** - ERP 产品库存表
    - 存储产品的库存信息，按产品和仓库维度
    - 包含唯一索引：`uk_product_id_warehouse_id`（产品编号 + 仓库编号）

20. **`erp_stock_in`** - ERP 其它入库单表
    - 存储其它入库单信息（非采购入库）
    - 包含唯一索引：`uk_no`（入库单号）

21. **`erp_stock_in_item`** - ERP 其它入库单项表
    - 存储其它入库单的明细项

22. **`erp_stock_out`** - ERP 其它出库单表
    - 存储其它出库单信息（非销售出库）
    - 包含唯一索引：`uk_no`（出库单号）

23. **`erp_stock_out_item`** - ERP 其它出库单项表
    - 存储其它出库单的明细项

24. **`erp_stock_move`** - ERP 库存调拨单表
    - 存储库存调拨单信息，用于仓库间调拨
    - 包含唯一索引：`uk_no`（调拨单号）

25. **`erp_stock_move_item`** - ERP 库存调拨单项表
    - 存储库存调拨单的明细项，包含调出仓库和调入仓库

26. **`erp_stock_check`** - ERP 库存盘点单表
    - 存储库存盘点单信息
    - 包含唯一索引：`uk_no`（盘点单号）

27. **`erp_stock_check_item`** - ERP 库存盘点单项表
    - 存储库存盘点单的明细项，包含账面数量和实际数量

28. **`erp_stock_record`** - ERP 产品库存明细表
    - 存储所有库存变动记录，用于库存流水查询
    - 记录每次出入库的详细信息

### 财务相关（5 张表）
29. **`erp_account`** - ERP 结算账户表
    - 存储结算账户信息，如银行账户、现金账户等

30. **`erp_finance_receipt`** - ERP 收款单表
    - 存储收款单信息，关联客户和账户
    - 包含唯一索引：`uk_no`（收款单号）

31. **`erp_finance_receipt_item`** - ERP 收款项表
    - 存储收款单的明细项，关联销售出库或退货单

32. **`erp_finance_payment`** - ERP 付款单表
    - 存储付款单信息，关联供应商和账户
    - 包含唯一索引：`uk_no`（付款单号）

33. **`erp_finance_payment_item`** - ERP 付款项表
    - 存储付款单的明细项，关联采购入库或退货单

## 使用方法

### 方式一：使用 MySQL 命令行

```bash
mysql -u root -p your_database < ruoyi-vue-pro/sql/mysql/erp_tables.sql
```

### 方式二：使用数据库客户端工具

1. 打开 Navicat、DBeaver、DataGrip 等数据库客户端工具
2. 连接到目标数据库
3. 打开 `erp_tables.sql` 文件
4. 执行 SQL 脚本

### 方式三：在 MySQL 客户端中执行

```sql
source /path/to/ruoyi-vue-pro/sql/mysql/erp_tables.sql;
```

## 注意事项

1. **执行前备份**：执行 SQL 脚本前，请确保已备份数据库，以防数据丢失。

2. **表已存在**：如果表已存在，脚本会先删除旧表再创建新表（使用 `DROP TABLE IF EXISTS`）。如果表中有数据，请先备份。

3. **多租户支持**：所有表都包含 `tenant_id` 字段，支持多租户功能。

4. **索引**：脚本已为常用查询字段创建了索引，包括：
   - 唯一索引：订单号、单号等字段（如 `uk_no`、`uk_product_id_warehouse_id`）
   - 外键字段索引（如 `customer_id`、`supplier_id`、`product_id`、`warehouse_id` 等）
   - 业务字段索引（如 `status`、`order_time`、`in_time`、`out_time` 等）

5. **金额字段**：
   - 大部分金额字段使用 `decimal(20, 2)` 类型，单位：元
   - 注意：部分财务字段（如 `receipt_price`、`payment_price`）单位是分（根据注释）

6. **数量字段**：使用 `decimal(20, 2)` 类型，支持小数。

7. **Boolean 字段**：使用 `bit(1)` 类型，`NULL` 表示未设置，`b'0'` 表示 false，`b'1'` 表示 true。

8. **时间字段**：使用 `datetime` 类型，支持 `NULL`。

## 验证

执行 SQL 脚本后，可以通过以下 SQL 验证表是否创建成功：

```sql
-- 检查 erp_ 开头的表
SHOW TABLES LIKE 'erp_%';

-- 查看表结构
DESC erp_product;
DESC erp_sale_order;
DESC erp_purchase_order;
DESC erp_stock;
DESC erp_finance_receipt;

-- 查看表的记录数（应该都是 0）
SELECT COUNT(*) FROM erp_product;
SELECT COUNT(*) FROM erp_sale_order;
SELECT COUNT(*) FROM erp_purchase_order;
SELECT COUNT(*) FROM erp_stock;
SELECT COUNT(*) FROM erp_finance_receipt;
```

## 相关文档

- ERP 模块文档：https://doc.iocoder.cn/erp/build/
- 芋道源码官网：https://www.iocoder.cn/

## 表结构说明

### 核心业务表

#### erp_product 表

产品表是 ERP 模块的核心表，包含以下重要字段：
- `name`：产品名称
- `bar_code`：产品条码
- `category_id`：产品分类编号
- `unit_id`：单位编号
- `status`：产品状态
- `purchase_price`：采购价格（单位：元）
- `sale_price`：销售价格（单位：元）
- `min_price`：最低价格（单位：元）

#### erp_sale_order 表

销售订单表包含以下重要字段：
- `no`：销售订单号（唯一）
- `status`：销售状态
- `customer_id`：客户编号
- `account_id`：结算账户编号
- `sale_user_id`：销售员编号
- `order_time`：下单时间
- `total_price`：最终合计价格（单位：元）
- `total_product_price`：合计产品价格（单位：元）
- `total_tax_price`：合计税额（单位：元）
- `discount_price`：优惠金额（单位：元）
- `deposit_price`：定金金额（单位：元）
- `out_count`：销售出库数量
- `return_count`：销售退货数量

#### erp_purchase_order 表

采购订单表包含以下重要字段：
- `no`：采购订单号（唯一）
- `status`：采购状态
- `supplier_id`：供应商编号
- `account_id`：结算账户编号
- `order_time`：下单时间
- `total_price`：最终合计价格（单位：元）
- `total_product_price`：合计产品价格（单位：元）
- `total_tax_price`：合计税额（单位：元）
- `discount_price`：优惠金额（单位：元）
- `deposit_price`：定金金额（单位：元）
- `in_count`：采购入库数量
- `return_count`：采购退货数量

#### erp_stock 表

产品库存表包含以下重要字段：
- `product_id`：产品编号
- `warehouse_id`：仓库编号
- `count`：库存数量
- 包含唯一索引：`uk_product_id_warehouse_id`（产品编号 + 仓库编号）

#### erp_stock_record 表

产品库存明细表包含以下重要字段：
- `product_id`：产品编号
- `warehouse_id`：仓库编号
- `count`：出入库数量（正数表示入库，负数表示出库）
- `total_count`：总库存量（出入库之后的库存量）
- `biz_type`：业务类型（枚举值，如采购入库、销售出库等）
- `biz_id`：业务编号
- `biz_item_id`：业务项编号
- `biz_no`：业务单号

#### erp_finance_receipt 表

收款单表包含以下重要字段：
- `no`：收款单号（唯一）
- `status`：收款状态
- `receipt_time`：收款时间
- `finance_user_id`：财务人员编号
- `customer_id`：客户编号
- `account_id`：收款账户编号
- `total_price`：合计价格（单位：元）
- `discount_price`：优惠金额（单位：元）
- `receipt_price`：实付金额（单位：分）

#### erp_finance_payment 表

付款单表包含以下重要字段：
- `no`：付款单号（唯一）
- `status`：付款状态
- `payment_time`：付款时间
- `finance_user_id`：财务人员编号
- `supplier_id`：供应商编号
- `account_id`：付款账户编号
- `total_price`：合计价格（单位：元）
- `discount_price`：优惠金额（单位：元）
- `payment_price`：实付金额（单位：分）

### 配置表

#### erp_product_category 表

产品分类表，支持树形结构：
- `parent_id`：父分类编号（0 表示根分类）
- `name`：分类名称
- `code`：分类编码
- `sort`：分类排序
- `status`：开启状态

#### erp_product_unit 表

产品单位表：
- `name`：单位名字
- `status`：单位状态

#### erp_warehouse 表

仓库表包含以下重要字段：
- `name`：仓库名称
- `address`：仓库地址
- `principal`：负责人
- `warehouse_price`：仓储费（单位：元）
- `truckage_price`：搬运费（单位：元）
- `status`：开启状态
- `default_status`：是否默认

#### erp_account 表

结算账户表包含以下重要字段：
- `name`：账户名称
- `no`：账户编码
- `status`：开启状态
- `sort`：排序
- `default_status`：是否默认

### 关联表

#### 订单项表

所有订单项表（如 `erp_sale_order_items`、`erp_purchase_order_items` 等）都包含以下重要字段：
- `order_id`：订单编号
- `product_id`：产品编号
- `product_unit_id`：产品单位编号
- `product_price`：产品单位单价（单位：元）
- `count`：数量
- `total_price`：总价（单位：元）
- `tax_percent`：税率（百分比）
- `tax_price`：税额（单位：元）

#### 出入库项表

所有出入库项表（如 `erp_sale_out_items`、`erp_purchase_in_items` 等）都包含以下重要字段：
- `warehouse_id`：仓库编号
- `product_id`：产品编号
- `product_unit_id`：产品单位编号
- `product_price`：产品单价
- `count`：数量
- `total_price`：总价（单位：元）

## 表关系说明

```
erp_product (产品)
    ↓
erp_product_category (产品分类)
erp_product_unit (产品单位)

erp_customer (客户)
    ↓
erp_sale_order (销售订单)
    ↓
erp_sale_order_items (销售订单项)
    ↓
erp_sale_out (销售出库)
    ↓
erp_sale_out_items (销售出库项)
    ↓
erp_finance_receipt (收款单)
    ↓
erp_finance_receipt_item (收款项)

erp_supplier (供应商)
    ↓
erp_purchase_order (采购订单)
    ↓
erp_purchase_order_items (采购订单项)
    ↓
erp_purchase_in (采购入库)
    ↓
erp_purchase_in_items (采购入库项)
    ↓
erp_finance_payment (付款单)
    ↓
erp_finance_payment_item (付款项)

erp_warehouse (仓库)
    ↓
erp_stock (产品库存)
    ↓
erp_stock_record (库存明细)

erp_stock_in (其它入库) → erp_stock_in_item (其它入库项)
erp_stock_out (其它出库) → erp_stock_out_item (其它出库项)
erp_stock_move (库存调拨) → erp_stock_move_item (库存调拨项)
erp_stock_check (库存盘点) → erp_stock_check_item (库存盘点项)
```

## 常见问题

### Q: 执行脚本后提示表已存在？
A: 脚本使用了 `DROP TABLE IF EXISTS`，会先删除旧表再创建。如果表中有重要数据，请先备份。

### Q: 如何添加测试数据？
A: 可以在执行脚本后，手动插入测试数据，或者使用系统提供的初始化脚本。

### Q: tenant_id 字段的作用？
A: `tenant_id` 用于多租户功能，不同租户的数据通过此字段隔离。默认值为 0。

### Q: 金额字段的单位是什么？
A: 
- 大部分金额字段单位是**元**，使用 `decimal(20, 2)` 类型
- 注意：部分财务字段（如 `receipt_price`、`payment_price`）单位是**分**（根据注释）

### Q: 数量字段支持小数吗？
A: 是的，数量字段使用 `decimal(20, 2)` 类型，支持小数。

### Q: 库存是如何管理的？
A: 
- `erp_stock` 表存储当前库存（按产品和仓库维度）
- `erp_stock_record` 表存储所有库存变动记录（库存流水）
- 每次出入库操作都会更新 `erp_stock` 表，并在 `erp_stock_record` 表中记录变动

### Q: 销售订单和销售出库的关系？
A: 
- 销售订单（`erp_sale_order`）是客户下单的记录
- 销售出库（`erp_sale_out`）是根据销售订单进行出库的记录
- 一个销售订单可以分多次出库，通过 `order_id` 关联

### Q: 采购订单和采购入库的关系？
A: 
- 采购订单（`erp_purchase_order`）是向供应商下单的记录
- 采购入库（`erp_purchase_in`）是根据采购订单进行入库的记录
- 一个采购订单可以分多次入库，通过 `order_id` 关联

### Q: 收款单和付款单如何关联业务单据？
A: 
- 收款单（`erp_finance_receipt`）通过 `erp_finance_receipt_item` 关联销售出库或退货单
- 付款单（`erp_finance_payment`）通过 `erp_finance_payment_item` 关联采购入库或退货单
- 通过 `biz_type` 和 `biz_id` 字段关联不同的业务单据

### Q: 库存调拨是如何实现的？
A: 
- 库存调拨通过 `erp_stock_move` 和 `erp_stock_move_item` 表实现
- `from_warehouse_id` 表示调出仓库，`to_warehouse_id` 表示调入仓库
- 调拨时会减少调出仓库的库存，增加调入仓库的库存

### Q: 库存盘点是如何实现的？
A: 
- 库存盘点通过 `erp_stock_check` 和 `erp_stock_check_item` 表实现
- `stock_count` 表示账面数量（当前库存），`actual_count` 表示实际数量（盘点结果）
- `count` 表示盈亏数量（`stock_count - actual_count`）

## 数据初始化建议

执行 SQL 脚本后，建议初始化以下数据：

1. **产品分类数据**：在 `erp_product_category` 表中添加产品分类数据
2. **产品单位数据**：在 `erp_product_unit` 表中添加产品单位数据（如个、箱、件、kg 等）
3. **仓库数据**：在 `erp_warehouse` 表中添加仓库数据
4. **结算账户数据**：在 `erp_account` 表中添加结算账户数据（如银行账户、现金账户等）
5. **客户数据**：在 `erp_customer` 表中添加客户数据
6. **供应商数据**：在 `erp_supplier` 表中添加供应商数据

## 性能优化建议

1. **索引优化**：脚本已创建常用查询字段的索引，如需优化，可以根据实际查询场景添加复合索引。

2. **数据归档**：对于历史数据（如已完成的订单、出入库单等），建议定期归档到历史表，避免主表数据过多。

3. **分表策略**：对于数据量特别大的表（如 `erp_stock_record`），可以考虑按时间分表。

4. **读写分离**：对于高并发场景，建议使用读写分离，将统计查询等读操作分流到从库。

5. **缓存策略**：对于配置表（如 `erp_product_category`、`erp_product_unit`、`erp_warehouse`、`erp_account` 等），建议使用缓存，减少数据库查询。

6. **库存计算优化**：`erp_stock` 表存储当前库存，`erp_stock_record` 表存储库存流水。可以通过定期汇总 `erp_stock_record` 来校验 `erp_stock` 的数据准确性。

## 业务流程说明

### 销售流程

1. 创建销售订单（`erp_sale_order` + `erp_sale_order_items`）
2. 根据销售订单创建销售出库单（`erp_sale_out` + `erp_sale_out_items`）
3. 销售出库时更新库存（`erp_stock` 减少，`erp_stock_record` 记录）
4. 创建收款单（`erp_finance_receipt` + `erp_finance_receipt_item`）关联销售出库单
5. 如有退货，创建销售退货单（`erp_sale_return` + `erp_sale_return_items`），库存增加

### 采购流程

1. 创建采购订单（`erp_purchase_order` + `erp_purchase_order_items`）
2. 根据采购订单创建采购入库单（`erp_purchase_in` + `erp_purchase_in_items`）
3. 采购入库时更新库存（`erp_stock` 增加，`erp_stock_record` 记录）
4. 创建付款单（`erp_finance_payment` + `erp_finance_payment_item`）关联采购入库单
5. 如有退货，创建采购退货单（`erp_purchase_return` + `erp_purchase_return_items`），库存减少

### 库存管理流程

1. **其它入库**：创建其它入库单（`erp_stock_in` + `erp_stock_in_item`），库存增加
2. **其它出库**：创建其它出库单（`erp_stock_out` + `erp_stock_out_item`），库存减少
3. **库存调拨**：创建库存调拨单（`erp_stock_move` + `erp_stock_move_item`），调出仓库库存减少，调入仓库库存增加
4. **库存盘点**：创建库存盘点单（`erp_stock_check` + `erp_stock_check_item`），根据盘点结果调整库存

