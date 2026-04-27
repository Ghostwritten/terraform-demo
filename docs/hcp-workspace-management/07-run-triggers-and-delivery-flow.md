# 07 Run Triggers 与交付流

## 目标

理解 `network -> app` 这条多 workspace 交付链如何在 HCP Terraform 中自动衔接。

## 核心概念

- Run trigger 允许一个 source workspace apply 成功后自动排队触发另一个 workspace 的 run。
- 它适合表达“上游基础设施变化会影响下游应用配置”的关系。
- 当前教学主链是：
  `aliyun-network-dev` -> `aliyun-app-dev`

## 操作步骤

1. 阅读：
   [Connect workspaces with run triggers](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-run-triggers)
2. 在 HCP Terraform 中将 `aliyun-network-dev` 设置为 source workspace。
3. 将 `aliyun-app-dev` 设为 downstream workspace。
4. 完成一次上游 apply，观察下游是否自动排队运行。
5. 记录触发前后两个 workspace 的差异和日志。

## 观察点

- Run trigger 表达的是工作流依赖，不是变量传递。
- 只有 source workspace 成功 apply 后，下游才会被触发。

## 常见坑

- 以为 run trigger 会自动共享变量或 state。
- 上游没有成功 apply，却期待下游自动运行。
- 把扩缩容实验 workspace 也接入自动触发链，放大成本风险。

## 成本与清理

- 默认只对 `aliyun-network-dev -> aliyun-app-dev` 建立 run trigger。
- `aliyun-app-scale-lab` 不进入自动触发链，保持手工受控运行。

## 复盘结论

- HCP 平台里的 run trigger，解决的是跨 workspace 的交付顺序问题，而不是 Terraform 语法问题。
