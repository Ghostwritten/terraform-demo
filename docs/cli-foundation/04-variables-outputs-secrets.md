# 04 变量、输出与敏感信息

## 目标

把“写死参数”改成“可解释、可复用、可安全管理”的输入输出体系。

## 核心概念

- 所有 variable 都要有 `type` 和 `description`。
- 所有 output 都要有 `description`。
- 密码等敏感信息不能直接写进 Git。
- `terraform.tfvars.example` 只放示例，不放真实凭证。

## 操作步骤

```bash
cp envs/dev/terraform.tfvars.example envs/dev/terraform.tfvars
terraform output
terraform output instance_id
```

## 观察点

- 在 CLI 线中，变量主要来自 `tfvars` 和环境变量。
- 到 HCP 线时，这些输入会迁移到 workspace variables 和 variable sets。

## 代码片段

```hcl
variable "instance_password" {
  type      = string
  sensitive = true
}
```

## 常见坑

- 待补充：把真实密码提交到 Git。
- 待补充：变量名含义不清，后续维护困难。

## 成本与清理

- 正确的变量化能减少误创建和重复试错，从而间接节省费用。

## 复盘结论

- Terraform 里的变量设计，本质上是在设计基础设施接口。
