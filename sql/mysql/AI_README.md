# AI 模块表结构说明

## 概述

本 SQL 脚本用于创建 AI 模块（大模型，Artificial Intelligence）所需的所有数据库表。

AI 模块是用于管理 AI 模型、对话、绘画、音乐、写作、知识库等 AI 相关业务数据的核心模块。

## 包含的表

本脚本包含以下 14 张表：

### 模型和配置相关（4 张表）
1. **`ai_api_key`** - AI API 秘钥表
   - 存储 AI 平台的 API 秘钥信息，包括 OpenAI、Claude、通义千问等

2. **`ai_model`** - AI 模型表
   - 存储 AI 模型配置信息，包括模型名称、平台、类型、对话参数等
   - 核心业务表

3. **`ai_tool`** - AI 工具表
   - 存储 AI 工具信息，用于扩展 AI 能力（如天气查询、目录列表等）
   - 包含唯一索引：`uk_name`（工具名称）

4. **`ai_chat_role`** - AI 聊天角色表
   - 存储 AI 聊天角色配置，包括角色设定、关联的知识库、工具等

### 对话相关（2 张表）
5. **`ai_chat_conversation`** - AI 对话表
   - 存储用户与 AI 的对话会话信息
   - 包含对话标题、置顶状态、模型配置等

6. **`ai_chat_message`** - AI 消息表
   - 存储对话中的每条消息记录
   - 支持用户消息和 AI 回复消息

### 内容生成相关（4 张表）
7. **`ai_image`** - AI 绘画表
   - 存储 AI 绘画任务信息，支持 Midjourney、Stable Diffusion 等平台
   - 包含任务状态、图片地址、绘制参数等

8. **`ai_music`** - AI 音乐表
   - 存储 AI 音乐生成任务信息，支持 Suno 等平台
   - 包含音乐状态、音频/视频地址、风格标签等

9. **`ai_write`** - AI 写作表
   - 存储 AI 写作任务信息
   - 包含写作类型、生成内容、提示词配置等

10. **`ai_mind_map`** - AI 思维导图表
    - 存储 AI 生成的思维导图信息

### 知识库相关（3 张表）
11. **`ai_knowledge`** - AI 知识库表
    - 存储知识库的基本信息，包括名称、描述、向量模型配置等

12. **`ai_knowledge_document`** - AI 知识库文档表
    - 存储知识库中的文档信息
    - 包含文档内容、Token 数量、分片配置等

13. **`ai_knowledge_segment`** - AI 知识库文档分段表
    - 存储文档的分段信息，用于向量检索
    - 包含分段内容、向量 ID、Token 数量等

### 工作流相关（1 张表）
14. **`ai_workflow`** - AI 工作流表
    - 存储 AI 工作流配置信息
    - 包含唯一索引：`uk_code`（工作流标识）

## 使用方法

### 方式一：使用 MySQL 命令行

```bash
mysql -u root -p your_database < ruoyi-vue-pro/sql/mysql/ai_tables.sql
```

### 方式二：使用数据库客户端工具

1. 打开 Navicat、DBeaver、DataGrip 等数据库客户端工具
2. 连接到目标数据库
3. 打开 `ai_tables.sql` 文件
4. 执行 SQL 脚本

### 方式三：在 MySQL 客户端中执行

```sql
source /path/to/ruoyi-vue-pro/sql/mysql/ai_tables.sql;
```

## 注意事项

1. **执行前备份**：执行 SQL 脚本前，请确保已备份数据库，以防数据丢失。

2. **表已存在**：如果表已存在，脚本会先删除旧表再创建新表（使用 `DROP TABLE IF EXISTS`）。如果表中有数据，请先备份。

3. **多租户支持**：所有表都包含 `tenant_id` 字段，支持多租户功能。

4. **索引**：脚本已为常用查询字段创建了索引，包括：
   - 唯一索引：`uk_name`（工具名称）、`uk_code`（工作流标识）
   - 外键字段索引（如 `user_id`、`model_id`、`conversation_id`、`knowledge_id` 等）
   - 业务字段索引（如 `platform`、`status`、`type` 等）
   - 时间字段索引（如 `create_time`）

5. **JSON 字段**：部分表包含 JSON 格式的字段（如 `web_search_pages`、`options`、`buttons`、`tags` 等），这些字段使用 `text` 类型存储。

