#!/usr/bin/env bash
# init-tenant.sh — 初始化 AIPM-Orbit tenant vault
#
# 在已派生（cp / clone）出来的 vault 目录里就地执行：
#   - 把 CLAUDE.md / AGENTS.md / 00_AIPM-Orbit整体说明.md 中的
#     {{tenant 名}} 占位符替换为传入的客户名
#   - 删除 INIT.md（template 专属说明文件）
#
# Usage:
#   ./init-tenant.sh <客户名>
#
# Example:
#   ./init-tenant.sh Yodian.tech
#   ./init-tenant.sh "某某科技"

set -euo pipefail

if [[ $# -lt 1 ]]; then
  cat <<'EOF'
Usage: ./init-tenant.sh <客户名>

例：
  ./init-tenant.sh Yodian.tech
  ./init-tenant.sh "某某科技"

说明：
  在已派生的 vault 目录里执行（应能看到 CLAUDE.md 和 INIT.md）。
  脚本会把 CLAUDE.md / AGENTS.md / 00_AIPM-Orbit整体说明.md 中的
  {{tenant 名}} 占位符替换为传入的客户名，并删除 INIT.md。
EOF
  exit 1
fi

NAME="$1"

# 健全性检查：当前目录看起来像 AIPM-Orbit vault
for f in CLAUDE.md AGENTS.md "00_AIPM-Orbit整体说明.md"; do
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

echo "→ 替换 {{tenant 名}} 为 \"$NAME\""
sed_inplace "s|{{tenant 名}}|${NAME}|g" \
  CLAUDE.md \
  AGENTS.md \
  "00_AIPM-Orbit整体说明.md"

if [[ -f "INIT.md" ]]; then
  echo "→ 删除 INIT.md（template 专属）"
  rm INIT.md
fi

# 校验占位符已清理
remaining=$(grep -l "{{tenant 名}}" CLAUDE.md AGENTS.md "00_AIPM-Orbit整体说明.md" 2>/dev/null || true)
if [[ -n "$remaining" ]]; then
  echo "警告：以下文件仍有未替换的 {{tenant 名}}："
  echo "$remaining"
  exit 1
fi

cat <<EOF

✓ tenant 初始化完成：${NAME}

下一步（手动）：
  1. 如果当前目录还不在 Obsidian iCloud 路径下，把它移过去：
     mv "$(pwd)" "/Users/\$(whoami)/Library/Mobile Documents/iCloud~md~obsidian/Documents/"
  2. 在 Obsidian 中 "Open another vault" 选择该目录
  3. 装推荐插件：Folder Notes / Dataview / Templater
  4. 编辑 00_AIPM-Orbit整体说明.md 补全业务背景

EOF
