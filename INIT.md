---
aliases: [INIT, 派生新 vault]
类型: 框架使用说明
---

# 派生新客户 vault 操作指南

> 本目录是 AIPM-Orbit 框架的**干净模板**（不含任何 tenant 业务数据）。每次有新客户接入，从本目录派生一个独立 vault。
> 模板的本地路径完全由你决定。脚本和文档不假定任何固定路径，也不假定 template 的来源（cp 副本 / zip 解压 / git clone 都可以）。

## 使用前提

- 本目录不要直接当 vault 用（可以读、可以维护框架，但不要往里写客户业务数据）
- 框架级规则更新（README / CLAUDE / AGENTS / GEMINI / 99_系统/模板/）应当先在本 template 修改，再同步到各真实 tenant vault

## 派生新 vault（推荐：脚本一键）

```bash
# 1. 把 template 复制到新目录（来源不限：本地 cp / zip 解压 / git clone 都行）
cp -R AIPM-Orbit-template/ <客户代号>_AIPM-Orbit/
cd <客户代号>_AIPM-Orbit

# 2. 跑初始化（替换 {{tenant 名}} 占位符 + 删 INIT.md）
./init-tenant.sh <客户名>
# 例：./init-tenant.sh Yodian.tech
```

代号建议：大写字母 / 拼音首字母（如 `Yodian` `ABC`）。

## 派生新 vault（手动 4 步）

### 1. 复制 template 到新目录

```bash
cp -R /path/to/AIPM-Orbit-template/ <客户代号>_AIPM-Orbit/
```

> Template 的本地副本怎么来都行（cp 已有副本 / 解压 zip / git clone 等）。本步只关心"在本地有一份完整 template，复制到新目录"。

### 2. 替换 tenant 占位符

把以下文件中的 `{{tenant 名}}` 替换为实际客户名：

- `CLAUDE.md`（"Vault 作用域"段 + 顶层结构表格）
- `AGENTS.md`（"Vault 作用域"段）
- `00_AIPM-Orbit整体说明.md`（多处）
- `99_系统/公司/本体档案/README.md`（标题）
- `99_系统/公司/本体档案/01_业务基本盘.md`（本体名 + vault 代号）

一行命令批量替换（macOS BSD sed）：

```bash
cd <客户代号>_AIPM-Orbit
sed -i '' 's|{{tenant 名}}|<客户名>|g' CLAUDE.md AGENTS.md 00_AIPM-Orbit整体说明.md 99_系统/公司/本体档案/README.md 99_系统/公司/本体档案/01_业务基本盘.md
sed -i '' 's|{{tenant 代号}}|<客户代号>|g' 99_系统/公司/本体档案/01_业务基本盘.md
```

Linux 用 `sed -i` 不带 `''`。

### 3. 删除模板专属文件

```bash
rm INIT.md
```

`init-tenant.sh` 可保留供参考，也可删除；如果你打算长期维护这个 tenant vault 当独立 GitHub repo，建议删掉以避免误执行。

### 4. 在 Obsidian 中打开

- 启动 Obsidian → "Open another vault" → 选择该目录（路径由你决定）
- 装推荐插件（详见 [README.md](./README.md) "推荐插件" 段）：Folder Notes / Dataview / Templater
- 在 `00_AIPM-Orbit整体说明.md` 中补全客户业务背景 / 利益相关方 / 当前主线
- 在 `99_系统/公司/本体档案/` 各文件补全业务基本盘 / 产品线 / 在做项目 / 关键决策 / 术语规约
- 第一个动作通常是把客户初始素材分流到 `00_基线资料/` 或 `00_想法&诉求池/`

### 5. 招新首位 AI 员工（可延后）

AI 员工与本体解耦——岗位通用能力放全局 `~/.claude/agents/<员工名>.md`，本体特定积累放 `99_系统/公司/员工档案/<员工名>/`。

招新流程：

```bash
# 1. 复制员工模板
cp -R 99_系统/公司/员工档案/_员工模板/ 99_系统/公司/员工档案/<员工名>/

# 2. 替换占位
sed -i '' 's|{{员工名}}|<员工名>|g; s|{{岗位}}|<岗位>|g' 99_系统/公司/员工档案/<员工名>/README.md
```

然后：
- 在 `~/.claude/agents/<员工名>.md` 建岗位全局 agent 定义（含「入本体必读」加载指令，参考既有 agent 文件）
- 在 `99_系统/公司/员工档案/README.md` 花名册加一行

## 编号体系

每个 tenant vault 编号**独立**：

- `CP{NN}` 产品编号、`XM{NN}` 项目编号 都从 `01` 开始
- 编号永不复用（即使消亡也保留指针，避免引用断裂）
- 不跨 vault 共享编号

## 框架级更新流程

当 AIPM-Orbit 框架本身（不是某客户业务）出现规则调整时：

1. 先在本 template 修改相关文件
2. 把变更同步到各真实 tenant vault（按需）
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
| `00_首次使用.md` | 含 `{{tenant 代号}}` 占位 | 替换占位符（脚本会处理） |
| `00_!看板.md` | 否 | 直接复制 |
| `.gitignore` | 否 | 直接复制 |
| `.claude/commands/初始化向导.md` | 含 `{{tenant 代号}}` 占位 | 替换占位符 |
| `99_系统/模板/` | 否 | 直接复制 |
| `99_系统/提示词/` | 否 | 直接复制 |
| `99_系统/公司/本体档案/` | 含 `{{tenant 名}}` `{{tenant 代号}}` 占位 | 替换占位符 + 派生后补业务内容 |
| `99_系统/公司/员工档案/` | 含 `_员工模板/`，招新时复制并替换 `{{员工名}}` `{{岗位}}` | 直接复制，按需招新 |
| `99_系统/公司/培训资料/` | 否 | 直接复制（按岗位添子目录） |
| `99_系统/memory_seed/` | 含 `{{tenant 代号}}` 占位（README 示例路径） | 直接复制；首用时由 `/初始化向导` 引导复制到 Claude Code 物理 memory 路径 |
| `99_系统/scripts/` | 否 | 直接复制 |
| `99_系统/技能目录索引.md` `排序规则.md` `AIPM-Orbit_使用说明.md` | 否 | 直接复制 |
| `00_基线资料/README.md` | 否 | 直接复制 |
| `00_想法&诉求池/99_归档/{已转化,已消亡}/` | 否 | 直接复制（仅骨架） |
| `80_研究沉淀/AIPM-Orbit-产品文档协作设计原则.md` | 否 | 直接复制 |
| `81_知识库/产品文档/` `81_知识库/大模型应用/` | 否 | 直接复制 |
| `init-tenant.sh` | 仅模板用 | 派生后可保留可删除 |
| `LICENSE` | 否 | 视你 tenant vault 是否公开决定 |
| `INIT.md`（本文件） | 仅模板用 | **派生后删除** |
