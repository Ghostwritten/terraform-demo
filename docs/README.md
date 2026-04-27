# Docs 导航

本仓库的学习体系现在分成两条并行主线，共用同一个代码仓库和同一套阿里云实验约束，但学习目标不同。

- `docs/cli-foundation/`
  学本地 Terraform CLI、代码结构、模块、state、plan、import 和低成本阿里云实操。
- `docs/hcp-workspace-management/`
  学 HCP Terraform 平台上的 project、workspace、VCS、变量集、远程运行、run triggers 和多工作区协作。

## 推荐学习顺序

1. 先读 [CLI 总览](/Users/zongxun/github/terraform-demo/docs/cli-foundation/00-overview.md)
2. 完成 CLI 线第 1-4 节，至少理解：
   - `init` / `validate` / `plan` / `apply` / `destroy`
   - state 的作用
   - 根模块与子模块的关系
   - 阿里云单节点实验的输入输出
3. 再进入 [HCP 总览](/Users/zongxun/github/terraform-demo/docs/hcp-workspace-management/00-overview.md)
4. 按顺序完成 HCP 线的 workspace、VCS、变量集、run triggers 和治理内容

## 统一文档模板

两条学习线的每篇文档都使用统一结构：

- 目标
- 核心概念
- 操作步骤
- 观察点
- 常见坑
- 成本与清理
- 复盘结论

## 两条线之间的关系

- CLI 线回答“Terraform 代码怎么写、怎么理解变更、怎么安全地本地练习”
- HCP 线回答“这些 Terraform root module 怎么在 `app.terraform.io` 里被组织、触发和治理”
- HCP workspaces 会直接复用本仓库中的 root module 和历史成功样例

## 当前仓库中的目录映射

- 根目录：主应用实验 root module，适合 `aliyun-app-dev`
- `foundation/resource-group/`：最小 foundation root module，适合 `aliyun-network-dev`
- `ecs/`、`resource-group/`：你已在 HCP Terraform 跑通的历史样例，适合作为平台对照实验

## 专项 Runbook

- [销毁 terraform-offline-aliyun-ecs](/Users/zongxun/github/terraform-demo/docs/hcp-workspace-management/09-destroy-terraform-offline-aliyun-ecs.md)
