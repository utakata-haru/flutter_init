# 構造計画書（テンプレート）

> このファイルは第二段階（構造計画）で更新する、構造計画の雛形です。定義済みアーキテクチャに厳密準拠し、必要ファイルを具体化・合意します。

## メタ情報
- プロジェクト名: TBD（要確認）
- バージョン: 0.1.0
- 最終更新日: 2025-11-13
- 作成者: GitHub Copilot（App_Builder）

## 構造ポリシー（重要制約）
- クリーンアーキテクチャの構造に厳密準拠: `AI/architecture/lib/features/features_architecture.md`
- 新しいフォルダの作成禁止（既存定義内でのファイル配置のみ）
- 命名規則の遵守（例: `snake_case`、責務ごとのフォルダ分割）

## 目的と範囲
- 対象フィーチャー: routine_status
- 対象レイヤー（Domain / Infrastructure / Application / Presentation）: すべて

## 依存・技術参照
- 技術選定: `AI/architecture/technology_stack.md`
- 主要ライブラリ（予定）: Riverpod, hooks_riverpod, flutter_hooks, Freezed, Drift, GoRouter

## ディレクトリ構造（予定）
```
lib/
  core/
    routing/
      routine_status_route.dart
    routing/path/
      routine_dashboard_path.dart
      routine_settings_path.dart
  routine_status_help_path.dart
    database/
      database.dart
      table/
        routine_table.dart
        routine_settings_table.dart
  features/
    user/
      routine_status/
        1_domain/
          1_entities/
            routine_entity.dart
            routine_completion_result_entity.dart
          2_repositories/
            routine_repository.dart
            routine_settings_repository.dart
          3_usecases/
            fetch_routines_usecase.dart
            complete_routine_usecase.dart
            update_routine_usecase.dart
            reset_all_routine_completions_usecase.dart
            update_threshold_setting_usecase.dart
          exceptions/
            routine_failure.dart
        2_infrastructure/
          1_models/
            routine_model.dart
            routine_settings_model.dart
          2_data_sources/
            1_local/
              routine_local_data_source.dart
              routine_local_data_source_impl.dart
              routine_settings_local_data_source.dart
              routine_settings_local_data_source_impl.dart
              exceptions/
                routine_local_exception.dart
            2_remote/
              exceptions/
          3_repositories/
            routine_repository_impl.dart
            routine_settings_repository_impl.dart
        3_application/
          1_states/
            routine_dashboard_state.dart
            routine_settings_state.dart
          2_providers/
            routine_repository_provider.dart
            routine_settings_repository_provider.dart
            routine_threshold_provider.dart
          3_notifiers/
            routine_dashboard_notifier.dart
            routine_settings_notifier.dart
        4_presentation/
          1_widgets/
            1_atoms/
              status_indicator.dart
            2_molecules/
              routine_card.dart
            3_organisms/
              routine_status_list_view.dart
                routine_editor_sheet.dart
          2_pages/
            routine_dashboard_page.dart
            routine_settings_page.dart
```

## ファイル定義表（記入用）
- パス: `lib/features/<feature_name>/...`
- ファイル名: 
- 役割: 

例）
- パス: `lib/features/auth/3_application/3_notifiers/user_notifier.dart`
- 役割: ユーザー状態の生成・更新（@riverpod使用）

- パス: `lib/features/user/routine_status/1_domain/1_entities/routine_entity.dart`
  - 役割: ルーチンのドメインエンティティ（目標時刻・許容ズレ・閾値・完了履歴を保持）
- パス: `lib/features/user/routine_status/1_domain/3_usecases/complete_routine_usecase.dart`
  - 役割: 完了ボタン押下時に実績時刻を記録し、ステータスを判定するドメインユースケース
- パス: `lib/features/user/routine_status/1_domain/3_usecases/reset_all_routine_completions_usecase.dart`
  - 役割: 全ルーチンの完了履歴を一括で削除し、未完了状態へ戻すユースケース
- パス: `lib/features/user/routine_status/1_domain/1_entities/routine_completion_result_entity.dart`
  - 役割: ルーチン完了時の結果（達成ステータス、実績時刻、遅延差分）を表現する値オブジェクト
- パス: `lib/features/user/routine_status/2_infrastructure/1_models/routine_model.dart`
  - 役割: DriftのDataClass／Companionとドメインエンティティを相互変換するモデル（`lib/core/database/database.dart` を参照してテーブルと連携）。JSONシリアライズにも対応し、インポート／エクスポートやデバッグ用途を想定
- パス: `lib/features/user/routine_status/2_infrastructure/1_models/routine_settings_model.dart`
  - 役割: 閾値設定（`RoutineThresholdSetting`）と `RoutineSettingsTable` の相互変換を担うモデル。JSONシリアライズ経由でバックアップや同期準備を行いやすくする
- パス: `lib/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_local_data_source.dart`
  - 役割: ルーチンのローカルデータ取得・保存インターフェース定義
- パス: `lib/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_local_data_source_impl.dart`
  - 役割: Drift Database を介してルーチン一覧と完了記録を読み書きする実装クラス
