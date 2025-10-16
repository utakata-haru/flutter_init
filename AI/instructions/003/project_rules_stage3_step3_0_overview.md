# 💻 第三段階：実装フェーズ — ステップ3 概要: レイヤーごとのコード生成と検証（準備・遵守事項）

> **目的**: 仕様書と構造計画書に基づき、実際のコードを記述する  
> **成果物**: 動作するアプリケーション

## 📝 実行ステップ（概要）

### 🔧 事前準備
- [ ] `AI/scripts/bash/init_project.sh --yes` でプロジェクトを初期化（必要に応じて `--keep-comments`）
- [ ] `AI/scripts/bash/add_dependencies.sh --yes` で推奨依存を追加（runtime / dev）
- [ ] `AI/scripts/bash/generate_core.sh --yes` で Core ディレクトリ構造を生成（`routing/path` と `database/table` を含む）
- [ ] `AI/scripts/bash/init_core_exceptions.sh --yes` で共通例外ファイル生成（`lib/core/exceptions/`）

### 📋 コード生成遵守事項
```
✅ 仕様書の要件
✅ 構造計画書の役割
✅ AI/architecture/technology_stack.md のライブラリ
✅ AI/architecture/lib/features/features_architecture.md のアーキテクチャ・命名規則
✅ Notifier では Riverpod のアノテーション（例：@riverpod）を用いて定義し、コード生成により型安全な Notifier/AsyncNotifier を提供する
✅ Presentation層では StatefulWidget の使用を避け、基本は HookWidget を採用する。Riverpod と併用する場合は HookConsumerWidget を使用する
```