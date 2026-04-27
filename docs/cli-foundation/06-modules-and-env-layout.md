# 06 模块与环境目录

## 目标

理解为什么 Terraform 项目不能长期停留在一个 `main.tf`，以及为什么当前仓库使用 `modules/` 和 `envs/`。

## 核心概念

- 根模块负责组装。
- 子模块负责封装可复用能力。
- 环境隔离优先使用目录，而不是把 CLI workspace 当主线。

## 操作步骤

```bash
tree -L 2 .
terraform plan -var-file=envs/dev/terraform.tfvars
```

## 观察点

- 根目录和 `foundation/resource-group/` 都是可独立运行的 root module。
- HCP workspaces 会依赖这些目录边界来配置 working directory。

## 代码片段

```hcl
module "ecs_instance" {
  source = "./modules/ecs_instance"
}
```

## 常见坑

- 待补充：根模块和子模块职责不清。
- 待补充：多个环境复用时把变量文件搞混。

## 成本与清理

- 良好的模块和环境结构能减少误操作，避免把 dev 当 prod 操作。

## 复盘结论

- Terraform 的可维护性，往往取决于你是否在项目早期就开始模块化。