- パス: `lib/features/user/routine_status/2_infrastructure/3_repositories/routine_repository_impl.dart`
  - 役割: ドメインの `RoutineRepository` インターフェース実装
- パス: `lib/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_settings_local_data_source.dart`
  - 役割: 閾値設定のローカルデータ操作インターフェース定義
- パス: `lib/features/user/routine_status/2_infrastructure/2_data_sources/1_local/routine_settings_local_data_source_impl.dart`
  - 役割: Drift テーブルを利用して閾値設定を読み書きする実装クラス
- パス: `lib/features/user/routine_status/3_application/1_states/routine_dashboard_state.dart`
  - 役割: ダッシュボード画面の状態（ルーチン一覧・読み込み状態・閾値・エラー）を保持する Freezed ステート
- パス: `lib/features/user/routine_status/3_application/1_states/routine_settings_state.dart`
  - 役割: 閾値設定画面の状態（入力値・保存中フラグ・結果通知）を保持する Freezed ステート
- パス: `lib/features/user/routine_status/3_application/2_providers/routine_repository_provider.dart`
  - 役割: AppDatabase を共有し、ローカルデータソース／リポジトリ／ユースケースを Riverpod で依存性注入する
- パス: `lib/features/user/routine_status/3_application/2_providers/routine_settings_repository_provider.dart`
  - 役割: 閾値設定リポジトリとユースケース（全ルーチンへの閾値反映）を組み立てる Provider 群
- パス: `lib/features/user/routine_status/3_application/2_providers/routine_threshold_provider.dart`
  - 役割: 閾値を Stream / Future として UI へ供給する専用 Provider
- パス: `lib/features/user/routine_status/3_application/3_notifiers/routine_dashboard_notifier.dart`
  - 役割: ダッシュボード状態をストリーム連携で更新し、完了処理やルーチン保存／削除を仲介する Notifier
- パス: `lib/features/user/routine_status/3_application/3_notifiers/routine_settings_notifier.dart`
  - 役割: 閾値設定の読み込み・保存・検証を担い、保存結果やエラーを状態に反映する Notifier
- パス: `lib/features/user/routine_status/4_presentation/2_pages/routine_dashboard_page.dart`
  - 役割: ステータスサイト風のトップ画面（緑／黄／赤の表示を行う）。ルーチン追加FAB、クイック完了ボタン、完了履歴一括初期化ボタンを備える
- パス: `lib/features/user/routine_status/4_presentation/2_pages/routine_status_help_page.dart`
  - 役割: アプリ概要と利用手順、ステータスカード／アイコンの意味、現在の閾値を案内するヘルプページ
- パス: `lib/features/user/routine_status/4_presentation/2_pages/routine_settings_page.dart`
  - 役割: 閾値を編集・保存するフォーム画面。Riverpodステートと連携し、保存結果を通知する
- パス: `lib/core/routing/routine_status_route.dart`
  - 役割: ルーチン機能のGoRouter定義（ダッシュボード／設定ページ）
- パス: `lib/core/routing/path/routine_dashboard_path.dart`
  - 役割: ルーチンダッシュボード画面のパスとルート名を定義する共通定数
- パス: `lib/core/routing/path/routine_settings_path.dart`
  - 役割: 閾値設定画面のパス定義とロケーションヘルパーを提供する
- パス: `lib/core/routing/path/routine_status_help_path.dart`
  - 役割: ステータス説明ページへのパス定義とルート名を提供する
- パス: `lib/features/user/routine_status/4_presentation/1_widgets/2_molecules/routine_card.dart`
  - 役割: ルーチンごとのステータス情報と完了／完了解除ボタン、編集／削除操作をまとめたUIコンポーネント。完了履歴がない場合は中立アイコンを表示し、完了済みでは「完了を取り消す」を提示する
- パス: `lib/features/user/routine_status/4_presentation/1_widgets/1_atoms/status_indicator.dart`
  - 役割: ルーチンの達成ステータスを色付きアイコンとラベルで表示する最小コンポーネント
- パス: `lib/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_status_list_view.dart`
  - 役割: 全体の完了状況を集約したステータスカード（緑／黄／赤の動的表示）とルーチンカード群をまとめ、プルリフレッシュや完了／完了解除／編集／削除コールバックを提供するリストUI
- パス: `lib/features/user/routine_status/4_presentation/1_widgets/3_organisms/routine_editor_sheet.dart`
  - 役割: ルーチン名称と目標時刻を入力するボトムシートフォーム。新規作成と既存編集の双方に対応し、保存時にRoutineEntityを返却する
- パス: `lib/core/database/database.dart`
  - 役割: Driftの接続初期化・DAO登録を行いアプリ全体で共有する
- パス: `lib/core/database/table/routine_table.dart`
  - 役割: ルーチンデータ用のDriftテーブル定義（目標時刻・許容ズレ・完了ログを保持）
- パス: `lib/core/database/table/routine_settings_table.dart`
  - 役割: 閾値設定を保持するDriftテーブル定義

