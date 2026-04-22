# 00 HCP 学习线总览

## 目标

理解这条学习线是围绕 `app.terraform.io` 的平台能力展开，而不是继续学习本地 Terraform CLI 命令。

## 核心概念

- HCP Terraform workspace 不是 Terraform CLI workspace。
- HCP Terraform 更关心项目、工作区、远程运行、状态托管、VCS 触发和团队治理。
- 本仓库会被同一个 HCP Terraform organization 下的多个 workspace 复用。
- 当前阶段主线是 `Workspace/UI + VCS`，不是 API 自动化，也不是 Stacks。

## 操作步骤

1. 先完成 CLI 线前 1-4 节。
2. 打开 HCP Terraform 官方 workspace 文档：
   [HCP Terraform workspaces](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)
3. 用本仓库建立一个心智模型：
   - 代码在 GitHub 仓库
   - 工作区在 HCP Terraform
   - 变量和状态放在 HCP Terraform
   - 执行默认在 HCP Terraform 远程环境

## 观察点

- 本地工作目录和 HCP workspace 解决的是相同问题，但承载位置不同。
- HCP 平台会额外保存 run history、state versions、变量和权限关系。

## 常见坑

- 把 HCP workspace 和 CLI workspace 混为一谈。
- 还没掌握本地 `plan`/`state`，就直接进入平台治理。
- 以为 HCP 线必须从 API 或 `tfe` provider 开始。

## 成本与清理

- 这一节不创建资源。
- 先建立平台认知，再决定要不要创建 workspace 和连接 VCS。

## 复盘结论

- HCP 线学的不是“再跑一遍 Terraform”，而是“如何把多个 Terraform root module 组织成可协作的平台工作流”。
