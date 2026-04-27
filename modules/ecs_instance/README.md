# ecs_instance module

这个模块用于教学场景下的最小 ECS 实战：

- 创建一个专用安全组
- 按需开放 SSH / HTTP
- 创建 1 台或多台 ECS
- 输出实例 ID 与 IP 地址

为了降低学习成本，模块不负责创建 VPC 和 vSwitch，而是要求传入已有网络资源的 ID。这样可以把注意力集中在 Terraform 工作流、输入输出、模块化和变更管理上。
