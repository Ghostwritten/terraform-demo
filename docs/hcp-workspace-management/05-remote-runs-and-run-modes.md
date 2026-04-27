# 05 远程运行与 Run 模式

## 目标

掌握 HCP Terraform 的远程执行模型，能读懂 run 页面、日志、状态版本和不同 run mode 的区别。

## 核心概念

- Remote execution 是默认模式。
- 标准 run 会先 plan 再 apply。
- Destroy mode 会生成全量销毁计划。
- HCP 平台会保存 run history 和 state versions。

## 操作步骤

1. 阅读官方文档：
   - [Run modes and options](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/modes-and-options)
   - [Manage and view runs](https://developer.hashicorp.com/terraform/cloud-docs/run/manage)
2. 在 `aliyun-network-dev` 先跑一次低风险 run。
3. 观察 run 页面中的：
   - 代码来源
   - plan 输出
   - apply 日志
   - 状态变更
4. 再在 `aliyun-app-dev` 运行一次标准 plan/apply。
5. 单独演练一次 destroy mode，但仅在确认资源可销毁后进行。

## 观察点

- HCP 平台的 run 记录比本地 CLI 更适合复盘和教学。
- state versions 是理解“平台托管 state”的关键观察面。

## 常见坑

- 没看 plan 就直接 apply。
- 一开始就对 compute workspace 打开高风险自动 apply。
- 把 remote runs 当成纯日志展示，而没有理解它是默认执行环境。

## 成本与清理

- `aliyun-network-dev` 先跑低成本资源组实验。
- `aliyun-app-dev` 完成单机实验后，立即安排 destroy 验证。

## 复盘结论

- HCP Terraform 的 run 页面本身就是教学材料，尤其适合学习变更审查和运行历史。
