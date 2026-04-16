# 商城模块表结构说明

## 概述

本 SQL 脚本用于创建商城模块（`yudao-module-mall`）所需的所有数据库表。商城模块包含4个子模块，共49张表。

## 包含的子模块和表

### 1. Product 模块 - 商品模块（9个表）

#### 核心表
1. **`product_brand`** - 商品品牌表
   - 存储商品品牌信息

2. **`product_category`** - 商品分类表
   - 存储商品分类信息，支持树形结构（通过 `parent_id` 字段）

3. **`product_property`** - 商品属性项表
   - 存储商品属性项（如：颜色、尺寸等）

4. **`product_property_value`** - 商品属性值表
   - 存储商品属性值（如：红色、蓝色、XL、XXL等）

5. **`product_spu`** - 商品 SPU 表
   - 商品标准单位表，存储商品的基本信息、价格、库存、营销信息等
   - 核心表，包含商品的主要信息

6. **`product_sku`** - 商品 SKU 表
   - 商品库存单位表，存储具体规格的商品信息
   - 关联 `product_spu` 表

#### 用户行为表
7. **`product_comment`** - 商品评论表
   - 存储用户对商品的评价和评论

8. **`product_favorite`** - 商品收藏表
   - 存储用户收藏的商品

9. **`product_browse_history`** - 商品浏览记录表
   - 存储用户浏览商品的历史记录

### 2. Promotion 模块 - 促销模块（23个表）

#### 文章和 Banner
1. **`promotion_article_category`** - 文章分类表
2. **`promotion_article`** - 文章管理表
3. **`promotion_banner`** - Banner 表

#### 砍价活动
4. **`promotion_bargain_activity`** - 砍价活动表
5. **`promotion_bargain_help`** - 砍价助力表
6. **`promotion_bargain_record`** - 砍价记录表

#### 拼团活动
7. **`promotion_combination_activity`** - 拼团活动表
8. **`promotion_combination_product`** - 拼团商品表
9. **`promotion_combination_record`** - 拼团记录表

#### 优惠券
10. **`promotion_coupon_template`** - 优惠劵模板表
11. **`promotion_coupon`** - 优惠劵表

#### 限时折扣
12. **`promotion_discount_activity`** - 限时折扣活动表
13. **`promotion_discount_product`** - 限时折扣商品表

#### 装修
14. **`promotion_diy_template`** - 装修模板表
15. **`promotion_diy_page`** - 装修页面表

#### 客服
16. **`promotion_kefu_conversation`** - 客服会话表
17. **`promotion_kefu_message`** - 客服消息表

#### 积分商城
18. **`promotion_point_activity`** - 积分商城活动表
19. **`promotion_point_product`** - 积分商城商品表

#### 满减送
20. **`promotion_reward_activity`** - 满减送活动表

#### 秒杀
21. **`promotion_seckill_config`** - 秒杀时段表
22. **`promotion_seckill_activity`** - 秒杀活动表
23. **`promotion_seckill_product`** - 秒杀参与商品表

### 3. Trade 模块 - 交易模块（15个表）

#### 订单相关
1. **`trade_order`** - 交易订单表
   - 核心订单表，存储订单的基本信息、价格信息、物流信息、营销信息等
   - 包含唯一索引：`uk_no`（订单流水号）

2. **`trade_order_item`** - 交易订单项表
   - 存储订单中的商品明细信息

3. **`trade_order_log`** - 订单日志表
   - 记录订单状态变更历史

#### 售后相关
4. **`trade_after_sale`** - 售后订单表
   - 处理订单的退款退货流程
   - 包含唯一索引：`uk_no`（售后单号）

5. **`trade_after_sale_log`** - 交易售后日志表
   - 记录售后操作历史

#### 分销相关
6. **`trade_brokerage_user`** - 分销用户表
   - 存储用户的分销信息

7. **`trade_brokerage_record`** - 佣金记录表
   - 记录佣金变动历史

8. **`trade_brokerage_withdraw`** - 佣金提现表
   - 记录佣金提现申请和状态

#### 购物车
9. **`trade_cart`** - 购物车表
   - 存储用户的购物车商品

#### 配置
10. **`trade_config`** - 交易中心配置表
    - 存储交易相关的系统配置

#### 物流相关
11. **`trade_delivery_express`** - 快递公司表
    - 存储快递公司信息
    - 包含唯一索引：`uk_code`（快递公司 code）

12. **`trade_delivery_express_template`** - 快递运费模板表
    - 存储运费模板基本信息

13. **`trade_delivery_express_template_charge`** - 快递运费模板计费配置表
    - 存储运费模板的计费规则

14. **`trade_delivery_express_template_free`** - 快递运费模板包邮配置表
    - 存储运费模板的包邮规则

15. **`trade_delivery_pick_up_store`** - 自提门店表
    - 存储自提门店信息

### 4. Statistics 模块 - 统计模块（2个表）

