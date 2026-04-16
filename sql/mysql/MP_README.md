# 微信公众号模块表结构说明

## 概述

本 SQL 脚本用于创建微信公众号模块（`yudao-module-mp`）所需的所有数据库表。

## 包含的表

本脚本包含以下 8 张表：

### 核心表
1. **`mp_account`** - 公众号账号表
   - 存储公众号的基本配置信息，包括 appId、appSecret、token、aesKey 等
   - 包含唯一索引：`uk_app_id`（公众号 appid）

### 用户相关
2. **`mp_user`** - 微信公众号粉丝表
   - 存储关注公众号的用户信息
   - 包含唯一索引：`uk_account_id_openid`（公众号账号编号 + 粉丝标识）

3. **`mp_tag`** - 公众号标签表
   - 存储公众号的用户标签信息
   - 注意：`id` 字段不是自增的，需要手动指定
   - 包含唯一索引：`uk_account_id_tag_id`（公众号账号编号 + 标签 id）

### 内容相关
4. **`mp_material`** - 公众号素材表
   - 存储公众号的临时素材和永久素材
   - 支持图片、语音、视频、图文等多种类型

5. **`mp_menu`** - 公众号菜单表
   - 存储公众号的自定义菜单配置
   - 支持树形结构（通过 `parent_id` 字段）

### 消息相关
6. **`mp_message`** - 公众号消息表
   - 存储公众号与粉丝之间的消息记录
   - 支持文本、图片、语音、视频、图文、位置、链接等多种消息类型
   - 支持事件推送（关注、取消关注、点击菜单等）

7. **`mp_message_template`** - 公众号模版消息表
   - 存储公众号的模板消息配置
   - 包含唯一索引：`uk_account_id_template_id`（公众号账号编号 + 模板 ID）

8. **`mp_auto_reply`** - 公众号消息自动回复表
   - 存储公众号的自动回复规则
   - 支持关键词自动回复和消息类型自动回复

## 使用方法

### 方式一：使用 MySQL 命令行

```bash
mysql -u root -p your_database < ruoyi-vue-pro/sql/mysql/mp_tables.sql
```

### 方式二：使用数据库客户端工具

1. 打开 Navicat、DBeaver、DataGrip 等数据库客户端工具
2. 连接到目标数据库
3. 打开 `mp_tables.sql` 文件
4. 执行 SQL 脚本

### 方式三：在 MySQL 客户端中执行

```sql
source /path/to/ruoyi-vue-pro/sql/mysql/mp_tables.sql;
```

## 注意事项

1. **执行前备份**：执行 SQL 脚本前，请确保已备份数据库，以防数据丢失。

2. **表已存在**：如果表已存在，脚本会先删除旧表再创建新表（使用 `DROP TABLE IF EXISTS`）。如果表中有数据，请先备份。

3. **多租户支持**：所有表都包含 `tenant_id` 字段，支持多租户功能。

4. **索引**：脚本已为常用查询字段创建了索引，包括：
   - `mp_account` 表的 `uk_app_id`（公众号 appid 唯一索引）
   - `mp_user` 表的 `uk_account_id_openid`（公众号账号编号 + 粉丝标识唯一索引）
   - `mp_tag` 表的 `uk_account_id_tag_id`（公众号账号编号 + 标签 id 唯一索引）
   - `mp_message_template` 表的 `uk_account_id_template_id`（公众号账号编号 + 模板 ID 唯一索引）
   - 其他表的常用查询字段索引

5. **JSON 字段**：部分表包含 JSON 格式的字段（如 `reply_articles`、`articles`、`response_articles` 等），这些字段使用 `text` 类型存储。

6. **List 字段**：部分字段存储 List 类型数据（如 `tag_ids`），这些字段使用 `varchar` 类型，通过 TypeHandler 处理。

7. **mp_tag 表特殊说明**：
   - `id` 字段不是自增的，使用 `IdType.INPUT`，需要手动指定
   - 通常使用 `account_id` 和 `tag_id` 的组合作为主键

## 验证

执行 SQL 脚本后，可以通过以下 SQL 验证表是否创建成功：

```sql
-- 检查 mp_ 开头的表
SHOW TABLES LIKE 'mp_%';

-- 查看表结构
DESC mp_account;
DESC mp_user;
DESC mp_tag;
DESC mp_material;
DESC mp_menu;
DESC mp_message;
DESC mp_message_template;
DESC mp_auto_reply;

-- 查看表的记录数（应该都是 0）
SELECT COUNT(*) FROM mp_account;
SELECT COUNT(*) FROM mp_user;
SELECT COUNT(*) FROM mp_tag;
SELECT COUNT(*) FROM mp_material;
SELECT COUNT(*) FROM mp_menu;
SELECT COUNT(*) FROM mp_message;
SELECT COUNT(*) FROM mp_message_template;
SELECT COUNT(*) FROM mp_auto_reply;
```

## 相关文档

- 微信公众号模块文档：https://doc.iocoder.cn/mp/build/
- 芋道源码官网：https://www.iocoder.cn/

## 表结构说明

### mp_account 表

公众号账号表是核心表，包含以下重要字段：
- `name`：公众号名称
- `account`：公众号账号
- `app_id`：公众号 appid（唯一）
- `app_secret`：公众号密钥
- `token`：公众号 token
- `aes_key`：消息加解密密钥
- `qr_code_url`：二维码图片 URL

