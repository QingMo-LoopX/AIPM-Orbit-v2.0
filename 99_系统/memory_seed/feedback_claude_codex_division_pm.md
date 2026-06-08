---
name: Claude × Codex 非-coding 协作分工
description: AIPM-Orbit / OrbitOS 等 PM 内容 + 杂务场景下，Claude 管编排和内容，Codex 管执行；调用 Codex 时必须让用户可感知
type: feedback
originSessionId: 8b689fbc-8c1f-402a-aedd-f4d0019da887
---
**规则**：在非-coding 场景（AIPM-Orbit / OrbitOS / 其他 vault 类工作）下：

- **Claude = 管理大脑**：编排、分发、追踪、vault 内容产出（PRD / 方案 / 画板 / 日志 / 专项日志）、frontmatter / wiki-link 维护、贴写作偏好的文字
- **Codex = 任务执行**：工具/依赖安装、外部服务调用、API 调试、语音转录、音视频处理、长跑命令、抓数据、root-cause 挖掘
- **守住 vault 规则的活留给 Claude**：Codex 不读 `~/.claude/CLAUDE.md` 全套规则，涉及 vault 内文档落盘不要交给它

**派单时必须让用户可感知**（强约束）：

不能默默调用 Codex。每次派单要明示三件事，让用户能截停：

```
派给 Codex：<一句话任务>
范围：<动什么，不动什么>
回报：<我要拿到什么结果继续编排>
```

派完不轮询，等 Codex 回报；卡住/跑偏用 `codex:rescue` 再派诊断单，不硬扛。

**触发词**（用户说这些直接走派单流程，不再追问）：
- 「让 codex 装 / 跑 / 转录 / 调用 xxx」
- 「这个交给 codex」
- 「派出去」

用户说「我自己来」/「先别派」→ 留在主线继续。

**Why**：用户 2026-05-17 ~ 2026-05-18 明确要求：(1) Claude 定位为管理大脑+内容编排，Codex 专做执行；(2) 调用 Codex 必须可感知，不能后台默默派；(3) 这是 PM 工作流的统一约定，跟 VibeCoding（coding 项目，见 `~/.claude/projects/-Users-salex-VibeCoding/memory/vibecoding_spec.md`）的「Claude 架构 / Codex 实现+Review」是两条不同协作线，并存不冲突。

**How to apply**：
- 收到「装工具 / 调服务 / 转录 / 抓数据 / 跑命令」类需求 → 默认派 Codex，先用上述三段式明示，等用户确认或自然进行
- 收到「写 PRD / 改画板 / 整理日志 / 维护 frontmatter」类需求 → Claude 自己做，不派
- 不确定归属（既要执行又要落盘 vault）→ 先派 Codex 拿原始结果，Claude 再接力做内容侧落盘
- 任何调用 Codex 的动作都在对话里显式说明，不静默执行
