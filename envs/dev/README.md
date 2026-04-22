# dev 环境使用说明

`envs/dev` 是本仓库默认的学习环境目录。它不使用 Terraform CLI workspace，而是通过目录和独立变量文件来隔离环境。

## 文件说明

- `terraform.tfvars.example`: dev 环境示例变量
- `imports.tf.example`: import 练习模板

## 推荐流程

```bash
cp envs/dev/terraform.tfvars.example envs/dev/terraform.tfvars
terraform init
terraform plan -var-file=envs/dev/terraform.tfvars
```

## 分阶段练习建议

### 模块 1

```hcl
create_resource_group = false
create_ecs            = false
existing_resource_group_id = "rg-xxxxx"
```

只跑 `fmt`、`validate`、`plan`，理解目录结构和输入输出。

### 模块 2

```hcl
create_resource_group = true
create_ecs            = false
```

只创建资源组，练习 state 和 output。

如果你是导入一个已存在的资源组，而不是新建：

- 保持 `create_resource_group = true`
- 把 `resource_group_name` 改成云上真实名称
- 将 `envs/dev/imports.tf.example` 复制到仓库根目录为 `imports.tf`
- 再执行 `terraform plan` 或 `terraform apply`

### 模块 3 以后

```hcl
create_resource_group = true
create_ecs            = true
```

填好 `vpc_id`、`vswitch_id`、`instance_password` 后再执行 `apply`。
