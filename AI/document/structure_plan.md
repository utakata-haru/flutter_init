# 構造計画書（テンプレート）

> このファイルは第二段階（構造計画）で更新する、構造計画の雛形です。定義済みアーキテクチャに厳密準拠し、必要ファイルを具体化・合意します。

## メタ情報
- プロジェクト名: Simple PDF Editor
- バージョン: 1.0.0 (Draft)
- 最終更新日: 2025-11-19
- 作成者: App_Builder 

## 構造ポリシー（重要制約）
- クリーンアーキテクチャの構造に厳密準拠: `AI/architecture/lib/features/features_architecture.md`
- 新しいフォルダの作成禁止（既存定義内でのファイル配置のみ）
- 命名規則の遵守（例: `snake_case`、責務ごとのフォルダ分割）

## 目的と範囲
- 対象フィーチャー: `home`, `editor`
- 対象レイヤー（Domain / Infrastructure / Application / Presentation）: 全レイヤー 

## 依存・技術参照
- 技術選定: `AI/architecture/technology_stack.md`
- 主要ライブラリ（例）: Riverpod, GoRouter, Freezed, Build Runner, pdf, printing, file_picker, path_provider, uuid

## ディレクトリ構造（予定）
```
lib/
  main.dart
  core/
    routing/
      app_routes.dart
    theme/
      app_theme.dart
    exceptions/
      core_exception.dart
  features/
    home/
      1_domain/
        1_entities/
          file_history.dart
        2_repositories/
          file_history_repository.dart
      2_infrastructure/
        1_models/
          file_history_model.dart
        3_repositories/
          file_history_repository_impl.dart
      3_application/
        3_notifiers/
          file_history_notifier.dart
      4_presentation/
        2_pages/
          home_page.dart
    editor/
      1_domain/
        1_entities/
          edited_pdf.dart
        2_repositories/
          pdf_repository.dart
      2_infrastructure/
        3_repositories/
          pdf_repository_impl.dart
      3_application/
        3_notifiers/
          pdf_controller_notifier.dart
      4_presentation/
        1_widgets/
          editor_toolbar.dart
          pdf_preview_grid.dart
        2_pages/
          editor_page.dart
```

## ファイル定義表（記入用）
- パス: `lib/core/routing/`
- ファイル名: `app_routes.dart`
- 役割: ルーティング定義 (GoRouter)

- パス: `lib/core/theme/`
- ファイル名: `app_theme.dart`
- 役割: アプリ全体のテーマ定義

- パス: `lib/features/home/4_presentation/2_pages/`
- ファイル名: `home_page.dart`
- 役割: ホーム画面（ファイル選択ボタン、履歴リスト表示）

- パス: `lib/features/home/3_application/3_notifiers/`
- ファイル名: `file_history_notifier.dart`
- 役割: ファイル履歴の管理（追加、削除、永続化読み込み）

- パス: `lib/features/home/2_infrastructure/3_repositories/`
- ファイル名: `file_history_repository_impl.dart`
- 役割: 履歴データの永続化（SharedPreferences等）

- パス: `lib/features/editor/4_presentation/2_pages/`
- ファイル名: `editor_page.dart`
- 役割: エディタ画面（グリッド表示、ツールバー、プレビュー）

- パス: `lib/features/editor/3_application/3_notifiers/`
- ファイル名: `pdf_controller_notifier.dart`
- 役割: 編集中のPDF状態管理（ページ操作、注釈追加、Undo/Redo）

- パス: `lib/features/editor/2_infrastructure/3_repositories/`
- ファイル名: `pdf_repository_impl.dart`
- 役割: PDFファイルの読み込み、保存、加工処理（pdfパッケージ利用）

## ルーティング計画
- ルート一覧: `/` (Home), `/editor` (Editor)
- パス設計（`lib/core/routing/path/`）: `app_routes.dart`にて `/` と `/editor` を定義
- 画面ページ対応（Presentation層）: `HomePage`, `EditorPage` 

## 状態管理計画（Riverpod）
- Provider（依存性注入）: `3_application/2_providers/`
- Notifier（状態・副作用管理、@riverpod）: `3_application/3_notifiers/`
- UIからのアクセス: 生成された Provider 経由のみ

## データソース計画
- Local: `2_infrastructure/2_data_sources/1_local/`
- Remote: `2_infrastructure/2_data_sources/2_remote/`
- 例外: 各 data source 配下の `exceptions/`

## モデル・リポジトリ計画
- Models: `2_infrastructure/1_models/`
- Repositories: `2_infrastructure/3_repositories/`（Domainのインターフェースに準拠）

## コード生成・ビルド
- Riverpod / Freezed 等のコード生成方針: `freezed`でStateを不変にし、`riverpod_generator`でProviderを生成
- 実行: `dart run build_runner build --delete-conflicting-outputs`

## 実装順序（構造計画ベース）
- ドメイン → インフラ → アプリケーション → プレゼンテーション
- 詳細: `AI/instructions/new_app/003/project_rules_stage3_step3_0_overview.md`

## 検証・合意
- レビュー観点（網羅性／分割の妥当性／役割の過不足／解像度）
- 合意文言: 「構造計画に合意し、第三段階（実装）へ進む」

## 更新履歴
- YYYY-MM-DD: 初期テンプレート作成
- YYYY-MM-DD: 構造計画草案追記
- YYYY-MM-DD: 合意版更新

## 参考・関連
- プロセス詳細（第二段階）:
  - `AI/instructions/new_app/002/project_rules_stage2_step1.md`
  - `AI/instructions/new_app/002/project_rules_stage2_step2.md`
  - `AI/instructions/new_app/002/project_rules_stage2_step3.md`
  - `AI/instructions/new_app/002/project_rules_stage2_step4.md`
- 上位方針: `AI/instructions/project_rules.md`
- アーキテクチャ規約: `AI/architecture/lib/features/features_architecture.md`