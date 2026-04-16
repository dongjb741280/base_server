# IoT 物联网模块数据库表结构说明

## 概述

本文档描述了 IoT 物联网模块的数据库表结构。该模块提供了完整的物联网设备管理、数据流转、场景联动、OTA 升级和告警等功能。

## 表结构说明

### 1. 产品相关表

#### `iot_product_category` - IoT 产品分类表
- **说明**：存储 IoT 产品的分类信息
- **主要字段**：
  - `id`：分类 ID（主键）
  - `name`：分类名字
  - `sort`：分类排序
  - `status`：分类状态
  - `description`：分类描述

#### `iot_product` - IoT 产品表
- **说明**：存储 IoT 产品的基本信息，包括产品标识、类型、联网方式等
- **主要字段**：
  - `id`：产品 ID（主键）
  - `name`：产品名称
  - `product_key`：产品标识（唯一）
  - `category_id`：产品分类编号
  - `device_type`：设备类型
  - `net_type`：联网方式
  - `location_type`：定位方式
  - `codec_type`：数据格式（编解码器类型）
  - `tenant_id`：租户编号
- **索引**：
  - `idx_product_key`：产品标识索引
  - `idx_category_id`：分类编号索引
  - `idx_tenant_id`：租户编号索引

### 2. 设备相关表

#### `iot_device_group` - IoT 设备分组表
- **说明**：存储设备分组信息，用于设备分类管理
- **主要字段**：
  - `id`：分组 ID（主键）
  - `name`：分组名字
  - `status`：分组状态
  - `description`：分组描述

#### `iot_device` - IoT 设备表
- **说明**：存储 IoT 设备的详细信息，包括设备状态、位置、配置等
- **主要字段**：
  - `id`：设备 ID（主键）
  - `device_name`：设备名称（在产品内唯一）
  - `nickname`：设备备注名称
  - `serial_number`：设备序列号
  - `product_id`：产品编号
  - `product_key`：产品标识（冗余字段）
  - `device_type`：设备类型（冗余字段）
  - `gateway_id`：网关设备编号（子设备关联）
  - `state`：设备状态（在线/离线等）
  - `online_time`：最后上线时间
  - `offline_time`：最后离线时间
  - `active_time`：设备激活时间
  - `ip`：设备的 IP 地址
  - `firmware_id`：固件编号
  - `device_secret`：设备密钥
  - `auth_type`：认证类型
  - `location_type`：定位方式
  - `latitude`：设备位置的纬度
  - `longitude`：设备位置的经度
  - `area_id`：地区编码
  - `address`：设备详细地址
  - `config`：设备配置（JSON 格式）
  - `group_ids`：设备分组编号集合（使用 LongSetTypeHandler）
  - `tenant_id`：租户编号
- **索引**：
  - `idx_device_name`：设备名称索引
  - `idx_product_id`：产品编号索引
  - `idx_product_key`：产品标识索引
  - `idx_gateway_id`：网关设备编号索引
  - `idx_tenant_id`：租户编号索引

### 3. 物模型相关表

#### `iot_thing_model` - IoT 物模型表
- **说明**：存储产品的物模型功能定义，包括属性、事件、服务
- **主要字段**：
  - `id`：物模型功能编号（主键）
  - `identifier`：功能标识
  - `name`：功能名称
  - `description`：功能描述
  - `product_id`：产品标识
  - `product_key`：产品标识
  - `type`：功能类型（属性/事件/服务）
  - `property`：属性（JSON 格式，使用 JacksonTypeHandler）
  - `event`：事件（JSON 格式，使用 JacksonTypeHandler）
  - `service`：服务（JSON 格式，使用 JacksonTypeHandler）
- **索引**：
  - `idx_product_id`：产品编号索引
  - `idx_product_key`：产品标识索引
  - `idx_identifier`：功能标识索引

### 4. 数据流转相关表

#### `iot_data_sink` - IoT 数据流转目的表
- **说明**：存储数据流转的目的配置，如转发到数据库、消息队列等
- **主要字段**：
  - `id`：数据流转目的编号（主键）
  - `name`：数据流转目的名称
  - `description`：数据流转目的描述
  - `status`：数据流转目的状态
  - `type`：数据流转目的类型
  - `config`：数据流转目的配置（JSON 格式，使用 JacksonTypeHandler）

#### `iot_data_rule` - IoT 数据流转规则表
- **说明**：存储数据流转规则，定义数据源和转发目的
- **主要字段**：
  - `id`：数据流转规格编号（主键）
  - `name`：数据流转规格名称
  - `description`：数据流转规格描述
  - `status`：数据流转规格状态
  - `source_configs`：数据源配置数组（JSON 格式，使用 JacksonTypeHandler）
  - `sink_ids`：数据目的编号数组（使用 LongListTypeHandler）

#### `iot_scene_rule` - IoT 场景联动规则表
- **说明**：存储场景联动规则，定义触发条件和执行动作
- **主要字段**：
  - `id`：场景联动编号（主键）
  - `name`：场景联动名称
  - `description`：场景联动描述
  - `status`：场景联动状态
  - `triggers`：场景定义配置（JSON 格式，使用 JacksonTypeHandler）
  - `actions`：场景动作配置（JSON 格式，使用 JacksonTypeHandler）
  - `tenant_id`：租户编号
