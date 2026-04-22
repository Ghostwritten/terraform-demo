# 01 HCP Workspace 与 CLI Workspace

## 目标

彻底区分 HCP Terraform workspaces 和 Terraform CLI workspaces，避免后续平台学习出现概念错位。

## 核心概念

- CLI workspace 是同一工作目录下的多份 state。
- HCP workspace 是一个完整的基础设施工作单元，包含配置来源、变量、状态、运行历史和权限边界。
- HashiCorp 官方并不推荐用 CLI workspaces 处理复杂环境隔离；复杂场景更适合目录、独立 root module 或 HCP workspaces。

## 操作步骤

1. 阅读官方文档：
   - [HCP Terraform workspaces](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)
   - [Terraform CLI workspaces](https://developer.hashicorp.com/terraform/cli/workspaces)
2. 对照本仓库理解：
   - 根目录是一个 root module
   - `foundation/resource-group/` 是另一个 root module
   - 它们未来会分别映射到不同 HCP workspaces
3. 记录下两个关键区别：
   - 执行位置
   - state 所在位置

## 观察点

- 在 HCP 中，一个 workspace 更接近“一个受治理的 Terraform 项目单元”。
- CLI workspace 不会给你 run history、VCS 触发、project 权限或 variable sets。

## 常见坑

- 用 CLI workspace 模拟团队多项目管理。
- 以为 HCP workspace 只是 CLI workspace 的“云端版本”。

## 成本与清理

- 本节只做概念对照，不需要创建云资源。

## 复盘结论

- 后续所有 HCP 设计都建立在“一个 workspace 对应一个清晰职责的 root module”这个原则之上。
