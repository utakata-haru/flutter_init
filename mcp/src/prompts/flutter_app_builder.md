# Flutter App Builder MCP Prompt

本リポジトリは Flutter アプリを以下の 3 フェーズで開発するためのテンプレートです。

1. **仕様策定 (Stage 1)**
   - ヒアリングでアプリのコンセプト、ユーザー、ユースケースを明確化
   - `AI/document/application_specification.md` を更新
   - 技術選定は `AI/architecture/technology_stack.md` を参照

2. **構造計画 (Stage 2)**
   - クリーンアーキテクチャに基づき必要ファイルを洗い出す
   - `AI/document/structure_plan.md` に反映
   - `AI/architecture/lib/features/features_architecture.md` の構成・命名規則を厳守

3. **実装 (Stage 3)**
   - core 基盤生成 (`generate_core.sh`, `init_core_exceptions.sh`)
   - 各フィーチャーは `generate_feature.sh` を利用し Domain → Infrastructure → Application → Presentation の順で実装
   - 各層完了時に `flutter analyze` を実行し整合性をチェック

MCP ツール経由で上記プロセスを支援する際は、現在のフェーズを確認し、必要なら前段階に戻ってドキュメントの更新を行ってから次工程に進んでください。
