# AIPM-Orbit

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Maintained by Yodian.tech](https://img.shields.io/badge/maintained%20by-Yodian.tech-7f00ff)](https://yodian.tech)
[![Obsidian](https://img.shields.io/badge/Obsidian-vault-purple?logo=obsidian)](https://obsidian.md)

AI 产品 / 项目经理工作台 · Obsidian Vault 框架。

> 由 [Yodian.tech](https://yodian.tech) 设计与维护。在真实多客户咨询业务中沉淀打磨。

承接产品经理 / 项目经理日常的全部文档工作，结构化为可追溯的工作流：

```
[原始素材] → [结构化工件] → [发版/运维]
  会议纪要        需求卡片                迭代节奏
  业务方需求      原型 / PRD              线上问题
  客户邮件        测试用例
```

两条工件 pipeline 各负其责：

- **产品级（CP）最窄闭环**：原始需求 → 需求卡片 → 原型管理 → PRD管理 → 测试用例（在 `20_产品/CPxx_xxx/21~25` 下沉淀）
- **项目级（XM）最窄闭环**：原始需求 → 需求卡片 → 业务建模 → 方案设计（在 `10_项目/XMxx_xxx/01~04` 下沉淀）

XM 项目方案验证完成后，业务建模 / 方案设计成果回流到所属 CP 的 1X 架构层（11_架构图 / 13_核心规则）；PRD / 原型 / 测试用例不在 XM 内出，统一在 CP 的 2X 工件 pipeline 沉淀。

## 多 tenant 设计

AIPM-Orbit 是**框架/系统**。每个企业 tenant（客户/业务实体）起一个独立 vault，例：

- `Yodian_AIPM-Orbit/`
- `{客户代号}_AIPM-Orbit/`

vault 内不嵌套 tenant 层级。本 vault 自身的 tenant 信息见 [00_AIPM-Orbit整体说明.md](./00_AIPM-Orbit整体说明.md)。

> **本目录是 template，不是真实 tenant vault**。从此目录派生新客户 vault 的步骤见 [INIT.md](./INIT.md)。

## 快速开始

```bash
# 1. 把 template 复制到新目录（用任何方式拿到本地副本即可）
cp -R AIPM-Orbit-template/ <客户代号>_AIPM-Orbit/
cd <客户代号>_AIPM-Orbit

# 2. 跑初始化脚本（替换 tenant 占位符 + 删 INIT.md）
./init-tenant.sh <客户名>
# 例：./init-tenant.sh Yodian.tech

# 3. 在 Obsidian 中 "Open another vault" 打开当前目录
#    （路径由你决定。要让 Obsidian 跨设备同步，把目录放到对应云盘的 vault 父目录即可）
```

## 顶层结构（号段表）

| 路径 | 用途 | 内容 |
|---|---|---|
| `README.md` | 框架说明（本文件） | — |
| `00_AIPM-Orbit整体说明.md` | 本 vault 的 tenant 业务 | 当前服务的客户、产品、项目状态 |
| `00_!看板.md` | 全局看板（dataview 聚合） | — |
| `00_基线资料/` | 过去向：历史资产 / 现行规则 | 历史 PRD / 业务规则 / 老架构（按 CPxx 子目录组织） |
| `00_想法&诉求池/` | 未来向：演化起点 | 新想法 / 诉求 + 状态：评估中/已转化/已消亡 |
| `10_项目/` | 项目 wrapper | 内部 `XM{NN}_{名称}` |
| `20_产品/` | 产品 wrapper | 内部 `CP{NN}_{名称}` |
| `30_迭代管理/` | 高频日常 | 发版打包视图，按周/双周 |
| `40_线上问题/` | 运行期事件 | 月归档 issue 队列 |
| `80_研究沉淀/` `81_知识库/` | 横切参考 | 方法论 / 知识库 |
| `99_系统/` | 系统 | 模板 / 规则 / 提示词 |

> **0X 段时间维度对偶**：`00_基线资料/`（过去/基线）↔ `00_想法&诉求池/`（未来/演化起点）

## 产品内部结构

每个产品 `20_产品/CPxx_xxx/` 下：

```
CPxx_xxx.md             ← folder note（与文件夹同名的概览文件）
00_会议纪要/            ← 高频入口前置
11_架构图/    ┐
12_路线图/    │ 1X 架构层（沉淀稳定）
13_核心规则/  ┘
21_原始需求/  ┐
22_需求卡片/  │
23_原型管理/  │ 2X 产品相关（工件 pipeline）
24_PRD管理/   │
25_测试用例/  ┘
```

**架构图 / 路线图**支持双载体：在线文档（飞书/语雀/Figma 链接）+ 本地源文件（PPT/Excel/Figma），通过子目录的 `README.md` 作为索引页。

> 上表是**软件型产品**结构。**服务型产品**（诊断/咨询/陪跑类，卖交付而非卖软件）CP 槽位不同。完整软件/服务对位 + XM 通用结构见 [[产品与项目结构总纲]]（`99_系统/`）。

## 项目内部结构

每个项目 `10_项目/XMxx_xxx/` 下：

```
XMxx_xxx.md             ← folder note
00_项目会议/            ← 高频入口前置
01_原始需求/   ┐
02_需求卡片/   │ 工件 pipeline（项目级）
03_业务建模/   │
04_方案设计/   ┘
```

> **XM 不出 PRD / 原型 / 测试用例**。这些 2X 工件统一沉淀到所属产品 [[CPxx_xxx]] 的 `21~25` 工件 pipeline，由产品形态承接长期演进。
> XM 项目"有始有终"的"终" = 业务建模 + 方案设计验证完成；之后业务建模成果回流到 CP 的 `11_架构图`、核心规则回流到 CP 的 `13_核心规则`。

**项目 vs 产品**：
- 产品 = 长期持续运营，有架构图 / 路线图 / 核心规则等长期资产，承接 PRD / 原型 / 测试等 2X 工件
- 项目 = 有始有终的推进单元，frontmatter 标 `产品: "[[CPxx_xxx]]"` 表达归属，专注业务建模 + 方案设计

## 演化模型

```
[想法 / 需求]   起点：00_想法&诉求池/
      │
      ├─→ 演化为「项目」  (有始有终)              10_项目/XMxx_xxx/
      ├─→ 演化为「产品」  (长期持续 + 架构资产)   20_产品/CPxx_xxx/
      └─→ 消亡           (评估失败)              00_想法&诉求池/99_归档/已消亡/
```

| 演化路径 | 操作 |
|---|---|
| 想法 → 归属某产品 | mv 到 `20_产品/CPxx/22_需求卡片/`，原想法留指针标 `状态: 已转化` |
| 想法 → 自成独立项目 | mv 到 `10_项目/XMxx_xxx/`（frontmatter 标 `产品`，归属或独立）|
| 想法 → 升级为产品 | `20_产品/` 下新建 `CPxx_xxx/`，扩充产品资产 |
| 想法 → 消亡 | mv 到 `00_想法&诉求池/99_归档/已消亡/` |

## 命名规范

- **产品编号**：`CP{NN}`（CP01, CP02, ...）
- **项目编号**：`XM{NN}`（XM01, XM02, ...）
- **编号永不复用** —— 即使消亡也保留编号，避免引用断裂
- **文件名 / 文件夹名以当前状态结尾**：
  - 想法：`想法-NNN-主题-{评估中|已转化|已消亡}.md`
  - 项目：`XMNN_主题_{进行中|已完成|...}/`（同名 .md 同步）
  - 产品：`CPNN_主题_{未开始|研发中|已上线}/`（同名 .md 同步）
  - 状态变更时同步重命名 + 批量更新 wiki-link

## 文档约定

### Frontmatter 必填字段

```yaml
---
产品: "[[XX]]"             # 关联类字段必须用 [[wiki-link]]，不用纯字符串
类型: 项目 / 产品 / 想法 / PRD / 业务需求 / ...
状态: 进行中 / 已完成 / 已修复 / 评估中 / 已转化 / 已消亡 / ...
更新日期: YYYY-MM-DD
---
```

frontmatter 后**不空行**。

### Folder Note 模式

文件夹和它的概览 .md 文件**同名**：
- `CP01_xxx_已上线/CP01_xxx_已上线.md`
- `XM01_xxx_进行中/XM01_xxx_进行中.md`

装 [Folder Notes 插件](https://github.com/LostPaul/obsidian-folder-notes) 后，**点击文件夹直接打开概览**。

### Wiki-Link

frontmatter 关联类字段一律用 `[[wiki-link]]`：

```yaml
产品: "[[XX]]"            ✅
关联项目: "[[XM01_xxx]]" ✅
```

`[[]]` 在 dataview 里既能被结构化查询，也会让原生反链面板自动列出引用，**双保险**。

### Alias 机制

每个产品 / 项目的 folder note 在 frontmatter 加 `aliases`：

```yaml
aliases: [友好名, CP01]
```

任何 `[[友好名]]` 或 `[[CP01]]` 引用自动解析到这个 folder note，dataview `[[]]` 自引用也能匹配。

## 入口锚点

- **[[00_!看板]]** — 全局看板：聚合产品全景 / 在跑专项 / 想法池 / 当前迭代 / 未关闭线上问题
- **每个产品 folder note** — 该产品全景 + 在跑专项 / PRD / 需求卡片 / 线上问题
- **每个项目 folder note** — 该项目里程碑 + 关联文档 + 涉及迭代

## Dataview 依赖

部分功能（看板、产品/项目 folder note 的表格）依赖 [Dataview 插件](https://github.com/blacksmithgu/obsidian-dataview)。**强烈建议安装**。

不装也可用：原生反链面板（右侧）会自动列出所有引用本页的文件，是 dataview 的**兜底**。

## 推荐插件

| 插件 | 作用 | 必要性 |
|---|---|---|
| Dataview | 结构化查询 / 看板表格 | 强烈推荐 |
| Folder Notes | 点击文件夹直接打开概览文件 | 强烈推荐 |
| Custom File Explorer Sorting | 文件 / 文件夹混排 + 置顶（搭配 `99_系统/排序规则.md`）| 推荐 |
| Templater | 自定义模板（新建文件自动套模板） | 推荐 |

## Agent 规则

AI Agent 在本 vault 的行为规则：

- Claude Code 专属：[CLAUDE.md](./CLAUDE.md)
- 通用 Agent（Codex / Cursor 等）：[AGENTS.md](./AGENTS.md)
- Gemini：[GEMINI.md](./GEMINI.md)

## License

MIT — 由 [Yodian.tech](https://yodian.tech) 维护，欢迎复制、改造、用于自己的客户工作台。
