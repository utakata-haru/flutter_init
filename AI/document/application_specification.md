# アプリケーション仕様書（AIスケジュールコーチ）

> 第一段階（仕様策定フェーズ）の成果物として、要件に基づく仕様を確定します。技術選定は `AI/architecture/technology_stack.md` を最優先で反映しています。

## メタ情報
- プロジェクト名: AIスケジュールコーチ（仮称）
- バージョン: v0.1-draft
- 最終更新日: 2025-11-06
- 作成者: Flutter App Builder

## 概要
- コンセプト: AIと対話しながら、日次・週次のスケジュール作成と自己管理を行うモバイルアプリ。
- 目的（解決したい課題）: 予定作成の手間、実行とのギャップ、継続的な改善の難しさを、AI提案・可視化・連携によって解消する。
- 背景・文脈: 従来のToDo/カレンダーでは「作る・守る・改善する」のループが分断されがち。本アプリは対話と分析を組み合わせて日々の計画習慣化を支援する。初期対応はAndroid版。

## ターゲットユーザー・ペルソナ
- 主要ペルソナ:
  - 会社員（30代）：会議・学習・私事を週次で最適配分し、継続的に改善したい。
  - 大学生（20代）：授業・バイト・勉強のテンプレート運用で計画と実績の差を縮めたい。
- ユーザー課題:
  - 自然言語で素早く予定を作りたい／修正したい。
  - 実績との差分を分かりやすく可視化したい。
  - 既存カレンダーと同期したい／複数端末で使いたい。
- 利用シナリオ:
  - 朝：AIに「今日の優先タスクを2時間ブロックで入れて」と指示。
  - 夕方：実績を記録し、AIの週次レポートで改善提案を確認。

## ユースケース一覧
- UC-01: 日次スケジュールの作成・編集（タイムブロック、優先度、タグ）
- UC-02: 週次テンプレートの作成・編集（目標、繰り返し設定）
- UC-03: AI対話による予定提案・調整（重複回避、代替案）
- UC-04: 実績記録（開始/終了、完了状態、メモ）
- UC-05: 予定 vs 実績の比較分析（完了率、遅延、キャンセル率）
- UC-06: Googleカレンダー連携（双方向同期：インポート/書き込み）
- UC-07: 通知・リマインダー（事前通知、スヌーズ）
- UC-08: 音声入力での指示（日本語）
- UC-09: データ可視化ダッシュボード（達成度、カテゴリ別、トレンド）
- UC-10: データエクスポート（CSV/JSON）

## スコープ定義
- In-Scope（今回対象）:
  - Android版（初期リリース）
  - 日次・週次スケジュール作成・編集、AI対話（テキスト）、実績記録、分析、通知、Googleカレンダー連携、クラウドバックアップ、データエクスポート
- Out-of-Scope（今回対象外）:
  - 自動トラッキング（位置情報・端末使用時間による自動実績推定）
  - Appleカレンダー連携、Wear OS 連携（将来拡張）
  - 高度な音声合成による読み上げ（将来拡張）

## 機能要件（機能定義）
- 機能名: 日次スケジュール編集
  - 説明: タイムブロック／タスクカードの追加・編集・ドラッグ＆ドロップ。
  - 受け入れ基準: 予定のCRUDが可能、重複時に警告表示、UI応答 < 100ms。
  - 依存関係: Drift（ローカルDB）、Riverpod（状態）。
- 機能名: 週次テンプレート管理
  - 説明: 週次目標と繰り返し設定を含むテンプレートの作成・適用。
  - 受け入れ基準: テンプレ適用で日次へ展開、重複解決支援。
  - 依存関係: Drift、GoRouter。
- 機能名: AI対話・提案
  - 説明: チャットUIで自然言語から予定生成／調整案の提示。
  - 受け入れ基準: 3秒以内に初回応答（ストリーミング表示可）、提案をワンタップで採用。
  - 依存関係: 外部AI API、Riverpod、Freezed。
- 機能名: 実績記録と比較分析
  - 説明: 実績入力と予定との差分をダッシュボードで可視化。
  - 受け入れ基準: 週次レポート生成（完了率、遅延、カテゴリ比率）。
  - 依存関係: Drift、Flutter Hooks、グラフ描画。
- 機能名: Googleカレンダー連携
  - 説明: OAuth2認証の上で予定のインポート/書き込みを行う。
  - 受け入れ基準: 初回同期設定、手動同期、コンフリクト時の優先ルール選択。
  - 依存関係: Google Calendar API、認証。
- 機能名: 通知・リマインダー
  - 説明: 予定の事前通知、スヌーズ、完了チェック導線。
  - 受け入れ基準: 通知許可時に予定前通知が正しく発火、スヌーズ設定反映。
  - 依存関係: flutter_local_notifications。
