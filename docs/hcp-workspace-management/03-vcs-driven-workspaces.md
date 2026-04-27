# 03 VCS 驱动的 Workspaces

## 目标

学会把 `Ghostwritten/terraform-demo` 连接到 HCP Terraform，并为每个 workspace 配置明确的 `working directory`。

## 核心概念

- VCS-driven workflow 是当前主线。
- 一个 workspace 连接一个仓库分支，并通过 `working directory` 指向具体 root module。
- HCP Terraform 可以基于仓库变更自动触发 runs。

## 操作步骤

1. 阅读官方文档：
   [Configure workspace VCS connections](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/vcs)
2. 在 HCP Terraform 中连接 GitHub 仓库 `Ghostwritten/terraform-demo`
3. 创建并配置以下 workspaces：
   - `aliyun-network-dev`
     - Project: `platform-foundation`
     - Working directory: `foundation/resource-group`
   - `aliyun-app-dev`
     - Project: `application-delivery`
     - Working directory: `.`
   - `aliyun-app-scale-lab`
     - Project: `application-delivery`
     - Working directory: `.`
   - `aliyun-import-lab`
     - Project: `platform-foundation`
     - Working directory: `resource-group`
4. 统一使用主分支做教学，除非某一节明确要求实验分支。

## 观察点

- 根目录和子目录都可以作为 workspace 的 working directory。
- 相同仓库被不同 workspace 复用时，变量和 state 仍然彼此隔离。

## 常见坑

- working directory 配错，导致 workspace 跑了错误 root module。
- 以为同仓库意味着共享变量或共享 state。
- VCS webhook 没跑起来时，没有先手动触发一次 run 完成初始化。

## 成本与清理

- 先创建 workspace 和 VCS 连接，不急着立即 apply 付费资源。
- 首次验证优先用 `aliyun-network-dev` 或 `aliyun-import-lab`。

## 复盘结论

- 多 workspace 复用一个仓库时，working directory 是最关键的定位开关。
