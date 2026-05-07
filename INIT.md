---
aliases: [INIT, 派生新 vault]
类型: 框架使用说明
---

# 派生新客户 vault 操作指南

> 本目录 `_AIPM-Orbit-template/` 是 AIPM-Orbit 框架的**干净模板**（不含任何 tenant 业务数据）。
> 每次有新客户接入，从本目录派生一个独立 vault。

## 使用前提

- 本目录不要直接当 vault 用（可以读，但不要往里写业务数据）
- 框架级规则更新（README / CLAUDE / AGENTS / GEMINI / 99_系统/模板/）应当先在本 template 修改，再同步到各真实 tenant vault

## 派生新 vault（推荐：脚本一键）

```bash
# 1. 复制 template 到新目录
cd "/Users/$(whoami)/Library/Mobile Documents/iCloud~md~obsidian/Documents/"
cp -R _AIPM-Orbit-template/ Yodian_AIPM-Orbit/

# 2. 跑初始化脚本（替换 {{tenant 名}} 占位符 + 删 INIT.md）
cd Yodian_AIPM-Orbit
./init-tenant.sh Yodian.tech
```

> 把 `Yodian` 和 `Yodian.tech` 换成你的客户代号 / 客户名即可。代号建议大写字母 / 拼音首字母。

## 派生新 vault（手动 4 步）

### 1. 整目录复制

```bash
cd "/Users/$(whoami)/Library/Mobile Documents/iCloud~md~obsidian/Documents/"
cp -R _AIPM-Orbit-template/ {客户代号}_AIPM-Orbit/
```

### 2. 替换 tenant 占位符

把以下 3 个文件中的 `{{tenant 名}}` 替换为实际客户名：

- `CLAUDE.md`（"Vault 作用域"段）
- `AGENTS.md`（"Vault 作用域"段 + 顶层结构表格）
- `00_AIPM-Orbit整体说明.md`（多处）

可用一行命令批量替换（macOS BSD sed）：

```bash
cd {客户代号}_AIPM-Orbit
sed -i '' 's|{{tenant 名}}|Yodian.tech|g' CLAUDE.md AGENTS.md 00_AIPM-Orbit整体说明.md
```

### 3. 删除本说明文件

```bash
rm INIT.md
```

（INIT.md 只对模板有意义，真实 tenant vault 不需要。）

### 4. 在 Obsidian 中打开

- 启动 Obsidian → "Open another vault" → 选择 `{客户代号}_AIPM-Orbit/` 目录
- 装推荐插件（详见 [README.md](./README.md) "推荐插件" 段）：Folder Notes / Dataview / Templater
- 在 `00_AIPM-Orbit整体说明.md` 中补全客户业务背景 / 利益相关方 / 当前主线
- 第一个动作通常是把客户初始素材分流到 `00_基线资料/` 或 `00_想法&诉求池/`

## 编号体系

每个 tenant vault 编号**独立**：

- `CP{NN}` 产品编号、`XM{NN}` 项目编号 都从 `01` 开始
- 编号永不复用（即使消亡也保留指针，避免引用断裂）
- 不跨 vault 共享编号

## 框架级更新流程

当 AIPM-Orbit 框架本身（不是某客户业务）出现规则调整时：

1. 先改本目录 `_AIPM-Orbit-template/` 中的相关文件
2. 同步到所有真实 tenant vault
3. 现存 tenant vault 的实际项目/产品结构按各自情况评估是否需要重组（不强制）

## 框架文件清单

派生时随客户 vault 一起携带的"框架级"文件：

| 文件/目录 | 是否含 tenant 内容 | 派生时动作 |
|---|---|---|
| `README.md` | 否 | 直接复制 |
| `CLAUDE.md` | 含 `{{tenant 名}}` 占位 | 替换占位符 |
| `AGENTS.md` | 含 `{{tenant 名}}` 占位 | 替换占位符 |
| `GEMINI.md` | 否 | 直接复制 |
| `00_AIPM-Orbit整体说明.md` | 含 `{{tenant 名}}` 占位 | 替换占位符 + 补业务背景 |
| `00_!看板.md` | 否 | 直接复制 |
| `.gitignore` | 否 | 直接复制 |
| `99_系统/模板/` | 否 | 直接复制 |
| `99_系统/提示词/` | 否 | 直接复制 |
| `99_系统/技能目录索引.md` `排序规则.md` `AIPM-Orbit_使用说明.md` | 否 | 直接复制 |
| `00_基线资料/README.md` | 否 | 直接复制 |
| `init-tenant.sh` | 仅模板用 | **派生后保留供参考，或删除** |
| `INIT.md`（本文件） | 仅模板用 | **派生后删除** |
