# 🚚 構造ルールへの移行ガイド（3-2）

> 目的: 段階計画に基づき、実コードを本テンプレート構造へ移行する具体手順を示す。

## 手順
1. Core の導入
   - [ ] `lib/core/` を作成し、`routing/theme/api/exceptions/database` を最小構成で用意
   - [ ] 既存の共通設定・クライアント類を Core に集約
2. フィーチャー骨格の整備
   - [ ] `lib/features/<permission>/<feature>/1_domain..4_presentation` のディレクトリのみ先に作成（中身は段階投入）
3. ドメインから移行
   - [ ] エンティティ/リポジトリ/ユースケースを Domain に移し、API/DB 具体は Infra へ分離
4. アプリケーション層の確立
   - [ ] Provider/Notifier/State を新設し、UI からの参照経路を一本化
5. プレゼンテーションの整理
   - [ ] Widgets/Pages を整理し、直 import 禁止（必ず Application 経由）

## 互換運用
- 旧コードはアダプタ経由で当面動作を維持し、段階的に置換
- 画面遷移は `core/routing` に集約し、直書きパスを排除

