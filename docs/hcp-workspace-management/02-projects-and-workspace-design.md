# 02 Projects 与 Workspace 设计

## 目标

用固定的 2 个 project + 4 个 workspace 案例，为后续所有 HCP 平台实验建立统一边界。

## 核心概念

- Project 用来组织 workspaces、权限范围和 variable sets。
- Workspace 用来管理一组有明确职责边界的 Terraform 配置。
- 同一个仓库可以被多个 workspace 复用，只要 working directory 不同。

## 操作步骤

1. 在脑中先固定 project 结构：
   - `platform-foundation`
   - `application-delivery`
2. 再固定 workspace 结构：
   - `aliyun-network-dev`
   - `aliyun-app-dev`
   - `aliyun-app-scale-lab`
   - `aliyun-import-lab`
3. 将它们映射到仓库：
   - `aliyun-network-dev` -> `foundation/resource-group/`
   - `aliyun-app-dev` -> 仓库根目录
   - `aliyun-app-scale-lab` -> 仓库根目录，使用不同变量集
   - `aliyun-import-lab` -> `resource-group/` 或 `ecs/` 历史样例
4. 阅读官方 project 教程：
   [Organize workspaces with projects](https://developer.hashicorp.com/terraform/tutorials/cloud/projects)

## 观察点

- `aliyun-network-dev` 尽量只保留低成本、可长时间存在的基础对象。
- `aliyun-app-dev` 和 `aliyun-app-scale-lab` 都是 compute 类 workspace，但用途不同。
- 导入实验单独放到 `aliyun-import-lab`，可以降低对主实验 workspace 的干扰。

## 常见坑

- 一个 workspace 既管网络又管应用又管导入，职责过重。
- project 只当分组标签使用，没有结合权限和 variable sets 思考。

## 成本与清理

- Foundation project 里的 workspace 默认只创建低成本资源组类对象。
- App 类 workspace 才允许短时 ECS 实验。

## 复盘结论

- 平台上的多项目管理，核心不是数量，而是边界清晰、依赖清晰、权限清晰。
