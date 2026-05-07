---
aliases: [AIPM-Orbit整体说明, 整体说明]
类型: tenant说明
更新日期: YYYY-MM-DD
---

# AIPM-Orbit 整体说明（本 vault 业务）

> 框架/系统说明见根目录 [README.md](./README.md)。本文件只描述 **当前 vault 的 tenant 业务上下文**。

## 当前 tenant：{{tenant 名}}

本 vault 服务于 **{{tenant 名}}** 企业 tenant 的 AI 产品工作。所有产品 / 项目 / 文档都围绕这一个 tenant 展开。

未来出现新客户 → 单独起一套 vault（如 `XX_AIPM-Orbit/`），不在本 vault 嵌套。

## 业务背景

**待补**——简短描述客户的业务定位、合作背景、当前合作阶段：

- 客户：{{tenant 名}}（**待补全名 / 行业定位**）
- 合作模式：**待人工确认**
- 阶段：**待补**

## 现有产品

```dataview
TABLE 产品代号 AS 产品, 当前阶段, 负责人, 更新日期
FROM "20_产品"
WHERE 产品代号 AND file.name = file.folder
SORT file.name ASC
```

> 新建产品按 `CP{NN}_{名称}` 命名（CP01, CP02, ...），永不复用编号。详见 [README.md](./README.md) "命名规范"。

## 在跑项目

```dataview
TABLE WITHOUT ID
  file.link AS 项目,
  产品 AS 所属产品,
  当前阶段,
  涉及迭代
FROM "10_项目"
WHERE 状态 = "进行中" AND file.name = file.folder
SORT file.name ASC
```

> 新建项目按 `XM{NN}_{名称}` 命名（XM01, XM02, ...），frontmatter 标 `产品: "[[CPxx_xxx]]"` 关联归属产品。

## 关键时间节点

**待补**——记录 milestone：

- _示例_：YYYY-MM-DD：xxx 上线
- ...

## 关键利益相关方

**待补**：

- 业务方负责人：**待人工确认**
- 产品负责人：**待人工确认**
- 技术负责人：**待人工确认**

## 当前主线

**待补**——围绕的核心业务主题。

## 入口

日常工作主要从以下文件进入：

- [[00_!看板]] — 全局看板，dataview 聚合所有动态
- 各产品 folder note 见 `20_产品/` 目录
- 各项目 folder note 见 `10_项目/` 目录