6. **List 字段**：部分字段存储 List 类型数据（如 `knowledge_ids`、`tool_ids`、`mcp_client_names`、`segment_ids`、`attachment_urls` 等），这些字段使用 `varchar` 类型，通过 TypeHandler 处理。

7. **Boolean 字段**：使用 `bit(1)` 类型，`NULL` 表示未设置，`b'0'` 表示 false，`b'1'` 表示 true。

8. **时间字段**：使用 `datetime` 类型，支持 `NULL`。

9. **文本字段**：部分字段使用 `text` 或 `longtext` 类型存储大量文本内容（如 `content`、`generated_content`、`graph` 等）。

## 验证

执行 SQL 脚本后，可以通过以下 SQL 验证表是否创建成功：

```sql
-- 检查 ai_ 开头的表
SHOW TABLES LIKE 'ai_%';

-- 查看表结构
DESC ai_model;
DESC ai_chat_conversation;
DESC ai_chat_message;
DESC ai_knowledge;

-- 查看表的记录数（应该都是 0）
SELECT COUNT(*) FROM ai_model;
SELECT COUNT(*) FROM ai_chat_conversation;
SELECT COUNT(*) FROM ai_chat_message;
SELECT COUNT(*) FROM ai_knowledge;
```

## 相关文档

- AI 模块文档：https://doc.iocoder.cn/ai/build/
- 芋道源码官网：https://www.iocoder.cn/

## 表结构说明

### 核心业务表

#### ai_model 表

AI 模型表是核心表，包含以下重要字段：
- `key_id`：API 秘钥编号
- `name`：模型名称
- `model`：模型标志
- `platform`：平台（如 openai、claude、qwen 等）
- `type`：类型（如 chat、embedding、image 等）
- `sort`：排序值（用于默认模型选择）
- `status`：状态
- `temperature`：温度参数（控制生成随机性）
- `max_tokens`：单条回复的最大 Token 数量
- `max_contexts`：上下文的最大 Message 数量

#### ai_chat_conversation 表

AI 对话表包含以下重要字段：
- `user_id`：用户编号
- `title`：对话标题（默认"新对话"）
- `pinned`：是否置顶
- `pinned_time`：置顶时间
- `role_id`：角色编号
- `model_id`：模型编号
- `model`：模型标志（冗余字段）
- `system_message`：角色设定
- `temperature`：温度参数
- `max_tokens`：单条回复的最大 Token 数量
- `max_contexts`：上下文的最大 Message 数量

#### ai_chat_message 表

AI 消息表包含以下重要字段：
- `conversation_id`：对话编号
- `reply_id`：回复消息编号（用于关联问答）
- `type`：消息类型（如 USER、ASSISTANT、SYSTEM 等）
- `user_id`：用户编号
- `role_id`：角色编号
- `model_id`：模型编号
- `content`：聊天内容
- `reasoning_content`：推理内容
- `use_context`：是否携带上下文
- `segment_ids`：知识库段落编号数组
- `web_search_pages`：联网搜索的网页内容数组（JSON 格式）
- `attachment_urls`：附件 URL 数组

#### ai_knowledge 表

AI 知识库表包含以下重要字段：
- `name`：知识库名称
- `description`：知识库描述
- `embedding_model_id`：向量模型编号
- `embedding_model`：模型标识（冗余字段）
- `top_k`：topK（检索返回的段落数量）
- `similarity_threshold`：相似度阈值
- `status`：状态

#### ai_knowledge_document 表

AI 知识库文档表包含以下重要字段：
- `knowledge_id`：知识库编号
- `name`：文档名称
- `url`：文件 URL
- `content`：内容（longtext 类型）
- `content_length`：文档长度
- `tokens`：文档 token 数量
- `segment_max_tokens`：分片最大 Token 数
- `retrieval_count`：召回次数

#### ai_knowledge_segment 表

AI 知识库文档分段表包含以下重要字段：
- `knowledge_id`：知识库编号
- `document_id`：文档编号
- `content`：切片内容
- `content_length`：切片内容长度
- `vector_id`：向量库的编号
- `tokens`：token 数量
- `retrieval_count`：召回次数

### 配置表

#### ai_api_key 表

