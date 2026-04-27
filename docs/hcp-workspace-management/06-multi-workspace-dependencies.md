# 06 多 Workspace 依赖

## 目标

学会在多个 HCP workspaces 之间表达依赖关系，并理解什么时候优先使用 provider data source，什么时候才考虑 `terraform_remote_state`。

## 核心概念

- 多 workspace 协作不是简单复制变量，而是设计明确依赖链。
- 优先使用 provider data source 获取共享基础设施。
- `terraform_remote_state` 只作为受控教学项，用来理解 workspace 输出共享。

## 操作步骤

1. 先建立教学依赖链：
   - `aliyun-network-dev` 产出 `resource_group_id`
   - `aliyun-app-dev` 消费网络或资源组相关信息
2. 第一阶段优先在文档中演示 data source 思路。
3. 第二阶段再解释：
   - HCP 平台如何共享远程 state 输出
   - 为什么官方也建议优先使用 provider data source
4. 阅读：
   [Manage workspace state](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)

## 观察点

- data source 更贴近真实云资源查询。
- `terraform_remote_state` 更适合解释 workspace 输出共享，但也会引入状态依赖耦合。

## 常见坑

- 一上来就用 remote state，把依赖链做得很脆。
- 没有先明确“谁生产、谁消费、消费什么”。

## 成本与清理

- 依赖关系设计本身不花钱，但错误依赖会放大误操作的影响范围。
- 先在 foundation 侧稳定输出，再让 app 侧消费。

## 复盘结论

- 多 workspace 管理的关键不是把 workspace 连起来，而是把依赖边界设计正确。
