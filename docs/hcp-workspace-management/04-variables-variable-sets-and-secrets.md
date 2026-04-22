# 04 Variables、Variable Sets 与 Secrets

## 目标

学会在 HCP Terraform 中正确放置阿里云凭证、workspace 输入和项目级复用变量。

## 核心概念

- Workspace variables 适合单个 workspace 独有的值。
- Variable sets 适合项目级共享的变量，例如云凭证和统一标签。
- Sensitive variables 应放在 HCP Terraform 中，不应写入 Git 仓库。

## 操作步骤

1. 阅读：
   - [HCP Terraform workspaces](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)
   - [Manage workspace state](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)
2. 为阿里云凭证建立 project-scoped variable set：
   - `ALICLOUD_ACCESS_KEY`
   - `ALICLOUD_SECRET_KEY`
3. 为 `aliyun-app-dev` 设置 workspace-specific 变量：
   - `vpc_id`
   - `vswitch_id`
   - `instance_password`
4. 为 `aliyun-app-scale-lab` 单独设置：
   - `instance_count = 2`
   - `enable_scale_lab = true`
5. 记录哪些变量应该放仓库示例文件，哪些只能放 HCP。

## 观察点

- 同样的 Terraform 代码，到了 HCP 平台后，变量管理从 `.tfvars` 转成了 workspace / variable set。
- 凭证不进仓库，平台治理才有意义。

## 常见坑

- 把真实密码留在 `terraform.tfvars.example` 里。
- project 级变量和 workspace 级变量没有区分，导致复用混乱。

## 成本与清理

- 变量配置本身不产生费用。
- 但错误变量会触发错误资源创建，所以改变量前先看计划变更。

## 复盘结论

- HCP Terraform 中的变量管理，本质上是在做“输入治理”，不只是把 `.tfvars` 搬个地方。