- 機能名: 音声入力
  - 説明: 日本語音声→テキストによる対話指示。
  - 受け入れ基準: 権限許可後に安定して文字起こし、誤認識時の確認導線。
  - 依存関係: speech_to_text 等。
- 機能名: データエクスポート
  - 説明: CSV/JSONで予定・実績・設定のエクスポート。
  - 受け入れ基準: 指定期間のデータをファイルへ書き出し、共有可能。
  - 依存関係: ファイルアクセス、権限。

## 画面設計（概要）
- 主要画面:
  - オンボーディング/ログイン
  - ホーム（ダッシュボード）
  - 日次スケジュール編集
  - 週次スケジュール編集
  - AIチャット
  - 実績記録
  - 分析（予定vs実績、カテゴリ別、週次レポート）
  - 設定（通知、連携、バックアップ、プライバシー、エクスポート）
- 画面遷移（テキスト）:
  - ログイン → ホーム →（日次／週次／AIチャット／分析／設定）
  - 日次 ↔ 週次（テンプレ適用）／AIチャット（提案採用）
  - 設定 → 認証／連携／通知／エクスポート
- ナビゲーション原則: ボトムナビ＋Fab（追加）、GoRouterで宣言的ルーティング。

## データ要件
- エンティティ定義（例）:
  - User: id, authProvider, settings
  - ScheduleItem: id, title, startAt, endAt, priority, tags, recurrence, externalRefId
  - WeekPlan: weekId, goals, items
  - ActivityLog: itemId, actualStart, actualEnd, status, note
  - AnalysisSnapshot: period, completionRate, delayMinutes, categoryRatio, summary
  - ChatMessage: role, content, timestamp, relatedItemIds
  - Settings: notification, theme, language, voiceInputEnabled
- バリデーション要件: 時刻整合性（start < end）、重複検知、必須項目（title, start/end）。
- 永続化・保存戦略: Driftでローカル保存、定期クラウドバックアップ、差分同期。

## 非機能要件
- 性能: AI応答初回3秒以内、主要画面応答 < 100ms、スクロール60fps。
- セキュリティ: OAuth/Firebase認証、保存・通信の暗号化、権限管理（カレンダー/音声）。
- 可用性・運用: 稼働率99.9%、バックオフ・リトライ、障害時通知。
- アクセシビリティ: ダーク/ライトテーマ、フォント拡大、音声入力対応。

## 技術選定（参照）
- 参照ドキュメント: `AI/architecture/technology_stack.md`
- 採用技術:
  - 状態管理: Riverpod / hooks_riverpod
  - データモデル: Freezed（freezed_annotation）
  - 画面遷移: GoRouter
  - ローカルDB: Drift（sqlite3_flutter_libs, path_provider, path）
  - UI補助: Flutter Hooks
  - コード生成: build_runner, riverpod_generator, freezed, drift_dev, json_serializable
  - 追加候補: 外部AI API, speech_to_text, flutter_local_notifications, Firebase Authentication/Firestore/Cloud Storage, Google Calendar API

## リスク・前提・制約
- 主要リスク: AI遅延、同期コンフリクト、権限拒否、タイムゾーン差。
- 重要前提: Android優先、外部AI API採用、Googleカレンダー連携。
- 制約条件: 技術選定は上位ドキュメントに準拠、オフライン時はローカル優先。

## 依存関係
- 外部API／サービス: AI API（要選定）、Google Calendar API、Firebase（候補）。
- ライブラリ／プラグイン: Riverpod, Freezed, GoRouter, Drift, Flutter Hooks, speech_to_text, flutter_local_notifications。

## マイルストーン（仕様策定観点）
- M1: 仕様草案提示（完了）
- M2: 詳細化・合意（ユーザー確認後）
- M3: 第二段階へ移行（合意確認文言取得）

## 受け入れ基準（全体）
- 合意文言: 「仕様内容に合意し、構造計画へ進む」
- 必要ドキュメント: 本仕様書最新版、補助資料（必要に応じて）

## 更新履歴
- 2025-11-06: 仕様草案追記（Android優先、技術選定準拠）

## 参考・関連
- プロセス詳細（第一段階）:
  - `AI/instructions/001/project_rules_stage1_step1.md`
  - `AI/instructions/001/project_rules_stage1_step2.md`
  - `AI/instructions/001/project_rules_stage1_step3.md`
  - `AI/instructions/001/project_rules_stage1_step4.md`
- 上位方針: `AI/instructions/project_rules.md`
- アーキテクチャ規約: `AI/architecture/lib/features/features_architecture.md`