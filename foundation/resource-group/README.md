# foundation/resource-group

这是一个最小的 foundation root module，供 HCP Terraform 的 `aliyun-network-dev` workspace 使用。

它只管理资源组，不创建 ECS、网络或其他付费计算资源，目的有两个：

- 为 HCP 学习线提供一个低风险、低成本、可长期保留的 foundation workspace
- 让 `network/app` 两层 workspace 的职责边界在平台上更清晰

推荐的 HCP Terraform 映射：

- Project: `platform-foundation`
- Workspace: `aliyun-network-dev`
- Working directory: `foundation/resource-group`
