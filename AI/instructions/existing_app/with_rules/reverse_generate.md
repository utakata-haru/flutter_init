# 🔎 逆算生成 — 仕様書と構造計画書を現在のコードから作成

> 目的: 実コードを起点に、仕様書（`AI/document/application_specification.md`）と構造計画書（`AI/document/structure_plan.md`）を整備する。

## ステップ
1. 現状把握
   - [ ] `lib/core/` の存在確認と役割棚卸（`routing`, `theme`, `api`, `exceptions`, `database`）
   - [ ] フィーチャー一覧化: `lib/features/<permission>/<feature_name>/`
   - [ ] 各フィーチャーの4層インベントリ:
     - Domain: `1_entities/`, `2_repositories/`, `3_usecases/`, `exceptions/`
     - Infrastructure: `1_models/`, `2_data_sources/(local|remote)/`, `3_repositories/`
     - Application: `1_states/`, `2_providers/`, `3_notifiers/`
     - Presentation: `1_widgets/(atoms|molecules|organisms)/`, `2_pages/`

2. 仕様書への反映（`AI/document/application_specification.md`）
   - [ ] 概要・目的・ターゲットを現状コードから推定し記入
   - [ ] 機能一覧（フィーチャー基準）と主要ユースケース記載
   - [ ] 画面設計（ページ一覧と遷移）、データ要件（主要エンティティ・外部APIの有無）
   - [ ] 非機能要件（対応プラットフォーム、オフライン、セキュリティ、パフォーマンス）
   - [ ] 技術選定は `AI/architecture/technology_stack.md` に整合

3. 構造計画書への反映（`AI/document/structure_plan.md`）
   - [ ] ディレクトリ構造（現状の実体をテンプレートに落とし込み）
   - [ ] ファイル定義表（パス / ファイル名 / 役割）を埋める
   - [ ] ルーティング計画（`core/routing/path` と `pages` の整合）
   - [ ] 状態管理計画（`providers/notifiers` の依存関係と公開インターフェース）
   - [ ] データソース計画（`local/remote` の配置と例外方針）

4. 検証
   - [ ] `flutter analyze` 実行（層間依存が正しいか）
   - [ ] ドキュメント整合レビュー（仕様書 ≒ 構造計画書 ≒ 実コード）

## 注意
- 新規フォルダの追加禁止。必要があれば構造計画の修正提案→合意→反映の順で行う。
- Riverpod/Freezed/GoRouter/Drift などは `technology_stack.md` のバージョン方針に従う。