AI API 秘钥表包含以下重要字段：
- `name`：名称
- `api_key`：密钥
- `platform`：平台（如 openai、claude、qwen 等）
- `url`：API 地址
- `status`：状态

#### ai_tool 表

AI 工具表包含以下重要字段：
- `name`：工具名称（对应 Bean 的名字，唯一）
- `description`：工具描述
- `status`：状态

#### ai_chat_role 表

AI 聊天角色表包含以下重要字段：
- `name`：角色名称
- `avatar`：角色头像
- `category`：角色分类
- `description`：角色描述
- `system_message`：角色设定
- `user_id`：用户编号（私有角色）
- `model_id`：模型编号
- `knowledge_ids`：引用的知识库编号列表
- `tool_ids`：引用的工具编号列表
- `mcp_client_names`：引用的 MCP Client 名字列表
- `public_status`：是否公开
- `sort`：排序值
- `status`：状态

### 内容生成表

#### ai_image 表

AI 绘画表包含以下重要字段：
- `user_id`：用户编号
- `prompt`：提示词
- `platform`：平台（如 midjourney、stability-ai 等）
- `model_id`：模型编号
- `model`：模型标识
- `width`：图片宽度
- `height`：图片高度
- `status`：生成状态
- `finish_time`：完成时间
- `error_message`：绘画错误信息
- `pic_url`：图片地址
- `public_status`：是否公开
- `options`：绘制参数（JSON 格式）
- `buttons`：mj buttons 按钮（JSON 格式）
- `task_id`：任务编号

#### ai_music 表

AI 音乐表包含以下重要字段：
- `user_id`：用户编号
- `title`：音乐名称
- `lyric`：歌词
- `image_url`：图片地址
- `audio_url`：音频地址
- `video_url`：视频地址
- `status`：音乐状态
- `generate_mode`：生成模式
- `description`：描述词
- `platform`：平台（如 suno 等）
- `model`：模型
- `tags`：音乐风格标签（JSON 格式）
- `duration`：音乐时长
- `public_status`：是否公开
- `task_id`：任务编号
- `error_message`：错误信息

#### ai_write 表

AI 写作表包含以下重要字段：
- `user_id`：用户编号
- `type`：写作类型
- `platform`：平台
- `model_id`：模型编号
- `model`：模型
- `prompt`：生成内容提示
- `generated_content`：生成的内容
- `original_content`：原文
- `length`：长度提示词
- `format`：格式提示词
- `tone`：语气提示词
- `language`：语言提示词
- `error_message`：错误信息

#### ai_mind_map 表

AI 思维导图表包含以下重要字段：
- `user_id`：用户编号
- `platform`：平台
- `model_id`：模型编号
- `model`：模型
- `prompt`：生成内容提示
- `generated_content`：生成的内容
- `error_message`：错误信息

#### ai_workflow 表

AI 工作流表包含以下重要字段：
- `name`：工作流名称
- `code`：工作流标识（唯一）
- `graph`：工作流模型 JSON 数据（longtext 类型）
- `remark`：备注
- `status`：状态

## 表关系说明