### mp_user 表

微信公众号粉丝表包含以下重要字段：
- `openid`：粉丝标识（唯一，与 account_id 组合）
- `union_id`：微信生态唯一标识
- `subscribe_status`：关注状态（1-已关注，2-取消关注）
- `subscribe_time`：关注时间
- `unsubscribe_time`：取消关注时间
- `nickname`：昵称
- `head_image_url`：头像地址
- `tag_ids`：标签编号数组（逗号分隔）

### mp_tag 表

公众号标签表包含以下重要字段：
- `id`：主键（非自增，需要手动指定）
- `tag_id`：公众号标签 id
- `name`：标签名
- `count`：此标签下粉丝数

### mp_material 表

公众号素材表包含以下重要字段：
- `media_id`：公众号素材 id
- `type`：文件类型（image、voice、video、thumb、news）
- `permanent`：是否永久（true-永久素材，false-临时素材）
- `url`：文件服务器的 URL
- `mp_url`：公众号文件 URL（只有永久素材使用）

### mp_menu 表

公众号菜单表包含以下重要字段：
- `name`：菜单名称
- `menu_key`：菜单标识
- `parent_id`：父菜单编号（0 表示顶级菜单）
- `type`：按钮类型（click、view、miniprogram 等）
- `url`：网页链接
- `reply_*`：回复消息相关字段

### mp_message 表

公众号消息表包含以下重要字段：
- `msg_id`：微信公众号消息 id
- `openid`：公众号粉丝标志
- `type`：消息类型（text、image、voice、video、location、link、event 等）
- `send_from`：消息来源（1-粉丝发送，2-公众号发送）
- `content`：消息内容（文本消息）
- `media_id`：媒体文件的编号
- `articles`：图文消息数组（JSON 格式）
- `event`：事件类型（subscribe、unsubscribe、CLICK、SCAN 等）
- `event_key`：事件 Key

### mp_message_template 表

公众号模版消息表包含以下重要字段：
- `template_id`：公众号模板 ID（唯一，与 account_id 组合）
- `title`：标题
- `content`：模板内容
- `example`：模板示例
- `primary_industry`：模板所属行业的一级行业
- `deputy_industry`：模板所属行业的二级行业

### mp_auto_reply 表

公众号消息自动回复表包含以下重要字段：
- `type`：回复类型（1-关注回复，2-关键词回复，3-消息回复）
- `request_keyword`：请求的关键字
- `request_match`：请求的关键字的匹配（1-完全匹配，2-包含匹配）
- `request_message_type`：请求的消息类型
- `response_message_type`：回复的消息类型
- `response_content`：回复的消息内容
- `response_articles`：回复的图文消息（JSON 格式）

## 表关系说明

```
mp_account (公众号账号)
    ↓
mp_user (微信公众号粉丝)
    ↓
mp_tag (公众号标签)
    ↓
mp_material (公众号素材)
    ↓
mp_menu (公众号菜单)
    ↓
mp_message (公众号消息)
    ↓
mp_message_template (公众号模版消息)
    ↓
mp_auto_reply (公众号消息自动回复)
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

### Q: mp_tag 表的 id 字段为什么不是自增？
A: `mp_tag` 表的 `id` 字段使用 `IdType.INPUT`，需要手动指定。通常使用 `account_id` 和 `tag_id` 的组合作为主键，或者使用其他业务规则生成。

### Q: 如何理解 openid 和 unionid？
A: 
- **openid**：用户在某个公众号下的唯一标识，不同公众号的 openid 不同
- **unionid**：用户在微信开放平台账号下的唯一标识，同一用户在不同公众号下的 unionid 相同（需要绑定到同一个开放平台账号）

### Q: 临时素材和永久素材的区别？
A: 
- **临时素材**：有效期 3 天，主要用于发送给粉丝
- **永久素材**：永久有效，主要用于群发消息和自定义菜单

### Q: 如何配置公众号账号？
A: 在 `mp_account` 表中添加公众号账号信息，包括：
- `app_id`：公众号的 AppID
- `app_secret`：公众号的 AppSecret
- `token`：公众号的 Token（用于验证消息）
- `aes_key`：消息加解密密钥（可选，用于加密模式）

## 数据初始化建议

执行 SQL 脚本后，建议初始化以下数据：

1. **公众号账号数据**：在 `mp_account` 表中添加公众号账号信息
2. **同步粉丝数据**：通过系统提供的同步功能，从微信服务器同步粉丝数据到 `mp_user` 表
3. **同步标签数据**：通过系统提供的同步功能，从微信服务器同步标签数据到 `mp_tag` 表
4. **配置自动回复**：在 `mp_auto_reply` 表中配置自动回复规则

## 性能优化建议

1. **索引优化**：脚本已创建常用查询字段的索引，如需优化，可以根据实际查询场景添加复合索引。

2. **消息表归档**：`mp_message` 表会随着时间增长而数据量增大，建议定期归档历史消息到历史表。

3. **素材表清理**：定期清理过期的临时素材，避免 `mp_material` 表数据过多。

4. **读写分离**：对于高并发场景，建议使用读写分离，将统计查询等读操作分流到从库。