## ルーティング計画
- ルート一覧: `routineDashboard`, `routineSettings`
- パス設計（`lib/core/routing/path/`）: `routine_dashboard_path.dart`（`/routine`）、`routine_settings_path.dart`（`/routine/settings`）
- 画面ページ対応（Presentation層）: `routine_dashboard_page.dart`、`routine_settings_page.dart`（GoRouter経由で遷移）

## 状態管理計画（Riverpod）
- Provider（依存性注入）: `routine_repository_provider.dart`（リポジトリDI）、`routine_threshold_provider.dart`（閾値設定の共有）
- Notifier（状態・副作用管理、@riverpod）: `routine_dashboard_notifier.dart`、`routine_settings_notifier.dart`
- UIからのアクセス: `RoutineDashboardPage` は `routineDashboardProvider` をwatch、設定画面は `routineSettingsProvider` をwatch

- Local: `routine_local_data_source.dart`（ルーチン一覧・完了履歴の永続化インターフェース）、`routine_local_data_source_impl.dart`（Drift実装）、`routine_settings_local_data_source.dart`（閾値設定インターフェース）、`routine_settings_local_data_source_impl.dart`（Drift実装）。`lib/core/database/database.dart` とテーブル定義を利用。
- Remote: 今回は利用しない（ディレクトリは空ファイルで占位）。
- 例外: `routine_local_exception.dart` に Drift入出力失敗時の例外定義。

## モデル・リポジトリ計画
- Models: `routine_model.dart`（Drift DataClass／Companionとドメインのマッピング）、`routine_settings_model.dart`（閾値設定のマッピング）
- Repositories: `routine_repository_impl.dart` と `routine_settings_repository_impl.dart` がドメインのインターフェースを実装し、ローカルデータソースを連携

## コード生成・ビルド
- Riverpod / Freezed 等のコード生成方針: NotifierとProviderで `riverpod_annotation` を利用、`routine_dashboard_state.dart` は Freezed で不変ステート定義。
- 実行: `dart run build_runner build --delete-conflicting-outputs`

## 実装順序（構造計画ベース）
- ドメイン → インフラ → アプリケーション → プレゼンテーション の順を厳守
- ユースケース・リポジトリ契約確定 → ローカルデータソース実装 → Riverpod通知／状態 → UI仕上げの順で実施
- 詳細: `AI/instructions/new_app/003/project_rules_stage3_step3_0_overview.md`

## 検証・合意
- レビュー観点（網羅性／分割の妥当性／役割の過不足／解像度）
- 合意文言: 「構造計画に合意し、第三段階（実装）へ進む」

## 更新履歴
- 2025-11-11: テンプレート初期値入力
- 2025-11-11: 構造計画草案追記
- 2025-11-11: 構造計画合意・第三段階へ移行
- 2025-11-12: Stage3 インフラ実装に合わせて routine_model の参照先を明確化
- 2025-11-12: routine_model が JSON シリアライズ対応であることを追記
- 2025-11-12: routine_settings_model を追加（Drift／ドメイン／JSON の変換方針を明示）
- 2025-11-12: routine_local_data_source / routine_settings_local_data_source の実装内容を反映（Drift操作と例外方針）
- 2025-11-12: routine_repository_impl / routine_settings_repository_impl の実装指針（ローカルDS連携・例外変換）を反映
- 2025-11-12: Application層（State/Provider/Notifier）の実装方針と責務を反映
- 2025-11-12: プレゼンテーション層（ステータス表示ウィジェット／ダッシュボード／設定ページ）とルーティング定義を追記
- 2025-11-12: Riverpodリスナーの初期化タイミングを見直し、非同期ストリームで初期データを取得する方針を追記
- 2025-11-12: 閾値設定ページでマウント時にNotifierのrefreshを呼び出すUIフローを追記
- 2025-11-13: ルーチン追加ボトムシート、ダッシュボードのFAB導線、UUID利用方針を追記
- 2025-11-13: 完了解除ボタンの出し分けと関連コールバックをプレゼンテーション層の役割に追記
- 2025-11-13: 全体状態説明カードのビジュアル仕様（緑／黄／赤の凡例）をプレゼンテーション層の役割に追記
- 2025-11-13: 全体完了状況に応じてステータスカードを動的に色分けする役割を追記
- 2025-11-13: ステータス説明ページとヘルプルートの定義を追記
- 2025-11-13: 完了履歴一括初期化ユースケースとダッシュボードのゴミ箱ボタンを追記
- 2025-11-13: ヘルプページに概要と操作手順を記載する役割を追記
- 2025-11-13: ルーチン編集ボタンとフォーム再利用（新規／既存）対応をプレゼンテーション層の役割に追記

## 参考・関連
- プロセス詳細（第二段階）:
  - `AI/instructions/new_app/002/project_rules_stage2_step1.md`
  - `AI/instructions/new_app/002/project_rules_stage2_step2.md`
  - `AI/instructions/new_app/002/project_rules_stage2_step3.md`
  - `AI/instructions/new_app/002/project_rules_stage2_step4.md`
- 上位方針: `AI/instructions/project_rules.md`
- アーキテクチャ規約: `AI/architecture/lib/features/features_architecture.md`