```
ai_api_key (API 秘钥)
    ↓
ai_model (AI 模型)
    ↓
ai_chat_role (AI 聊天角色) → 关联 → ai_knowledge (知识库), ai_tool (工具)
    ↓
ai_chat_conversation (AI 对话)
    ↓
ai_chat_message (AI 消息) → 关联 → ai_knowledge_segment (知识库段落)

ai_knowledge (知识库)
    ↓
ai_knowledge_document (知识库文档)
    ↓
ai_knowledge_segment (知识库文档分段)

ai_image (AI 绘画)
ai_music (AI 音乐)
ai_write (AI 写作)
ai_mind_map (AI 思维导图)
ai_workflow (AI 工作流)
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
A: List 字段使用 `varchar` 或 `text` 类型存储，通过 MyBatis Plus 的 TypeHandler（如 `LongListTypeHandler`、`StringListTypeHandler`）自动处理序列化和反序列化。

### Q: 知识库是如何工作的？
A: 
- 知识库（`ai_knowledge`）是文档的容器
- 文档（`ai_knowledge_document`）上传后会被切分成多个段落
- 段落（`ai_knowledge_segment`）会被向量化并存储到向量库
- 在对话时，系统会根据用户问题检索相关的段落，作为上下文提供给 AI 模型

### Q: 对话和消息的关系？
A: 
- 对话（`ai_chat_conversation`）是一个会话容器，用户可以创建多个对话
- 消息（`ai_chat_message`）是对话中的每条消息记录
- 一个对话可以包含多条消息，通过 `conversation_id` 关联

### Q: 角色和对话的关系？
A: 
- 角色（`ai_chat_role`）定义了 AI 的行为和设定
- 对话（`ai_chat_conversation`）可以关联一个角色
- 角色可以关联知识库和工具，扩展 AI 的能力

### Q: 绘画任务的状态如何管理？
A: 
- 绘画任务（`ai_image`）通过 `status` 字段管理状态（如生成中、已完成、失败等）
- 对于异步任务（如 Midjourney），通过 `task_id` 关联外部任务
- 任务完成后，`pic_url` 字段会存储生成的图片地址

### Q: 音乐任务的状态如何管理？
A: 
- 音乐任务（`ai_music`）通过 `status` 字段管理状态
- 对于异步任务（如 Suno），通过 `task_id` 关联外部任务
- 任务完成后，`audio_url` 和 `video_url` 字段会存储生成的音频/视频地址

### Q: 工作流是如何存储的？
A: 
- 工作流（`ai_workflow`）通过 `graph` 字段存储工作流模型 JSON 数据
- `code` 字段是工作流的唯一标识，用于程序调用

## 数据初始化建议

执行 SQL 脚本后，建议初始化以下数据：

1. **API 秘钥数据**：在 `ai_api_key` 表中添加各平台的 API 秘钥信息
2. **AI 模型数据**：在 `ai_model` 表中添加常用的 AI 模型配置
3. **AI 工具数据**：在 `ai_tool` 表中添加可用的 AI 工具
4. **聊天角色数据**：在 `ai_chat_role` 表中添加公开的聊天角色

## 性能优化建议

1. **索引优化**：脚本已创建常用查询字段的索引，如需优化，可以根据实际查询场景添加复合索引。

2. **数据归档**：对于历史数据（如旧的对话、消息等），建议定期归档到历史表，避免主表数据过多。

3. **分表策略**：对于数据量特别大的表（如 `ai_chat_message`），可以考虑按时间分表。

4. **读写分离**：对于高并发场景，建议使用读写分离，将统计查询等读操作分流到从库。

5. **缓存策略**：对于配置表（如 `ai_model`、`ai_tool`、`ai_chat_role` 等），建议使用缓存，减少数据库查询。

6. **向量库优化**：知识库的向量数据通常存储在专门的向量数据库中（如 Milvus、Pinecone 等），`ai_knowledge_segment` 表的 `vector_id` 字段用于关联向量库中的向量。

7. **文本字段优化**：对于包含大量文本的字段（如 `content`、`generated_content` 等），可以考虑使用全文索引或搜索引擎（如 Elasticsearch）来提升检索性能。

## 业务流程说明

### 对话流程

1. 用户创建对话（`ai_chat_conversation`），选择角色和模型
2. 用户发送消息（`ai_chat_message`，type=USER）
3. 系统根据对话配置和上下文，调用 AI 模型生成回复
4. AI 回复消息（`ai_chat_message`，type=ASSISTANT）
5. 如果角色关联了知识库，系统会先检索相关知识库段落，作为上下文

### 知识库流程

1. 创建知识库（`ai_knowledge`），配置向量模型和检索参数
2. 上传文档（`ai_knowledge_document`），系统解析文档内容
3. 文档切分成多个段落（`ai_knowledge_segment`）
4. 段落向量化并存储到向量库
5. 在对话时，根据用户问题检索相关段落，作为上下文

### 绘画流程

1. 用户创建绘画任务（`ai_image`），输入提示词
2. 系统调用绘画平台 API，创建任务
3. 任务状态更新为"生成中"，记录 `task_id`
4. 系统定时轮询任务状态（或通过回调）
5. 任务完成后，更新状态为"已完成"，存储图片地址

### 音乐流程

1. 用户创建音乐任务（`ai_music`），输入描述词
2. 系统调用音乐平台 API，创建任务
3. 任务状态更新为"生成中"，记录 `task_id`
4. 系统定时轮询任务状态（或通过回调）
5. 任务完成后，更新状态为"已完成"，存储音频/视频地址

