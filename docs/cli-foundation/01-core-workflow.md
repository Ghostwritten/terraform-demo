# 01 核心工作流

## 目标

掌握 Terraform 最基础的工作流：`init`、`fmt`、`validate`、`plan`、`apply`、`destroy`。

## 核心概念

- `init` 安装 provider 和模块。
- `fmt` 统一代码风格。
- `validate` 校验语法和内部一致性。
- `plan` 预览变更。
- `apply` 执行变更。
- `destroy` 销毁资源，避免费用持续产生。
- 这条线只关注本地 CLI 工作流，不讨论 HCP workspace、project 或 run triggers。

## 操作步骤

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -var-file=envs/dev/terraform.tfvars
terraform apply -var-file=envs/dev/terraform.tfvars
terraform destroy -var-file=envs/dev/terraform.tfvars
```

## 代码片段

```hcl
terraform {
  required_version = ">= 1.7.0"
}
```

## 观察点

- 本地 `plan` 是后续理解 HCP run 页面最重要的基础。
- `validate` 和 `fmt` 应该先于任何真实 `apply`。

## 常见坑

- 待补充：例如忘记 `init` 就直接 `plan`。
- 待补充：例如没有 `destroy` 导致资源持续计费。

## 成本与清理

- 这一节尽量只跑 `fmt`、`validate`、`plan`。
- 真实 `apply` 之前，先确认 `create_ecs = false`。

## 复盘结论

- Terraform 的关键不是“写完就 apply”，而是先看清楚 plan 再行动。
