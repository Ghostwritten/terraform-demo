# 08 质量校验与成本控制

## 目标

建立一个适合初学者的最小工程纪律：改前先看 plan，改后做校验，结束时销毁并记录费用。

## 核心概念

- `terraform fmt` 和 `terraform validate` 是最低要求。
- variable validation 和 `check` 能把经验固化成代码约束。
- 低成本不是“不练习”，而是“把 apply 用在最有价值的环节”。

## 操作步骤

```bash
terraform fmt -check
terraform validate
terraform plan -var-file=envs/dev/terraform.tfvars
terraform destroy -var-file=envs/dev/terraform.tfvars
```

## 观察点

- `validation` 和 `check` 是把成本纪律固化到代码里的最小手段。
- 同样的纪律会在 HCP 平台侧表现为 run 审查、变量治理和 destroy 纪律。

## 代码片段

```hcl
validation {
  condition     = var.bandwidth_out >= 0 && var.bandwidth_out <= 5
  error_message = "bandwidth_out must stay between 0 and 5 Mbps for this low-cost lab."
}
```

## 常见坑

- 待补充：没有提前校验，导致 apply 时才发现变量错误。
- 待补充：只看功能成功，没有做资源清理。

## 成本与清理

- 每次练习前写下资源清单。
- 每次练习后确认 `terraform destroy` 和控制台状态一致。
- 如果只是学习语义，优先使用 `plan` 和 `console`。

## 复盘结论

- Terraform 学习效率高不高，很大程度上取决于你是否有稳定的校验和清理习惯。
