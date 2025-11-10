
## 概要（このファイルの役割）

- 本ファイルは「全体の流れ」を抽象的に示すインデックスです。
- 具体的な手順・チェックリスト・コマンドは、段階ごとに分割したファイルを参照してください。
- フローは「仕様策定 → 構造計画 → 実装」の3段階で進行し、必要に応じて前段階に戻って合意形成を行います。

## プロセス全体像（抽象）

- 第一段階（仕様策定）
  - ヒアリングで要件を集め、仕様書草案を作成し、詳細化して合意します。
  - 成果物: アプリケーション仕様書（`AI/document/application_specification.md`）
- 第二段階（構造計画）
  - 既存のアーキテクチャルールに厳密準拠し、必要ファイルを計画・レビュー・合意します。
  - 成果物: 構造計画書（`AI/document/structure_plan.md`）
- 第三段階（実装）
  - 実装ルールを再確認し、レイヤー別に実装 → レビュー → 最終検証 → ドキュメント更新 → ログ記録 → 次のフィーチャーへ。
  - 成果物: 動作するアプリケーションと更新済みドキュメント／ログ

## 詳細ドキュメントへの案内（段階別ファイル）

詳細は以下のファイルを順に参照してください。

- 第一段階（仕様策定）
  - `AI/instructions/new_app/001/project_rules_stage1_step1.md`（プロセス開始とヒアリング）
  - `AI/instructions/new_app/001/project_rules_stage1_step2.md`（仕様書草案の作成）
  - `AI/instructions/new_app/001/project_rules_stage1_step3.md`（仕様の深掘りと厳密化）
  - `AI/instructions/new_app/001/project_rules_stage1_step4.md`（仕様書完成とフェーズ完了）

- 第二段階（構造計画）
  - `AI/instructions/new_app/002/project_rules_stage2_step1.md`（プロセス開始とルール確認）
  - `AI/instructions/new_app/002/project_rules_stage2_step2.md`（構造計画書草案の作成）
  - `AI/instructions/new_app/002/project_rules_stage2_step3.md`（計画のレビューと修正）
  - `AI/instructions/new_app/002/project_rules_stage2_step4.md`（構造計画書完成とフェーズ完了）

- 第三段階（実装）
  - `AI/instructions/new_app/003/project_rules_stage3_step1.md`（プロセス開始とルール再確認）
  - `AI/instructions/new_app/003/project_rules_stage3_step2.md`（実装計画の提示と合意）
  - 準備／遵守事項: `AI/instructions/new_app/003/project_rules_stage3_step3_0_overview.md`
  - レイヤー別実装
    - Domain: `AI/instructions/new_app/003/project_rules_stage3_step3_1_domain.md`
    - Infrastructure: `AI/instructions/new_app/003/project_rules_stage3_step3_2_infrastructure.md`
    - Application: `AI/instructions/new_app/003/project_rules_stage3_step3_3_application.md`
    - Presentation: `AI/instructions/new_app/003/project_rules_stage3_step3_4_presentation.md`
  - レビューとイテレーション: `AI/instructions/new_app/003/project_rules_stage3_step4.md`
  - 最終検証・ドキュメント再確認・保存・ログ
    - `AI/instructions/new_app/003/project_rules_stage3_step5_1_final_verification.md`
    - `AI/instructions/new_app/003/project_rules_stage3_step5_2_document_reconfirmation.md`
    - `AI/instructions/new_app/003/project_rules_stage3_step5_3_save_and_reference.md`
    - `AI/instructions/new_app/003/project_rules_stage3_step5_4_logging.md`
  - フェーズ完了: `AI/instructions/new_app/003/project_rules_stage3_step6.md`
  - 次のフィーチャーへ: `AI/instructions/new_app/003/project_rules_stage3_step7.md`

## 重要事項（抽象）

- 段階の厳守: 各フェーズの目的に集中し、先の内容に飛ばない。
- 主導権の維持: プロジェクトマネージャーとして対話をリードし、合意形成を重視。
- ドキュメント駆動: 仕様書／構造計画書への反映と更新履歴の記録を徹底。

## 開発サイクル（抽象）

- 仕様策定 → 構造計画 → 実装 → 次のフィーチャーへ（必要なら仕様策定に回帰）。

---

詳細なチェックリストやコマンドは、上記の分割ファイルを参照してください。

---