# 構造計画書（AIスケジュールコーチ）

> 第二段階（構造計画）の成果物として、定義済みアーキテクチャに厳密準拠したファイル構成・役割・実装順序を提示します。

## メタ情報
- プロジェクト名: AIスケジュールコーチ（仮称）
- バージョン: v0.1-draft
- 最終更新日: 2025-11-06
- 作成者: Flutter App Builder

## 構造ポリシー（重要制約）
- クリーンアーキテクチャ構造に厳密準拠: `AI/architecture/lib/features/features_architecture.md`
- 新しいフォルダの作成禁止（既存定義内でのファイル配置のみ）
- 命名規則の遵守（snake_case / 責務ごとのフォルダ分割）

## 目的と範囲
- 対象フィーチャー: auth, calendar, schedule, assistant, analysis, notifications, export
- 対象レイヤー: Domain / Infrastructure / Application / Presentation（全レイヤー）

## 依存・技術参照
- 技術選定: `AI/architecture/technology_stack.md`
- 主要ライブラリ: Riverpod, GoRouter, Freezed, Drift, Flutter Hooks, build_runner

## ディレクトリ構造（予定）
```
lib/
  core/
    routing/
    routing/path/
    theme/
    api/
    exceptions/
    database/
    database/table/
  features/
    auth/
      1_domain/
        1_entities/
        2_repositories/
        3_usecases/
        exceptions/
      2_infrastructure/
        1_models/
        2_data_sources/
          1_local/
            exceptions/
          2_remote/
            exceptions/
        3_repositories/
      3_application/
        1_states/
        2_providers/
        3_notifiers/
      4_presentation/
        1_widgets/
          1_atoms/
          2_molecules/
          3_organisms/
        2_pages/
    calendar/
      （authと同構成）
    schedule/
      （authと同構成）
    assistant/
      （authと同構成）
    analysis/
      （authと同構成）
    notifications/
      （authと同構成）
    export/
      （authと同構成）
```

## ファイル定義表（主要）
- パス: `lib/core/routing/app_router.dart`
  - 役割: GoRouterによるルート定義（初期ルート、遷移ガード）。
- パス: `lib/core/routing/path/paths.dart`
  - 役割: 文字列パスの集中管理（/home, /day, /week, /chat, /analysis, /settings）。
- パス: `lib/core/database/app_database.dart`
  - 役割: Drift初期化、テーブル定義読み込み、DAO生成の土台。
- パス: `lib/core/database/table/schedule_items.dart`
  - 役割: 予定テーブル（id, title, startAt, endAt, priority, tags, recurrence, externalRefId）。
- パス: `lib/core/database/table/activity_logs.dart`
  - 役割: 実績ログテーブル（itemId, actualStart, actualEnd, status, note）。
- パス: `lib/core/exceptions/app_exception.dart`
  - 役割: 共通例外のベースクラス。

- パス: `lib/features/schedule/1_domain/1_entities/schedule_item.dart`
  - 役割: Freezedで定義するドメインエンティティ（JSON対応）。
- パス: `lib/features/schedule/1_domain/2_repositories/schedule_repository.dart`
  - 役割: 予定取得/保存/更新/削除のインターフェース。
- パス: `lib/features/schedule/1_domain/3_usecases/plan_day_usecase.dart`
  - 役割: 日次計画適用（テンプレ→日次）ロジック。
- パス: `lib/features/schedule/2_infrastructure/1_models/schedule_item_model.dart`
  - 役割: Drift/JSONとエンティティの変換モデル。
- パス: `lib/features/schedule/2_infrastructure/2_data_sources/1_local/schedule_local_data_source.dart`
  - 役割: Drift経由のCRUD。
- パス: `lib/features/schedule/2_infrastructure/2_data_sources/2_remote/calendar_remote_data_source.dart`
  - 役割: Google Calendar APIアクセス。
- パス: `lib/features/schedule/2_infrastructure/3_repositories/schedule_repository_impl.dart`
  - 役割: Domainのインターフェース実装（Local/Remote統合）。
- パス: `lib/features/schedule/3_application/1_states/schedule_state.dart`
  - 役割: 表示用状態（当日/今週、読み込み状態）。
- パス: `lib/features/schedule/3_application/2_providers/schedule_providers.dart`
  - 役割: Repository/UseCaseのProvider定義。
