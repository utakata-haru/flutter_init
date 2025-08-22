# ボイスメモアプリ – 構造計画書（voice_memo フィーチャー v0.2 合意版）

最終更新: 2025-08-22
作成者: App Builder（AI）

## 1. 準拠ルール
- .trae/rules/project_rules.md の3段階プロセスに厳密準拠
- AI/instructions/features_template.md のクリーンアーキテクチャ構造に準拠
- 新規フォルダ作成は禁止（定義済み配下でのファイルのみ）

## 2. フィーチャーパス（想定）
- BASE_PATH: `lib/features/user/voice_memo`
- ディレクトリは `AI/generate_feature.sh` により自動生成可能（-n voice_memo -p user）

## 3. レイヤー構成とファイル

### 3.1 Domain
- 1_entities
  - voice_memo_entity.dart
  - tag_entity.dart
  - transcription_status_entity.dart
- 2_repositories（抽象）
  - voice_memo_repository.dart
- 3_usecases
  - create_voice_memo.dart
  - update_voice_memo_meta.dart
  - move_to_trash.dart
  - restore_from_trash.dart
  - hard_delete_voice_memo.dart
  - list_voice_memos.dart
  - get_voice_memo_detail.dart
  - search_voice_memos.dart
  - request_transcription.dart

### 3.2 Application
- 1_states
  - voice_memo_list_state.dart
  - voice_memo_detail_state.dart
  - recording_state.dart
  - search_state.dart
- 2_providers（インターフェース公開・依存注入の起点）
  - voice_memo_repository_provider.dart
  - usecase_providers.dart
- 3_notifiers（@riverpod のアノテーションを使用）
  - voice_memo_list_notifier.dart
  - voice_memo_detail_notifier.dart
  - recording_notifier.dart
  - search_notifier.dart

### 3.3 Infrastructure
- 1_data_sources/1_local
  - voice_memo_dao.dart（ローカルDB/クエリ）
  - audio_storage.dart（音声ファイルI/O）
  - transcription_adapter.dart（文字起こし実行アダプタ：手動トリガー）
- 2_models（toEntity/fromEntity を内包、専用mappersは作成しない）
  - voice_memo_model.dart
  - tag_model.dart
- 3_repositories
  - voice_memo_repository_impl.dart（DAO/Storage/Adapter へ依存）

### 3.4 Presentation
- 2_pages
  - home_page.dart
  - memo_detail_page.dart
  - search_page.dart
  - settings_page.dart
  - trash_page.dart
- 1_widgets
  - 1_atoms: record_button.dart, tag_chip.dart
  - 2_molecules: memo_list_item.dart, search_bar_with_filters.dart
  - 3_organisms: memo_list_view.dart, memo_detail_view.dart

## 4. 依存関係の方向
- Domain ← Application ← Infrastructure（逆依存なし）
- Presentation → Application（Presentation から Domain へは直接依存しない）

## 5. ルーティング（命名）
- /home
- /memo_detail/:id
- /search
- /settings
- /trash

## 6. 永続化/ファイル運用
- メタ/索引: ローカルDB（DAO）
- 音声: audio_storage で端末内保存（パスをメタに保持）
- 文字起こし: transcription_adapter で実行、結果はメタへ保存

## 7. 実装順序と検証
1) Domain → 2) Application → 3) Infrastructure → 4) Presentation
- 各層ごとに `flutter analyze` を実行しエラー/警告0を維持
- Provider はインターフェース公開のみ、ロジックは Notifier に集約

## 8. 非機能上の留意
- パフォーマンス（録音開始の遅延最小化）
- プライバシー（端末内完結/最小権限）
- アクセシビリティ（フォント/スクリーンリーダ）

## 9. 将来拡張の前提
- transcription_adapter は差し替え可能（ローカル/リモート）
- クラウド同期追加時も Domain の変更最小化