1. **`product_statistics`** - 商品统计表
   - 按日期统计商品的浏览量、访客量、收藏量、加购量、下单量、支付量等
   - 包含唯一索引：`uk_time_spu_id`（统计日期 + 商品 SPU 编号）

2. **`trade_statistics`** - 交易统计表
   - 按日期统计订单、支付、退款、佣金、充值等数据
   - 包含唯一索引：`uk_time`（统计日期）

## 使用方法

### 方式一：使用 MySQL 命令行

```bash
mysql -u root -p your_database < ruoyi-vue-pro/sql/mysql/mall_tables.sql
```

### 方式二：使用数据库客户端工具

1. 打开 Navicat、DBeaver、DataGrip 等数据库客户端工具
2. 连接到目标数据库
3. 打开 `mall_tables.sql` 文件
4. 执行 SQL 脚本

### 方式三：在 MySQL 客户端中执行

```sql
source /path/to/ruoyi-vue-pro/sql/mysql/mall_tables.sql;
```

## 注意事项

1. **执行前备份**：执行 SQL 脚本前，请确保已备份数据库，以防数据丢失。

2. **表已存在**：如果表已存在，脚本会先删除旧表再创建新表（使用 `DROP TABLE IF EXISTS`）。如果表中有数据，请先备份。

3. **多租户支持**：所有表都包含 `tenant_id` 字段，支持多租户功能。

4. **索引**：脚本已为常用查询字段创建了索引，包括：
   - `trade_order` 表的 `uk_no`（订单流水号唯一索引）
   - `trade_after_sale` 表的 `uk_no`（售后单号唯一索引）
   - `trade_delivery_express` 表的 `uk_code`（快递公司 code 唯一索引）
   - `product_statistics` 表的 `uk_time_spu_id`（统计日期 + 商品 SPU 编号唯一索引）
   - `trade_statistics` 表的 `uk_time`（统计日期唯一索引）
   - 其他表的常用查询字段索引

5. **JSON 字段**：部分表包含 JSON 格式的字段（如 `properties`、`apply_pic_urls`、`rules` 等），这些字段使用 `text` 类型存储。

6. **List 字段**：部分字段存储 List 类型数据（如 `area_ids`、`verify_user_ids`、`config_ids`、`product_scope_values` 等），这些字段使用 `varchar` 类型，通过 TypeHandler 处理。

7. **金额字段**：所有金额字段使用 `int` 类型，单位：分。例如：100 表示 1 元。

8. **时间字段**：
   - `datetime` 类型：用于日期时间字段
   - `date` 类型：用于日期字段（如统计表的 `time` 字段）
   - `time` 类型：用于时间字段（如自提门店的营业时间）

## 验证

执行 SQL 脚本后，可以通过以下 SQL 验证表是否创建成功：

```sql
-- 检查 product_ 开头的表
SHOW TABLES LIKE 'product_%';

-- 检查 promotion_ 开头的表
SHOW TABLES LIKE 'promotion_%';

-- 检查 trade_ 开头的表
SHOW TABLES LIKE 'trade_%';

-- 检查统计表
SHOW TABLES LIKE '%_statistics';

-- 查看核心表结构
DESC product_spu;
DESC product_sku;
DESC trade_order;
DESC trade_after_sale;

-- 查看表的记录数（应该都是 0）
SELECT COUNT(*) FROM product_spu;
SELECT COUNT(*) FROM trade_order;
SELECT COUNT(*) FROM product_statistics;
SELECT COUNT(*) FROM trade_statistics;
```

## 相关文档

- 商城模块文档：https://cloud.iocoder.cn/mall/build/
- 芋道源码官网：https://www.iocoder.cn/

## 表结构说明

### 核心表

#### product_spu 表

商品 SPU 表是商品模块的核心表，包含以下重要字段：
- `name`：商品名称
- `category_id`：商品分类编号
- `brand_id`：商品品牌编号
- `price`：商品价格（单位：分）
- `stock`：库存
- `spec_type`：规格类型（false-单规格，true-多规格）
- `delivery_types`：配送方式数组
- `sales_count`：商品销量
- `browse_count`：浏览量

#### product_sku 表

商品 SKU 表存储具体规格的商品信息：
- `spu_id`：关联 SPU 编号
- `properties`：属性数组（JSON 格式）
- `price`：商品价格（单位：分）
- `stock`：库存
- `first_brokerage_price`：一级分销的佣金
- `second_brokerage_price`：二级分销的佣金

#### trade_order 表

交易订单表是交易模块的核心表，包含以下重要字段：
- `no`：订单流水号（唯一）
- `user_id`：用户编号
- `status`：订单状态
- `pay_status`：是否已支付
- `total_price`：商品原价
- `pay_price`：应付金额
- `delivery_type`：配送方式
- `receiver_*`：收件人信息
- `coupon_id`：优惠劵编号
- `use_point`：使用的积分
- `give_point`：赠送的积分

