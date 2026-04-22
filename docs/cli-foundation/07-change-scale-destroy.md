# 07 变更、扩缩容与销毁

## 目标

学会读取 plan 里的“新增、修改、替换、销毁”，并在受控前提下做一次扩缩容练习。

## 核心概念

- 修改带宽、规则、`user_data` 时，不同字段可能触发不同类型变更。
- `instance_count > 1` 默认被 `check` 阻止，必须显式开启扩容实验。
- `destroy` 不是收尾动作，而是学习流程的一部分。

## 操作步骤

```bash
terraform plan -var-file=envs/dev/terraform.tfvars
terraform apply -var-file=envs/dev/terraform.tfvars
terraform destroy -var-file=envs/dev/terraform.tfvars
```

## 观察点

- `instance_count` 和 `enable_scale_lab` 的组合是平台中 `aliyun-app-scale-lab` 的直接输入模型。
- 先在本地读懂扩缩容的 plan，再去 HCP 看远程 run 差异更容易。

## 代码片段

```hcl
check "single_instance_default" {
  assert {
    condition = var.instance_count == 1 || var.enable_scale_lab
  }
}
```

## 常见坑

- 待补充：扩到 2 台后忘记销毁。
- 待补充：看不懂 plan 中 `forces replacement` 的含义。

## 成本与清理

- 多实例只允许短时练习。
- 练习结束后立刻执行 `destroy`，再到控制台确认资源已释放。

## 复盘结论

- 会变更资源不够，能理解变更代价并做出安全决策才算真正入门。