- **索引**：
  - `idx_tenant_id`：租户编号索引

### 5. OTA 升级相关表

#### `iot_ota_firmware` - IoT OTA 固件表
- **说明**：存储 OTA 固件信息，包括固件文件、版本等
- **主要字段**：
  - `id`：固件编号（主键）
  - `name`：固件名称
  - `description`：固件描述
  - `version`：版本号
  - `product_id`：产品编号
  - `file_url`：固件文件 URL
  - `file_size`：固件文件大小
  - `file_digest_algorithm`：固件文件签名算法
  - `file_digest_value`：固件文件签名结果
- **索引**：
  - `idx_product_id`：产品编号索引

#### `iot_ota_task` - IoT OTA 升级任务表
- **说明**：存储 OTA 升级任务信息
- **主要字段**：
  - `id`：任务编号（主键）
  - `name`：任务名称
  - `description`：任务描述
  - `firmware_id`：固件编号
  - `status`：任务状态
  - `device_scope`：设备升级范围
  - `device_total_count`：设备总数数量
  - `device_success_count`：设备成功数量
- **索引**：
  - `idx_firmware_id`：固件编号索引

#### `iot_ota_task_record` - IoT OTA 升级任务记录表
- **说明**：存储每个设备的 OTA 升级记录
- **主要字段**：
  - `id`：升级记录编号（主键）
  - `firmware_id`：固件编号
  - `task_id`：任务编号
  - `device_id`：设备编号
  - `from_firmware_id`：来源的固件编号
  - `status`：升级状态
  - `progress`：升级进度，百分比
  - `description`：升级进度描述
- **索引**：
  - `idx_firmware_id`：固件编号索引
  - `idx_task_id`：任务编号索引
  - `idx_device_id`：设备编号索引

### 6. 告警相关表

#### `iot_alert_config` - IoT 告警配置表
- **说明**：存储告警配置信息，包括告警级别、接收方式等
- **主要字段**：
  - `id`：配置编号（主键）
  - `name`：配置名称
  - `description`：配置描述
  - `level`：告警级别
  - `status`：配置状态
  - `scene_rule_ids`：关联的场景联动规则编号数组（使用 LongListTypeHandler）
  - `receive_user_ids`：接收的用户编号数组（使用 LongListTypeHandler）
  - `receive_types`：接收的类型数组（使用 IntegerListTypeHandler）

#### `iot_alert_record` - IoT 告警记录表
- **说明**：存储告警记录信息
- **主要字段**：
  - `id`：记录编号（主键）
  - `config_id`：告警配置编号
  - `config_name`：告警名称（冗余字段）
  - `config_level`：告警级别（冗余字段）
  - `scene_rule_id`：场景规则编号
  - `product_id`：产品编号
  - `device_id`：设备编号
  - `device_message`：触发的设备消息（JSON 格式，使用 JacksonTypeHandler）
  - `process_status`：是否处理
  - `process_remark`：处理结果（备注）
- **索引**：
  - `idx_config_id`：告警配置编号索引
  - `idx_scene_rule_id`：场景规则编号索引
  - `idx_product_id`：产品编号索引
  - `idx_device_id`：设备编号索引

## 使用说明

### 1. 执行 SQL 脚本

在 MySQL 数据库中执行 `iot_tables.sql` 脚本：

```bash
mysql -u root -p your_database < iot_tables.sql
```

### 2. 注意事项

1. **多租户支持**：
   - `iot_product`、`iot_device`、`iot_scene_rule` 表包含 `tenant_id` 字段，支持多租户隔离
   - 其他表为系统级表，不包含 `tenant_id` 字段

2. **JSON 字段处理**：
   - 使用 `JacksonTypeHandler` 的字段（如 `property`、`event`、`service`、`config`、`triggers`、`actions` 等）存储为 `TEXT` 类型
   - 使用 `LongListTypeHandler` 的字段（如 `sink_ids`、`scene_rule_ids`、`receive_user_ids` 等）存储为 `VARCHAR(500)` 类型
   - 使用 `IntegerListTypeHandler` 的字段（如 `receive_types`）存储为 `VARCHAR(500)` 类型
   - 使用 `LongSetTypeHandler` 的字段（如 `group_ids`）存储为 `VARCHAR(500)` 类型

3. **设备消息存储**：
   - `IotDeviceMessageDO` 使用 TDengine 存储，不在 MySQL 中创建表
   - `IotDevicePropertyDO` 使用 Redis 存储，不在 MySQL 中创建表

4. **索引优化**：
   - 所有表都包含必要的索引，以提高查询性能
   - 建议根据实际业务场景添加额外的索引

5. **软删除**：
   - 所有表都包含 `deleted` 字段，使用逻辑删除
   - 查询时需要过滤 `deleted = 0` 的记录

## 相关文档

- [IoT 模块开发文档](https://doc.iocoder.cn/iot/build/)
- [IoT 模块功能说明](https://doc.iocoder.cn/iot/)

## 表统计

- **总表数**：13 张表
- **产品相关**：2 张表
- **设备相关**：2 张表
- **物模型相关**：1 张表
- **数据流转相关**：3 张表
- **OTA 升级相关**：3 张表
- **告警相关**：2 张表

