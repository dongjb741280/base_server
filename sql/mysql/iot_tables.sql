-- ----------------------------
-- IoT 物联网模块表结构
-- ----------------------------

-- ----------------------------
-- 1. 产品相关表
-- ----------------------------

-- IoT 产品分类表
DROP TABLE IF EXISTS `iot_product_category`;
CREATE TABLE `iot_product_category` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类 ID',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名字',
    `sort` int NOT NULL DEFAULT '0' COMMENT '分类排序',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '分类状态',
    `description` varchar(500) DEFAULT NULL COMMENT '分类描述',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 产品分类表';

-- IoT 产品表
DROP TABLE IF EXISTS `iot_product`;
CREATE TABLE `iot_product` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '产品 ID',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '产品名称',
    `product_key` varchar(100) NOT NULL DEFAULT '' COMMENT '产品标识',
    `category_id` bigint DEFAULT NULL COMMENT '产品分类编号',
    `icon` varchar(500) DEFAULT NULL COMMENT '产品图标',
    `pic_url` varchar(500) DEFAULT NULL COMMENT '产品图片',
    `description` varchar(500) DEFAULT NULL COMMENT '产品描述',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '产品状态',
    `device_type` tinyint NOT NULL DEFAULT '0' COMMENT '设备类型',
    `net_type` tinyint NOT NULL DEFAULT '0' COMMENT '联网方式',
    `location_type` tinyint NOT NULL DEFAULT '0' COMMENT '定位方式',
    `codec_type` varchar(50) DEFAULT NULL COMMENT '数据格式（编解码器类型）',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_product_key` (`product_key`),
    KEY `idx_category_id` (`category_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 产品表';

-- ----------------------------
-- 2. 设备相关表
-- ----------------------------

-- IoT 设备分组表
DROP TABLE IF EXISTS `iot_device_group`;
CREATE TABLE `iot_device_group` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组 ID',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分组名字',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '分组状态',
    `description` varchar(500) DEFAULT NULL COMMENT '分组描述',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 设备分组表';

-- IoT 设备表
DROP TABLE IF EXISTS `iot_device`;
CREATE TABLE `iot_device` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备 ID',
    `device_name` varchar(255) NOT NULL DEFAULT '' COMMENT '设备名称',
    `nickname` varchar(255) DEFAULT NULL COMMENT '设备备注名称',
    `serial_number` varchar(100) DEFAULT NULL COMMENT '设备序列号',
    `pic_url` varchar(500) DEFAULT NULL COMMENT '设备图片',
    `group_ids` varchar(500) DEFAULT NULL COMMENT '设备分组编号集合',
    `product_id` bigint NOT NULL COMMENT '产品编号',
    `product_key` varchar(100) NOT NULL DEFAULT '' COMMENT '产品标识',
    `device_type` tinyint NOT NULL DEFAULT '0' COMMENT '设备类型',
    `gateway_id` bigint DEFAULT NULL COMMENT '网关设备编号',
    `state` tinyint NOT NULL DEFAULT '0' COMMENT '设备状态',
    `online_time` datetime DEFAULT NULL COMMENT '最后上线时间',
    `offline_time` datetime DEFAULT NULL COMMENT '最后离线时间',
    `active_time` datetime DEFAULT NULL COMMENT '设备激活时间',
    `ip` varchar(50) DEFAULT NULL COMMENT '设备的 IP 地址',
    `firmware_id` bigint DEFAULT NULL COMMENT '固件编号',
    `device_secret` varchar(100) DEFAULT NULL COMMENT '设备密钥',
    `auth_type` varchar(50) DEFAULT NULL COMMENT '认证类型',
    `location_type` tinyint NOT NULL DEFAULT '0' COMMENT '定位方式',
    `latitude` decimal(10,7) DEFAULT NULL COMMENT '设备位置的纬度',
    `longitude` decimal(10,7) DEFAULT NULL COMMENT '设备位置的经度',
    `area_id` int DEFAULT NULL COMMENT '地区编码',
    `address` varchar(500) DEFAULT NULL COMMENT '设备详细地址',
    `config` text COMMENT '设备配置（JSON 格式）',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_device_name` (`device_name`),
    KEY `idx_product_id` (`product_id`),
    KEY `idx_product_key` (`product_key`),
    KEY `idx_gateway_id` (`gateway_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 设备表';

-- ----------------------------
-- 3. 物模型相关表
-- ----------------------------