#### trade_after_sale 表

售后订单表包含以下重要字段：
- `no`：售后单号（唯一）
- `status`：退款状态
- `way`：售后方式
- `type`：售后类型
- `refund_price`：退款金额
- `logistics_id`：退货物流公司编号

### 促销活动表

#### promotion_seckill_activity 表

秒杀活动表包含以下重要字段：
- `spu_id`：秒杀活动商品
- `name`：秒杀活动名称
- `start_time`：活动开始时间
- `end_time`：活动结束时间
- `stock`：秒杀库存
- `total_limit_count`：总限购数量
- `single_limit_count`：单次限购数量

#### promotion_coupon_template 表

优惠劵模板表包含以下重要字段：
- `name`：优惠劵名
- `total_count`：发放数量（-1 表示不限制）
- `take_limit_count`：每人限领个数（-1 表示不限制）
- `discount_type`：折扣类型
- `discount_percent`：折扣百分比
- `discount_price`：优惠金额

### 统计表

#### product_statistics 表

商品统计表按日期和商品 SPU 统计：
- `time`：统计日期
- `spu_id`：商品 SPU 编号
- `browse_count`：浏览量
- `order_pay_count`：支付件数
- `order_pay_price`：支付金额
- `browse_convert_percent`：访客支付转化率

#### trade_statistics 表

交易统计表按日期统计：
- `time`：统计日期
- `order_pay_count`：支付订单商品数
- `order_pay_price`：总支付金额
- `after_sale_refund_price`：总退款金额
- `brokerage_settlement_price`：佣金金额（已结算）

## 表关系说明

### 商品模块表关系

```
product_category (商品分类)
    ↓
product_brand (商品品牌)
    ↓
product_spu (商品 SPU)
    ↓
product_sku (商品 SKU)
    ↓
product_property (商品属性项)
    ↓
product_property_value (商品属性值)
```

### 交易模块表关系

```
trade_cart (购物车)
    ↓
trade_order (交易订单)
    ↓
trade_order_item (交易订单项)
    ↓
trade_after_sale (售后订单)
```

### 促销模块表关系

```
promotion_seckill_config (秒杀时段)
    ↓
promotion_seckill_activity (秒杀活动)
    ↓
promotion_seckill_product (秒杀参与商品)
```

## 常见问题

### Q: 执行脚本后提示表已存在？
A: 脚本使用了 `DROP TABLE IF EXISTS`，会先删除旧表再创建。如果表中有重要数据，请先备份。

### Q: 如何添加测试数据？
A: 可以在执行脚本后，手动插入测试数据，或者使用系统提供的初始化脚本。

### Q: tenant_id 字段的作用？
A: `tenant_id` 用于多租户功能，不同租户的数据通过此字段隔离。默认值为 0。

### Q: JSON 字段如何查询？
A: JSON 字段使用 `text` 类型存储，可以通过 JSON 函数查询，或者通过 MyBatis Plus 的 TypeHandler 自动处理。

### Q: List 字段如何存储？
A: List 字段使用 `varchar` 类型存储，通过逗号分隔。例如：`1,2,3`。通过 MyBatis Plus 的 TypeHandler 自动转换。

### Q: 金额字段为什么使用 int 类型？
A: 为了避免浮点数精度问题，所有金额字段使用 `int` 类型，单位：分。例如：100 表示 1 元，10000 表示 100 元。

### Q: 如何理解 SPU 和 SKU？
A: 
- **SPU**（Standard Product Unit）：标准产品单位，是商品信息聚合的最小单位。例如：iPhone 14 是一个 SPU。
- **SKU**（Stock Keeping Unit）：库存量单位，是库存进出计量的基本单位。例如：iPhone 14 128GB 黑色是一个 SKU。

### Q: 订单表为什么字段这么多？
A: `trade_order` 表包含了订单的所有信息，包括基本信息、价格信息、物流信息、营销信息等。这样设计可以减少关联查询，提高查询性能。

## 数据初始化建议

执行 SQL 脚本后，建议初始化以下数据：

1. **快递公司数据**：在 `trade_delivery_express` 表中添加常用的快递公司信息
2. **商品分类数据**：在 `product_category` 表中添加商品分类
3. **交易配置数据**：在 `trade_config` 表中添加交易相关配置
4. **会员等级数据**：如果使用会员模块，需要先初始化会员等级数据

## 性能优化建议

1. **索引优化**：脚本已创建常用查询字段的索引，如需优化，可以根据实际查询场景添加复合索引。

2. **分区表**：对于数据量大的表（如 `trade_order`、`product_statistics`），可以考虑使用分区表。

3. **归档策略**：对于历史数据（如订单日志、统计表），建议定期归档到历史表。

4. **读写分离**：对于高并发场景，建议使用读写分离，将统计查询等读操作分流到从库。

