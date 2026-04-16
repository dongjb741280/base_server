# 支付模块表结构导入说明

## 问题说明

如果遇到以下错误：
```
[支付模块 yudao-module-pay - 表结构未导入][参考 https://cloud.iocoder.cn/pay/build/ 开启]
```

这表示数据库中缺少支付模块的表结构。

## 解决方案

### 1. 执行 SQL 脚本

在数据库中执行 `pay_tables.sql` 文件：

```bash
# MySQL 命令行方式
mysql -u root -p your_database < sql/mysql/pay_tables.sql

# 或者使用数据库客户端工具（如 Navicat、DBeaver 等）直接执行 SQL 文件
```

### 2. 需要创建的表

支付模块包含以下业务表（共 14 张表）：

#### 核心支付表
- `pay_app` - 支付应用表
- `pay_channel` - 支付渠道表
- `pay_order` - 支付订单表
- `pay_order_extension` - 支付订单拓展表
- `pay_refund` - 退款订单表
- `pay_transfer` - 转账单表

#### 通知相关表
- `pay_notify_task` - 支付通知任务表
- `pay_notify_log` - 支付通知日志表

#### 钱包相关表
- `pay_wallet` - 会员钱包表
- `pay_wallet_recharge` - 会员钱包充值表
- `pay_wallet_recharge_package` - 会员钱包充值套餐表
- `pay_wallet_transaction` - 会员钱包流水表

#### 示例表（可选）
- `pay_demo_order` - 示例订单表
- `pay_demo_withdraw` - 示例提现订单表

### 3. 多租户支持

所有表都已包含 `tenant_id` 字段，支持多租户功能。

### 4. 验证

执行完 SQL 脚本后，重启应用，错误应该消失。

如果仍有问题，请检查：
1. 数据库连接配置是否正确
2. 是否有执行权限
3. 表是否成功创建（可以通过 `SHOW TABLES LIKE 'pay_%';` 查看）

## 参考文档

- 支付模块文档：https://cloud.iocoder.cn/pay/build/
- 支付模块 GitHub：https://github.com/YunaiV/ruoyi-vue-pro


