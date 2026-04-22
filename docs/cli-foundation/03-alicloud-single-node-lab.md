# 03 阿里云 ECS 低成本实战

## 目标

用一台低成本 ECS 完成最小真实闭环：创建、安装 Nginx、输出 IP、浏览器访问、销毁。

## 核心概念

- ECS 是计算资源，会产生费用。
- 安全组控制访问入口。
- `user_data` 用于实例初始化。
- `bandwidth_out = 0` 时默认不分配公网 IP。

## 操作步骤

```bash
terraform plan -var-file=envs/dev/terraform.tfvars
terraform apply -var-file=envs/dev/terraform.tfvars
terraform output public_ip
terraform destroy -var-file=envs/dev/terraform.tfvars
```

## 观察点

- 根目录这个 root module 后续会被 HCP 中的 `aliyun-app-dev` 和 `aliyun-app-scale-lab` 复用。
- 单机实验是 CLI 线与 HCP 线的共同实战基础。

## 代码片段

```hcl
resource "alicloud_instance" "this" {
  user_data = var.user_data
}
```

## 常见坑

- 待补充：实例规格在某个可用区售罄。
- 待补充：密码策略不满足阿里云要求。
- 待补充：安全组放通了 HTTP 但没有公网 IP。

## 成本与清理

- 默认只允许 1 台活跃 ECS。
- 系统盘维持最小可用值。
- 多实例只做短时演练，结束后立即 `destroy`。

## 复盘结论

- 会创建 ECS 只是开始，能低成本、安全地创建和销毁才算掌握实战闭环。
