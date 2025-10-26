# flutter_init

テンプレートと AI ガイドを組み合わせ、クリーンアーキテクチャ構成の Flutter アプリを段階的に構築するためのスタータープロジェクトです。リポジトリ内のドキュメントとスクリプトを利用し、仕様策定 → 構造計画 → 実装の 3 フェーズで開発を進めます。

## 開発プロセス

全 IDE 向けに `.github/chatmodes/flutter.chatmode.md`、`.cursor/rules/project-rules.mdc`、`.trae/rules/project_rules.md` が同一方針を共有しています。各フェーズの詳細チェックリストは `AI/instructions` を参照してください。

1. **仕様策定（Stage1）**
   - 目的、ターゲット、機能、ユースケースをヒアリングし `AI/document/application_specification.md` を更新します。
   - 技術選定は `AI/architecture/technology_stack.md` に従います。

2. **構造計画（Stage2）**
   - 仕様を反映したファイル一覧を整理し、`AI/document/structure_plan.md` に記載します。
   - クリーンアーキテクチャのフォルダ構成（`AI/architecture/lib/features/features_architecture.md`）を厳守し、新規ディレクトリの追加は禁止です。

3. **実装（Stage3）**
   - `generate_core.sh` / `init_core_exceptions.sh` により Core 基盤を生成し、機能単位は `generate_feature.sh` でテンプレート化します。
   - Domain → Infrastructure → Application → Presentation の順に各層を実装し、各層完了時に `flutter analyze` を実行します。

フェーズ間で仕様変更が発生した場合は、前段階に戻って合意・記録を更新してください。

## リポジトリ構成

```
.
├── AI/
│   ├── architecture/            # 各層の詳細ガイドと技術スタック
│   ├── document/                # 仕様書・構造計画書テンプレート
│   ├── instructions/            # 3 フェーズの運用ルール
│   ├── logs/                    # 作業ログ（conversation_log.md）
│   └── scripts/                 # init/generate 系ユーティリティ（bash と ps1）
├── .github/chatmodes/           # Copilot Chat 用モード定義
├── .cursor/rules/               # Cursor IDE 用ルール
├── .trae/rules/                 # Trae IDE 用ルール
├── LICENSE
└── README.md
```

## スクリプト一覧

| スクリプト | 説明 |
| --- | --- |
| `AI/scripts/bash/init_project.sh` | `flutter create .` や初期設定を自動化（`--yes` で非対話実行）。 |
| `AI/scripts/bash/add_dependencies.sh` | `technology_stack.md` 推奨依存を追加。 |
| `AI/scripts/bash/generate_core.sh` | `lib/core` の基盤構造を生成。 |
| `AI/scripts/bash/init_core_exceptions.sh` | 共通例外クラスを生成。 |
| `AI/scripts/bash/generate_feature.sh` | フィーチャーディレクトリと雛形ファイルを生成。 Powershell 版も同名で用意。 |

`generate_feature.sh` は `-n` でフィーチャー名、`-p` で配置パス（`admin/user/shared/direct`）を指定できます。

## 実装ガイドライン

- **構造**: `lib/features/<permission>/<feature>/` 配下に Domain → Infrastructure → Application → Presentation を用意します。
- **命名**: Snake case を使用し、各層の責務に合わせたファイル名・クラス名にします。
- **依存**: 上位層から下位層への一方向依存を維持し、共通処理は Core に集約します。
- **状態管理**: Riverpod と hooks を使用し、Presentation 層は基本的に `HookWidget` / `HookConsumerWidget` を採用します。
- **コード生成**: Freezed・Riverpod Generator・Drift などの build_runner ベースツールを適用し、`dart run build_runner build --delete-conflicting-outputs` を利用します。

## セットアップ手順


1. **新しいアプリを作成する場合**:
   ```bash
   # このリポジトリをクローン
   git clone https://github.com/utakata-haru/flutter_init.git
   cd flutter_init
   
   # 新しいブランチを作成して開発開始
   git checkout -b feature/your-app-name
   ```

2. **新しいリポジトリとして開発を開始する場合**:
   ```bash
   # このリポジトリをクローン
   git clone https://github.com/utakata-haru/flutter_init.git
   cd flutter_init
   
   # 既存のGit履歴を削除
   rm -rf .git
   
   # 新しいGitリポジトリを初期化
   git init
   
   # 初期コミットを作成
   git add .
   git commit -m "Initial commit: Flutter project template"
   
   # 新しいリモートリポジトリを追加（GitHubで新しいリポジトリを作成後）
   git remote add origin https://github.com/your-username/your-new-repo.git
   
   # メインブランチにプッシュ
   git branch -M main
   git push -u origin main
   ```

# Flutter プロジェクト初期化（既存の lib/ を上書きする場合は注意）
./AI/scripts/bash/init_project.sh --yes

# 推奨依存を追加
./AI/scripts/bash/add_dependencies.sh --yes

# Core 基盤を生成（未生成の場合）
./AI/scripts/bash/generate_core.sh --yes
./AI/scripts/bash/init_core_exceptions.sh --yes

# 機能テンプレートを生成
./AI/scripts/bash/generate_feature.sh -n Sample -p shared -y
```

Windows では同名の `.ps1` スクリプトを PowerShell から実行してください。

## ライセンス

LICENSE に記載されたカスタムライセンスに従います。個人利用は自由ですが、商用利用には事前許可が必要です。

## サポート

不明点やエラーは Issues や `AI/logs/conversation_log.md` に記録し、関連ドキュメント（仕様書・構造計画書・ instructions）を更新してから次の作業へ進んでください。

Happy building! 🚀