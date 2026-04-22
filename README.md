# terraform-demo

这是一个面向 0 基础学习者的 Terraform 教学项目，目标是先掌握通用 Terraform 工作流，再把这些能力落到阿里云低成本实战中，并进一步学习如何在 HCP Terraform 上做多 workspace / 多 project 管理。

项目默认遵循三个约束：

- 任一时刻默认只保留 1 台活跃 ECS。
- 优先通过 `plan`、`validate`、`console` 学习，只有在需要真实验证时才 `apply`。
- 每一次真实创建资源后，都要记录资源清单、预估费用、销毁命令和复盘笔记。

仓库同时保留了两份你已经在 HCP Terraform 跑通的历史成功样例：

- [ecs/main.tf](/Users/zongxun/github/terraform-demo/ecs/main.tf)
- [resource-group/main.tf](/Users/zongxun/github/terraform-demo/resource-group/main.tf)

它们现在作为“已验证基线”保留，用于对照学习；新的教学主线仍然以根模块、`foundation/resource-group/`、`modules/`、`envs/dev/` 和 `docs/` 为准。

## 仓库结构

```text
.
├── docs/                    # CLI 与 HCP 双主线学习笔记
├── envs/dev/                # dev 环境示例变量、导入练习和运行说明
├── foundation/resource-group/ # 最小 foundation root module
├── modules/ecs_instance/    # 第一个自建模块
├── main.tf                  # 根模块，组合资源组和 ECS 模块
├── outputs.tf               # 根模块输出
├── providers.tf             # Provider 配置
├── terraform.tf             # Terraform / provider 版本约束
└── variables.tf             # 根模块输入
```

## 学习路线

学习路线已经拆成两条并行主线：

1. [CLI 基础线](/Users/zongxun/github/terraform-demo/docs/cli-foundation/00-overview.md)
   学本地 Terraform CLI、代码结构、state、plan、模块、import 和阿里云单节点实验。
2. [HCP Workspace 管理线](/Users/zongxun/github/terraform-demo/docs/hcp-workspace-management/00-overview.md)
   学 `app.terraform.io` 上的 project、workspace、VCS、变量集、远程运行、run triggers 和治理。

专项 runbook：

- [销毁 terraform-offline-aliyun-ecs](/Users/zongxun/github/terraform-demo/docs/hcp-workspace-management/09-destroy-terraform-offline-aliyun-ecs.md)

建议学习节奏：

1. 先读 [docs/README.md](/Users/zongxun/github/terraform-demo/docs/README.md)
2. 完成 CLI 线第 1-4 节
3. 再进入 HCP 线
4. 每完成一个模块，补全对应笔记中的“常见坑”和“复盘结论”

## 运行前准备

1. 安装 Terraform CLI，建议版本 `>= 1.7.0`
2. 配置阿里云凭证，推荐使用环境变量

```bash
export ALICLOUD_ACCESS_KEY="your-ak"
export ALICLOUD_SECRET_KEY="your-sk"
```

3. 复制 dev 环境示例变量

```bash
cp envs/dev/terraform.tfvars.example envs/dev/terraform.tfvars
```

4. 按需填写：

- `region`
- `resource_group_name`
- `vpc_id`
- `vswitch_id`
- `instance_password`

## 推荐命令

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -var-file=envs/dev/terraform.tfvars
terraform apply -var-file=envs/dev/terraform.tfvars
terraform destroy -var-file=envs/dev/terraform.tfvars
```

## 低成本练习建议

- 模块 1 只做 `fmt`、`validate`、`console`，不创建资源。
- 模块 2 只创建资源组。
- 模块 3 再打开 `create_ecs = true`，验证 Nginx 和输出。
- 模块 7 如需 `instance_count > 1`，只做短时演练，结束后立即 `destroy`。

## 当前实现包含什么

- 根模块可按开关创建资源组和 ECS
- `foundation/resource-group/` 提供了一个低成本 foundation root module，适合 `aliyun-network-dev`
- ECS 模块会创建专用安全组，并按需开放 SSH / HTTP
- 已加入输入校验和 `check` 规则，限制默认只创建 1 台 ECS
- 已提供 `envs/dev/imports.tf.example` 作为导入练习模板
- `docs/` 已拆成 CLI 与 HCP 两条学习主线

## 尚未自动化完成的部分

由于当前环境未安装 Terraform CLI，本次改造没有实际生成 `.terraform.lock.hcl`，也没有执行 `terraform validate`。等本机安装 Terraform 后，先运行：

```bash
terraform init
terraform fmt -recursive
terraform validate
```

然后再把生成的 `.terraform.lock.hcl` 纳入版本控制。
