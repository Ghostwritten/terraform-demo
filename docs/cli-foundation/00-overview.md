# 00 CLI 学习线总览

## 目标

理解这个仓库里的本地 Terraform 学习路径，知道哪些目录用于 CLI 练习，哪些目录将被 HCP Terraform 复用。

## 核心概念

- 这条线学习的是本地 Terraform CLI，不是 HCP Terraform 平台治理。
- 根模块负责组合资源，而不是堆所有细节。
- `modules/ecs_instance` 用来演示 Terraform 模块化。
- `envs/dev` 通过目录隔离环境，不把 CLI workspace 作为主线。
- `foundation/resource-group/` 是给 HCP foundation workspace 准备的最小 root module。
- `docs/` 是强制产出，每学完一个模块都要回写笔记。
- `ecs/` 和 `resource-group/` 保留为已经跑通的历史样例，用于和新结构对照学习。

## 操作步骤

```bash
find . -maxdepth 3 -type f | sort
terraform fmt -recursive
```

## 观察点

- 根目录、`foundation/resource-group/`、`ecs/`、`resource-group/` 代表了不同成熟度的 root module 示例。
- 文档结构本身就是学习内容的一部分，因为它直接影响后续 HCP workspaces 的映射方式。

## 代码片段

```hcl
module "ecs_instance" {
  source = "./modules/ecs_instance"
}
```

## 常见坑

- 待补充：例如目录太散、模块边界不清晰、变量命名混乱。

## 成本与清理

- 模块 1 不创建任何付费资源。
- 先读代码和文档，再决定是否 `apply`。

## 复盘结论

- Terraform 项目不是只有 `main.tf`，结构本身就是学习内容的一部分。
