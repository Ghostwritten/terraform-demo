# 08 运维治理与成本控制

## 目标

为 HCP Terraform 学习线建立最小但完整的治理纪律，确保实验可回溯、可清理、可控费。

## 核心概念

- Project 是权限和变量范围的组织边界。
- Workspace lock、run history、state versions 是排错和防误操作的重要工具。
- 低成本学习不等于不做实验，而是把付费资源控制在最少、最短、最可回滚的范围内。

## 操作步骤

1. 为每个 workspace 补一张固定清单：
   - 仓库来源
   - working directory
   - 变量来源
   - 运行模式
   - 销毁入口
2. 明确默认策略：
   - `aliyun-network-dev` 可长期保留低成本基础对象
   - `aliyun-app-dev` 仅用于单节点实验
   - `aliyun-app-scale-lab` 只做短时扩缩容
   - `aliyun-import-lab` 只做导入和对照练习
3. 记录扩展阅读，但不纳入主任务：
   - API
   - `tfe` provider
   - Stacks

## 观察点

- 平台治理关注的是“谁能改、怎么改、出了问题怎么看回去”。
- 付费版能力不是当前主线前提，免费或基础能力也足够支撑这套教学路线。

## 常见坑

- 一开始就把 auto-apply 打开。
- 没有区分长期基础资源和短时实验资源。
- 只关心运行成功，不做 destroy 和控制台核对。

## 成本与清理

- 默认只允许 1 台活跃 ECS。
- `aliyun-app-scale-lab` 运行结束后立即 destroy。
- 完成实验后在阿里云控制台核对实例、安全组和资源组状态。

## 复盘结论

- 学 HCP Terraform，最终不是学会点按钮，而是学会如何把 Terraform 放进一个低风险、可追踪的团队工作流里。

## 专项 Runbook

- [销毁 terraform-offline-aliyun-ecs](/Users/zongxun/github/terraform-demo/docs/hcp-workspace-management/09-destroy-terraform-offline-aliyun-ecs.md)