- パス: `lib/features/schedule/3_application/3_notifiers/schedule_notifier.dart`
  - 役割: @riverpodで状態管理、タイムブロック編集、副作用。
- パス: `lib/features/schedule/4_presentation/2_pages/day_page.dart`
  - 役割: 日次編集画面。
- パス: `lib/features/schedule/4_presentation/2_pages/week_page.dart`
  - 役割: 週次編集画面。

- パス: `lib/features/assistant/1_domain/3_usecases/generate_plan_usecase.dart`
  - 役割: AIへのプロンプト生成・応答解析。
- パス: `lib/features/assistant/2_infrastructure/2_data_sources/2_remote/assistant_remote_data_source.dart`
  - 役割: 外部AI API呼び出し（ストリーミング対応）。
- パス: `lib/features/assistant/3_application/3_notifiers/chat_notifier.dart`
  - 役割: チャット状態管理、提案採用イベントをスケジュールへ反映。
- パス: `lib/features/assistant/4_presentation/2_pages/chat_page.dart`
  - 役割: チャットUI（テキスト/音声入力）。

- パス: `lib/features/analysis/4_presentation/2_pages/dashboard_page.dart`
  - 役割: ダッシュボード（達成度、カテゴリ比率、トレンド表示）。

- パス: `lib/features/notifications/3_application/3_notifiers/notification_notifier.dart`
  - 役割: 通知スケジューリング（flutter_local_notifications）。

- パス: `lib/features/export/1_domain/3_usecases/export_data_usecase.dart`
  - 役割: CSV/JSONエクスポート処理。

## ルーティング計画
- ルート一覧: /home, /day, /week, /chat, /analysis, /settings
- パス設計: `lib/core/routing/path/paths.dart` に定義、GoRouterで参照
- 画面ページ対応:
  - /home → ホーム（ダッシュボード）
  - /day → 日次編集（DayPage）
  - /week → 週次編集（WeekPage）
  - /chat → AIチャット（ChatPage）
  - /analysis → 分析（DashboardPage）
  - /settings → 設定

## 状態管理計画（Riverpod）
- Provider配置: `3_application/2_providers/` に集約（Repository、UseCase、外部サービス）
- Notifier: `3_application/3_notifiers/` に配置（@riverpodで自動生成）
- UIアクセス: 生成Providerのみを参照、直接DIは禁止

## データソース計画
- Local: Drift（`core/database/table/` にテーブル、各featureの local data source でアクセス）
- Remote: Google Calendar API、AI API（assistant）、Firebase（候補）
- 例外: `exceptions/` を各 data source 配下に配置し、再利用可能なAppExceptionを継承

## モデル・リポジトリ計画
- Models: `2_infrastructure/1_models/`（Freezedで定義、toJson/fromJson、Driftマッピング）
- Repositories: `2_infrastructure/3_repositories/`（Domainインターフェース準拠、Local/Remote統合）

## コード生成・ビルド
- 方針: Freezed, Riverpod, Driftのコード生成を採用し、ビルド時に整合性を検証
- 実行例: `dart run build_runner build --delete-conflicting-outputs`

## 実装順序（構造計画ベース）
- 1) Domain（エンティティ/リポジトリIF/ユースケース）
- 2) Infrastructure（モデル/データソース/リポジトリ実装）
- 3) Application（状態/Provider/Notifier）
- 4) Presentation（ページ/ウィジェット）
- 参考: `AI/instructions/003/project_rules_stage3_step3_0_overview.md`

## 検証・合意
- レビュー観点: 網羅性、責務分割の妥当性、依存方向の順守、UI/路線の整合
- 合意文言: 「構造計画に合意し、第三段階（実装）へ進む」

## 更新履歴
- 2025-11-06: 構造計画草案追記（features_architecture準拠／technology_stack準拠）

## 参考・関連
- プロセス詳細（第二段階）:
  - `AI/instructions/002/project_rules_stage2_step1.md`
  - `AI/instructions/002/project_rules_stage2_step2.md`
  - `AI/instructions/002/project_rules_stage2_step3.md`
  - `AI/instructions/002/project_rules_stage2_step4.md`
- 上位方針: `AI/instructions/project_rules.md`
- アーキテクチャ規約: `AI/architecture/lib/features/features_architecture.md`
