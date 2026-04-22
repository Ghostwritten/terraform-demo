# 05 Data Source 与 Import

## 目标

区分“查询现有资源”和“把现有资源接入 Terraform 管理”这两件不同的事。

## 核心概念

- Data source 用来读，不负责创建资源。
- Import 用来把已有资源写入 state 的地址映射。
- Import 之前必须先有目标 `resource` 地址。

## 操作步骤

```bash
terraform plan -var-file=envs/dev/terraform.tfvars
terraform import <address> <id>
terraform state list
```

## 观察点

- Import 是后续 HCP `aliyun-import-lab` 的重要前置知识。
- 先在本地理解地址映射，再去平台上看导入后的远程状态更稳妥。

## 代码片段

```hcl
import {
  to = alicloud_resource_manager_resource_group.this[0]
  id = "rg-xxxxxxxx"
}
```

## 常见坑

- 待补充：导入地址写错，导致资源映射错位。
- 待补充：导入后的配置与真实资源不一致，下一次 `plan` 出现大变更。

## 成本与清理

- Import 本身不新增资源，但错误的后续 `apply` 可能导致替换资源。
- Import 演练建议优先从资源组开始，风险最低。

## 复盘结论

- Query 和 import 是 Terraform 新手最容易混淆的一组概念，必须单独训练。
