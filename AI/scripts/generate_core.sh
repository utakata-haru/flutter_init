#!/usr/bin/env bash
set -Eeuo pipefail

# generate_core.sh
# Coreディレクトリ構造を生成するスクリプト
# 実行は Flutter プロジェクトのルートで行ってください。

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  -y, --yes     Skip confirmation prompt (non-interactive)."
  echo "  -h, --help    Show this help."
  echo ""
  echo "Note: 共通例外ファイルの生成は AI/scripts/init_core_exceptions.sh を使用してください。"
  exit 0
}

CONFIRM=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -y|--yes)
      CONFIRM="y"; shift;;
    -h|--help)
      usage;;
    *)
      echo "Unknown option: $1"
      usage;;
  esac
done

echo -e "${GREEN}✨ Coreディレクトリ生成を開始します ✨${NC}"

if [ "$CONFIRM" != "y" ]; then
  echo "以下のディレクトリを生成します。よろしいですか？ (y/n)"
  echo "  - lib/core/routing"
  echo "  - lib/core/routing/path"
  echo "  - lib/core/theme"
  echo "  - lib/core/api"
  echo "  - lib/core/exceptions"
  echo "  - lib/core/database"
  echo "  - lib/core/database/table"
  read CONFIRM
  if [ "$CONFIRM" != "y" ]; then
    echo "処理を中断しました。"; exit 0
  fi
fi

echo "🚀 ディレクトリを生成中..."
mkdir -p lib/core/routing
mkdir -p lib/core/routing/path
mkdir -p lib/core/theme
mkdir -p lib/core/api
mkdir -p lib/core/exceptions
mkdir -p lib/core/database
mkdir -p lib/core/database/table

echo -e "${GREEN}✅ 完了: Coreディレクトリが正常に作成されました！${NC}"