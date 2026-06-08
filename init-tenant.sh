#!/usr/bin/env bash
# init-tenant.sh — 初始化 AIPM-Orbit tenant vault
#
# 在已派生（cp / clone）出来的 vault 目录里就地执行：
#   - 把 CLAUDE.md / AGENTS.md / 00_AIPM-Orbit整体说明.md / 99_系统/公司/本体档案/* 中的
#     {{tenant 名}} {{tenant 代号}} 占位符替换为传入的客户名 / 代号
#   - 删除 INIT.md（template 专属说明文件）
#
# Usage:
#   ./init-tenant.sh <客户名> [客户代号]
#
# Example:
#   ./init-tenant.sh Yodian.tech YDT
#   ./init-tenant.sh "某某科技" MMK

set -euo pipefail

if [[ $# -lt 1 ]]; then
  cat <<'EOF'
Usage: ./init-tenant.sh <客户名> [客户代号]

例：
  ./init-tenant.sh Yodian.tech YDT
  ./init-tenant.sh "某某科技" MMK

说明：
  在已派生的 vault 目录里执行（应能看到 CLAUDE.md 和 INIT.md）。
  脚本会替换以下占位符并删除 INIT.md：
    {{tenant 名}}     → <客户名>
    {{tenant 代号}}   → <客户代号>（缺省时用 <客户名> 同值）

  受影响文件：
    CLAUDE.md / AGENTS.md / 00_AIPM-Orbit整体说明.md
    99_系统/公司/本体档案/README.md / 01_业务基本盘.md
EOF
  exit 1
fi

NAME="$1"
CODE="${2:-$1}"

# 健全性检查：当前目录看起来像 AIPM-Orbit vault
for f in CLAUDE.md AGENTS.md "00_AIPM-Orbit整体说明.md" "99_系统/公司/本体档案/README.md" "99_系统/公司/本体档案/01_业务基本盘.md"; do
  if [[ ! -f "$f" ]]; then
    echo "错误：当前目录不像 AIPM-Orbit vault（缺 $f）"
    echo "请先 cd 到 vault 根目录再执行本脚本。"
    exit 1
  fi
done

# 跨平台 sed -i（macOS BSD sed 需要空字符串参数）
if [[ "$(uname)" == "Darwin" ]]; then
  sed_inplace() { sed -i '' "$@"; }
else
  sed_inplace() { sed -i "$@"; }
fi

FILES=(
  CLAUDE.md
  AGENTS.md
  "00_AIPM-Orbit整体说明.md"
  "00_首次使用.md"
  ".claude/commands/初始化向导.md"
  "99_系统/公司/本体档案/README.md"
  "99_系统/公司/本体档案/01_业务基本盘.md"
  "99_系统/memory_seed/README.md"
)

echo "→ 替换 {{tenant 名}} 为 \"$NAME\""
sed_inplace "s|{{tenant 名}}|${NAME}|g" "${FILES[@]}"

echo "→ 替换 {{tenant 代号}} 为 \"$CODE\""
sed_inplace "s|{{tenant 代号}}|${CODE}|g" "${FILES[@]}"

if [[ -f "INIT.md" ]]; then
  echo "→ 删除 INIT.md（template 专属）"
  rm INIT.md
fi

# 校验占位符已清理
remaining=$(grep -lE "\{\{tenant (名|代号)\}\}" "${FILES[@]}" 2>/dev/null || true)
if [[ -n "$remaining" ]]; then
  echo "警告：以下文件仍有未替换的占位符："
  echo "$remaining"
  exit 1
fi

cat <<EOF

✓ tenant 初始化完成：${NAME}（代号：${CODE}）

下一步（手动）：
  1. 在 Obsidian 中 "Open another vault" → 选择当前目录
     （或先把当前目录移到你的 Obsidian vault 父目录，再打开）
  2. 装推荐插件：Folder Notes / Dataview / Templater
  3. 编辑 00_AIPM-Orbit整体说明.md 补全业务背景
  4. 编辑 99_系统/公司/本体档案/ 各文件补全产品线 / 在做项目 / 关键决策 / 术语规约
  5. 招新 AI 员工：复制 99_系统/公司/员工档案/_员工模板/ → <员工名>/，详见 INIT.md（已删）或 README

EOF