-- IoT 物模型表
DROP TABLE IF EXISTS `iot_thing_model`;
CREATE TABLE `iot_thing_model` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物模型功能编号',
    `identifier` varchar(100) NOT NULL DEFAULT '' COMMENT '功能标识',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '功能名称',
    `description` varchar(500) DEFAULT NULL COMMENT '功能描述',
    `product_id` bigint NOT NULL COMMENT '产品标识',
    `product_key` varchar(100) NOT NULL DEFAULT '' COMMENT '产品标识',
    `type` tinyint NOT NULL DEFAULT '0' COMMENT '功能类型',
    `property` text COMMENT '属性（JSON 格式）',
    `event` text COMMENT '事件（JSON 格式）',
    `service` text COMMENT '服务（JSON 格式）',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_product_id` (`product_id`),
    KEY `idx_product_key` (`product_key`),
    KEY `idx_identifier` (`identifier`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 物模型表';

-- ----------------------------
-- 4. 数据流转相关表
-- ----------------------------

-- IoT 数据流转目的表
DROP TABLE IF EXISTS `iot_data_sink`;
CREATE TABLE `iot_data_sink` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '数据流转目的编号',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '数据流转目的名称',
    `description` varchar(500) DEFAULT NULL COMMENT '数据流转目的描述',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '数据流转目的状态',
    `type` tinyint NOT NULL DEFAULT '0' COMMENT '数据流转目的类型',
    `config` text COMMENT '数据流转目的配置（JSON 格式）',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 数据流转目的表';

-- IoT 数据流转规则表
DROP TABLE IF EXISTS `iot_data_rule`;
CREATE TABLE `iot_data_rule` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '数据流转规格编号',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '数据流转规格名称',
    `description` varchar(500) DEFAULT NULL COMMENT '数据流转规格描述',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '数据流转规格状态',
    `source_configs` text COMMENT '数据源配置数组（JSON 格式）',
    `sink_ids` varchar(500) DEFAULT NULL COMMENT '数据目的编号数组',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 数据流转规则表';

-- IoT 场景联动规则表
DROP TABLE IF EXISTS `iot_scene_rule`;
CREATE TABLE `iot_scene_rule` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '场景联动编号',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '场景联动名称',
    `description` varchar(500) DEFAULT NULL COMMENT '场景联动描述',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '场景联动状态',
    `triggers` text COMMENT '场景定义配置（JSON 格式）',
    `actions` text COMMENT '场景动作配置（JSON 格式）',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 场景联动规则表';

-- ----------------------------
-- 5. OTA 升级相关表
-- ----------------------------

-- IoT OTA 固件表
DROP TABLE IF EXISTS `iot_ota_firmware`;
CREATE TABLE `iot_ota_firmware` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '固件编号',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '固件名称',
    `description` varchar(500) DEFAULT NULL COMMENT '固件描述',
    `version` varchar(50) NOT NULL DEFAULT '' COMMENT '版本号',
    `product_id` bigint NOT NULL COMMENT '产品编号',
    `file_url` varchar(500) DEFAULT NULL COMMENT '固件文件 URL',
    `file_size` bigint NOT NULL DEFAULT '0' COMMENT '固件文件大小',
    `file_digest_algorithm` varchar(50) DEFAULT NULL COMMENT '固件文件签名算法',
    `file_digest_value` varchar(255) DEFAULT NULL COMMENT '固件文件签名结果',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_product_id` (`product_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT OTA 固件表';

-- IoT OTA 升级任务表
DROP TABLE IF EXISTS `iot_ota_task`;
CREATE TABLE `iot_ota_task` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务编号',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称',
    `description` varchar(500) DEFAULT NULL COMMENT '任务描述',
    `firmware_id` bigint NOT NULL COMMENT '固件编号',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '任务状态',
    `device_scope` tinyint NOT NULL DEFAULT '0' COMMENT '设备升级范围',
    `device_total_count` int NOT NULL DEFAULT '0' COMMENT '设备总数数量',
    `device_success_count` int NOT NULL DEFAULT '0' COMMENT '设备成功数量',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_firmware_id` (`firmware_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT OTA 升级任务表';

-- IoT OTA 升级任务记录表
DROP TABLE IF EXISTS `iot_ota_task_record`;
CREATE TABLE `iot_ota_task_record` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '升级记录编号',
    `firmware_id` bigint NOT NULL COMMENT '固件编号',
    `task_id` bigint NOT NULL COMMENT '任务编号',
    `device_id` bigint NOT NULL COMMENT '设备编号',
    `from_firmware_id` bigint DEFAULT NULL COMMENT '来源的固件编号',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '升级状态',
    `progress` int NOT NULL DEFAULT '0' COMMENT '升级进度，百分比',
    `description` varchar(500) DEFAULT NULL COMMENT '升级进度描述',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_firmware_id` (`firmware_id`),
    KEY `idx_task_id` (`task_id`),
    KEY `idx_device_id` (`device_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT OTA 升级任务记录表';

-- ----------------------------
-- 6. 告警相关表
-- ----------------------------

-- IoT 告警配置表
DROP TABLE IF EXISTS `iot_alert_config`;
CREATE TABLE `iot_alert_config` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置编号',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '配置名称',
    `description` varchar(500) DEFAULT NULL COMMENT '配置描述',
    `level` tinyint NOT NULL DEFAULT '0' COMMENT '告警级别',
    `status` tinyint NOT NULL DEFAULT '0' COMMENT '配置状态',
    `scene_rule_ids` varchar(500) DEFAULT NULL COMMENT '关联的场景联动规则编号数组',
    `receive_user_ids` varchar(500) DEFAULT NULL COMMENT '接收的用户编号数组',
    `receive_types` varchar(500) DEFAULT NULL COMMENT '接收的类型数组',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 告警配置表';

-- IoT 告警记录表
DROP TABLE IF EXISTS `iot_alert_record`;
CREATE TABLE `iot_alert_record` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录编号',
    `config_id` bigint NOT NULL COMMENT '告警配置编号',
    `config_name` varchar(255) NOT NULL DEFAULT '' COMMENT '告警名称',
    `config_level` tinyint NOT NULL DEFAULT '0' COMMENT '告警级别',
    `scene_rule_id` bigint DEFAULT NULL COMMENT '场景规则编号',
    `product_id` bigint DEFAULT NULL COMMENT '产品编号',
    `device_id` bigint DEFAULT NULL COMMENT '设备编号',
    `device_message` text COMMENT '触发的设备消息（JSON 格式）',
    `process_status` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否处理',
    `process_remark` varchar(500) DEFAULT NULL COMMENT '处理结果（备注）',
    `creator` varchar(64) DEFAULT '' COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updater` varchar(64) DEFAULT '' COMMENT '更新者',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
    PRIMARY KEY (`id`),
    KEY `idx_config_id` (`config_id`),
    KEY `idx_scene_rule_id` (`scene_rule_id`),
    KEY `idx_product_id` (`product_id`),
    KEY `idx_device_id` (`device_id`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IoT 告警记录表';

