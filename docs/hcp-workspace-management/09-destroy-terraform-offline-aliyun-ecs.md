# 09 销毁 terraform-offline-aliyun-ecs

## 目标

安全销毁 HCP Terraform workspace `terraform-offline-aliyun-ecs` 已创建的阿里云资源对象，并保留 workspace、run history 和 state history 供学习复盘。

## 核心概念

- HCP Terraform 中“销毁基础设施”和“删除 workspace”是两件不同的事。
- 销毁基础设施会触发 destroy run，删除 state 中管理的真实云资源。
- 删除 workspace 不会自动销毁云资源；如果先删 workspace，云资源会变成无人管理对象。
- 本任务默认只销毁 `terraform-offline-aliyun-ecs` workspace 管理的对象，不手工删除阿里云上未被该 workspace state 管理的资源。

## 操作步骤

### 1. 确认 workspace 和代码来源

在 HCP Terraform 中进入：

```text
Organization: ghostwrittten
Workspace: terraform-offline-aliyun-ecs
```

确认 workspace 的 VCS 或 working directory 指向本仓库中已跑通的 ECS 示例：

```text
Repository: Ghostwritten/terraform-demo
Expected directory: ecs
Expected managed resource: alicloud_instance.demo
```

如果 workspace 不是指向 `ecs/`，先停止销毁，记录实际 working directory，再重新确认 state 中资源。

### 2. 查看当前 state 管理对象

在 workspace 的最新 state 或 run 页面确认资源清单。

预期资源对象：

```text
alicloud_instance.demo
```

当前 `ecs/main.tf` 中的 vSwitch 和 security group 是已有资源引用：

```hcl
vswitch_id      = "vsw-bp1fd12ephv5gskixctys"
security_groups = ["sg-bp1ft576ohr29b383u6n"]
```

因此 destroy run 预期只销毁 ECS 实例本身，不应销毁已有 vSwitch 或已有 security group。

### 3. 开启 destroy plan 权限

进入 workspace：

```text
Settings -> Destruction and Deletion
```

启用：

```text
Allow destroy plans
```

只在执行销毁期间打开这个开关，销毁完成后建议关闭。

### 4. Queue destroy plan

在同一页面点击：

```text
Queue destroy plan
```

HCP Terraform 会要求输入 workspace 名称确认。输入：

```text
terraform-offline-aliyun-ecs
```

提交后等待 destroy plan 生成。

### 5. 审查 destroy plan

确认 plan 中只包含预期销毁对象。

预期看到：

```text
- alicloud_instance.demo
```

如果 plan 中出现以下对象，先不要 apply：

```text
alicloud_vpc.*
alicloud_vswitch.*
alicloud_security_group.*
alicloud_resource_manager_resource_group.*
```

出现这些对象说明 workspace 管理范围和预期不一致，需要先复查 state。

### 6. Confirm & apply

确认 destroy plan 只会销毁 ECS 后，再点击：

```text
Confirm & apply
```

等待 run 完成。

### 7. 销毁后验证

在 HCP Terraform 中确认：

- Destroy run 状态为 `Applied`
- 最新 state 不再包含 `alicloud_instance.demo`
- Workspace 保留，不删除

在阿里云控制台确认：

- ECS 实例 `tf-demo-ecs-mini` 已释放
- 已有 vSwitch `vsw-bp1fd12ephv5gskixctys` 仍存在
- 已有 security group `sg-bp1ft576ohr29b383u6n` 仍存在

### 8. 关闭 destroy plan 权限

回到：

```text
Settings -> Destruction and Deletion
```

关闭：

```text
Allow destroy plans
```

## 观察点

- Destroy run 使用的是 workspace state，不是单纯读取代码推断云资源。
- 如果 state 只管理 ECS，destroy 不会删除未被 state 管理的 vSwitch 和 security group。
- 保留 workspace 可以保留 run history，适合学习复盘。

## 常见坑

- 先删除 workspace，导致真实云资源继续存在但 Terraform 不再管理。
- 没有审查 destroy plan，就直接确认 apply。
- 把已有网络资源误认为 Terraform 会自动删除。
- 销毁后只看 HCP run 成功，没有去阿里云控制台核对。

## 成本与清理

- ECS 是本任务的主要费用来源，销毁完成后应立即停止计费。
- vSwitch 和 security group 在本示例中是已有引用资源，不是本 workspace 的主要销毁目标。
- 销毁完成后记录：
  - destroy run URL
  - ECS 实例 ID
  - 销毁完成时间
  - 阿里云控制台核对结果

## 复盘结论

销毁 HCP Terraform workspace 管理的资源时，正确顺序是：先审 state 和 destroy plan，再执行 destroy run，最后核对云控制台。不要把“删除 workspace”当成“销毁资源”。

## 官方参考

- [Destroy infrastructure resources and delete workspaces in HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/deletion)
- [Run modes and options in HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/modes-and-options)
- [terraform destroy command](https://developer.hashicorp.com/terraform/cli/commands/destroy)
