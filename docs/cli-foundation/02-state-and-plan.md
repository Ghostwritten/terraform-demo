# 02 State 与 Plan

## 目标

理解 Terraform 为什么必须有 state，以及 state 如何影响 `plan`、`apply` 和 `destroy`。

## 核心概念

- `terraform.tfstate` 保存 Terraform 管理对象和云资源的绑定关系。
- `plan` 会对比配置、state 和真实云上资源，决定下一步动作。
- state 默认是本地文件，适合个人学习；团队场景更适合远程后端。

## 操作步骤

```bash
terraform state list
terraform state show <address>
terraform plan -var-file=envs/dev/terraform.tfvars
```

## 观察点

- `plan` 不只是看“会不会新增资源”，还要看 Terraform 为什么这么判断。
- 学懂本地 state 后，才容易理解 HCP Terraform 的 workspace state versions。

## 代码片段

```hcl
output "resource_group_id" {
  value = local.resource_group_id
}
```

## 常见坑

- 待补充：误删 state 文件后的表现。
- 待补充：手工改云资源导致 drift 的表现。

## 成本与清理

- state 是元数据，不会单独收费。
- 但错误 state 会导致重复创建资源，所以销毁前后都要检查 `plan`。

## 复盘结论

- 学 Terraform 时，state 不是附属知识，而是核心知识。
