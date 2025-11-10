# ♻️ 機能追加・修正フロー（ドキュメント同期運用）

> 目的: 機能の追加・修正時に、仕様書・構造計画書とコードを同期させてドリフトを防ぐ。

## 標準フロー
1. 影響範囲の特定
   - [ ] 変更対象フィーチャー / 層（Domain→Infra→Application→Presentation）を明示
2. 仕様書更新（`AI/document/application_specification.md`）
   - [ ] 新規/変更ユースケース、画面遷移、データ要件の修正
3. 構造計画書更新（`AI/document/structure_plan.md`）
   - [ ] 追加/変更ファイルをファイル定義表へ追記（パス / ファイル名 / 役割）
4. 実装（厳密な順序）
   - [ ] Domain → Infrastructure → Application → Presentation の順に変更
5. 検証
   - [ ] `flutter analyze`
   - [ ] 動作確認（主要シナリオ）
6. ログ
   - [ ] `AI/logs/conversation_log.md` に概要と影響範囲を記録

## 軽量フロー（バグ修正など）
- 仕様書に影響がない場合: 構造計画書のファイル定義表のみ更新 → 実装 → 検証 → ログ
- UIのみの微修正: Presentation層の範囲に限定し、層間責務違反がないか確認

