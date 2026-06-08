---
name: 原型 preset 状态必须做完整业务闭环
description: 给原型造预置（preset）的工单/单据状态时，要把所有相关字段一起按业务逻辑闭环掉，不要只设主字段而漏掉派生字段
type: feedback
originSessionId: aec9a9b4-2199-425a-a637-fabb1877ae09
---
原型造 preset 状态时，**只设主字段而漏掉派生字段是常见错误**。比如设了『复核已通过/未通过』就完事，但忘了配套的：
- 内容块的不合格打标
- 补拍 checkbox（一次复核选了补拍 → 补拍 checkbox 必勾）
- 自动报单 checkbox（生成了返工单 → 自动报单必勾）
- 已上传的执行照 / 补拍照 vs 内容块的对应关系
- 状态机各字段的派生（pushed / resubSubmitted / firstReviewed / secondReviewed / reworkAutoCreated 互相联动）
- logs 的对应历史记录

**Why:** 2026-06-04 CP07 V4 原型迭代中，用户反复指出 preset 状态的派生字段没填全：
- 自动生成返工单 但 自动报单 checkbox 未勾
- 复核不通过 但 内容块没标记不合格
- 补拍了 但 补拍 checkbox 未勾
用户最后说『就是这些都是基本逻辑，你都需要闭环考虑，不要等我告诉你』。

**How to apply:**
- 造预置状态时画一张状态依赖图：每个『终态』字段（如 reworkAutoCreated=true）→ 倒推所有上游字段（resubAutoCreate=true、secondReviewed=true、resubSubmitted=true、firstReviewed=true、pushed=true、needRetake=true、blockFailMarks 已勾）
- 给每个 preset 场景列『业务流程清单』：一次 AI → 一次复核动作 → 推送 → 补拍 → 二次 AI → 二次复核动作 → （自动报单）→ 返工单。每一步都要在 state 里有对应字段被设值
- 写 state 初始化代码时，把这套依赖关系封装在一个 builder 函数里，避免散落
- 添加新 preset case 前先问自己：这个场景的 UI 上哪些位置会显示状态？每个位置对应的 state 字段是不是都设了？
- 用户在 review 原型时挑出的『派生字段没勾』比一次性闭环代价更高——一次想全
