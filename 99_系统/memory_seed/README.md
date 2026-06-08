# memory_seed · 通用 memory 种子

## 这是什么
Claude Code 的 memory 物理存放在 `~/.claude/projects/<vault路径encode>/memory/`，跟 vault 路径绑死。**克隆/移动 vault 后路径变了，memory 不会跟着走**。

本目录是一份**与 vault 同走的通用 memory 种子**，第一次使用本 vault 时复制到对应 memory 物理路径，AI 就具备开箱即用的方法论积累（写作风格、流程图工艺、文档版本规则、画板设计、根因分析等）。

## 第一次使用怎么用

跑 `/初始化向导` 时 AI 会引导你做下面这两步。也可以手动执行：

### 1. 找到 memory 物理路径

```bash
VAULT="/Users/<你的用户名>/.../{{tenant 代号}}_AIPM-Orbit"   # vault 绝对路径
SLUG="$(printf '%s' "$VAULT" | sed 's|/|-|g' | sed 's|^-||')"
MEM="$HOME/.claude/projects/-$SLUG/memory"
echo "$MEM"
```

或更简单：在 Claude Code 里随便聊一句，让 AI 把 vault 路径转 slug 并告诉你 `~/.claude/projects/` 下的对应目录。

### 2. 复制 seed

```bash
mkdir -p "$MEM"
cp 99_系统/memory_seed/*.md "$MEM/"
```

## 之后

- 这些通用 memory 由 AI 在后续对话中按需更新（用户口令「记下来」「保存这次」会写入）
- 本体特有 memory（团队成员、关键决策、业务术语）由 `/初始化向导` 引导你边填业务背景边沉淀
- 不要再用本 seed 覆盖物理 memory（会丢失业务沉淀）

## 包含哪些
见同目录 [MEMORY.md](./MEMORY.md) 索引。
