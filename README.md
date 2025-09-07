# Flutter Init - Flutterアプリ開発テンプレート

## 📋 概要

`flutter_init`は、Flutterアプリケーション開発を効率的に開始するためのテンプレートリポジトリです。クリーンアーキテクチャに基づいた構造化されたプロジェクトセットアップと、AI支援による開発フローを提供します。

## 🚀 使用方法

### 重要なブランチ戦略

⚠️ **重要**: `main`ブランチには直接コミットしないでください。

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

3. **開発の開始**:
   - ブランチを作成後、AIアシスタントまたは手動でFlutterプロジェクトを初期化
   - 提供されたテンプレートとスクリプトを活用して開発を進める

## 🏗️ プロジェクト構造

```
flutter_init/
├── .github/
│   └── chatmodes/
│       └── flutter.chatmode.md     # VS Code用AIアシスタント設定
├── .cursor/
│   └── rules/
│       └── project-rules.mdc       # Cursor IDE用ワークスペースルール
├── .trae/
│   └── rules/
│       └── project_rules.md        # Trae AI IDE用プロジェクトルール
├── AI/
│   ├── document/
│   │   ├── application_specification.md  # アプリケーション仕様書
│   │   └── structure_plan.md             # 構造計画書
│   ├── instructions/
│   │   ├── architecture/                 # クリーンアーキテクチャ詳細設計
│   │   │   └── lib/
│   │   │       └── features/
│   │   │           ├── 1_domain/         # ドメイン層設計
│   │   │           ├── 2_infrastructure/ # インフラ層設計
│   │   │           ├── 3_application/    # アプリケーション層設計
│   │   │           └── 4_presentation/   # プレゼンテーション層設計
│   │   ├── features_template.md     # クリーンアーキテクチャテンプレート
│   │   └── technology_stack.md     # 技術スタック定義
│   ├── logs/
│   │   └── conversation_log.md     # 開発ログ
│   └── scripts/
│       ├── generate_feature.ps1    # フィーチャー自動生成スクリプト（Windows）
│       └── generate_feature.sh     # フィーチャー自動生成スクリプト（Unix）
├── .gitignore                      # Git除外設定
├── LICENSE                         # ライセンス
└── README.md                       # このファイル
```

## 🤖 AIアシスタント機能

### Flutter App Builder

このリポジトリは複数のAI開発環境に対応しています：

#### VS Code + GitHub Copilot
`.github/chatmodes/flutter.chatmode.md`で定義されたカスタムモードが、段階的なアプリケーション開発をサポートします。

#### Cursor IDE
`.cursor/rules/`で定義されたワークスペースルールが、Claude Sonnet 4による高精度な開発支援を提供します。Cursor環境では、リアルタイムなコード補完と3段階の構造化開発プロセスが利用できます。

#### Trae AI IDE
`.trae/rules/project_rules.md`で定義されたプロジェクトルールが、VS Code環境と同等の開発支援を提供します。Trae環境では、より高度なコード生成とリアルタイムな開発支援が利用できます。

#### 開発プロセス（3段階）

1. **🎯 第一段階：仕様策定フェーズ**
   - アプリケーションの要件定義
   - 詳細な仕様書の作成
   - ターゲットユーザーと機能の明確化

2. **🏗️ 第二段階：構造計画フェーズ**
   - クリーンアーキテクチャに基づいたファイル構成計画
   - 必要なDartファイルの洗い出し
   - 構造計画書の作成

3. **💻 第三段階：実装フェーズ**
   - 実際のコード実装
   - レイヤーごとの段階的開発
   - 動作検証とテスト

## 🛠️ 自動フィーチャー生成

### generate_feature.sh スクリプト

クリーンアーキテクチャに基づいたフィーチャーディレクトリを自動生成します。

#### 使用方法

```bash
# 対話形式で実行
./AI/generate_feature.sh

# コマンドライン引数で実行
./AI/generate_feature.sh -n UserProfile -p user -y
```

#### 権限レベル

- **admin**: 管理者専用機能
- **user**: 一般ユーザー機能  
- **shared**: 共通機能（認証、共通UIコンポーネントなど）
- **direct**: features下に直接配置

#### 生成されるディレクトリ構造

```
lib/features/{permission_level}/{feature_name_snake}/
├── 1_domain/
│   ├── 1_entities/           # エンティティ（ビジネスオブジェクト）
│   ├── 2_repositories/       # リポジトリインターフェース
│   ├── 3_usecases/           # ユースケース（ビジネスロジック）
│   └── exceptions/           # ドメイン例外
├── 2_infrastructure/
│   ├── 1_models/           # データモデル
│   ├── 2_data_sources/
│   │   ├── 1_local/        # ローカルデータソース
│   │   │   └── exceptions/ # ローカルデータソース例外
│   │   └── 2_remote/       # リモートデータソース
│   │       └── exceptions/ # リモートデータソース例外
│   └── 3_repositories/     # リポジトリ実装
├── 3_application/
│   ├── 1_states/             # 状態クラス
│   ├── 2_providers/          # プロバイダー定義
│   └── 3_notifiers/          # 状態管理（Riverpod Notifier）
└── 4_presentation/
    ├── 2_pages/            # ページ（画面）
    └── 1_widgets/
        ├── 1_atoms/        # 原子コンポーネント
        ├── 2_molecules/    # 分子コンポーネント
        └── 3_organisms/    # 有機体コンポーネント
```

## 📚 技術スタック

### 主要ライブラリ

| カテゴリ | ライブラリ | 役割 |
|----------|------------|------|
| 状態管理 | riverpod, hooks_riverpod | DIコンテナと状態管理 |
| データモデル | freezed | イミュータブルなデータクラス生成 |
| 画面遷移 | go_router | 型安全なルーティング |
| ローカルDB | drift | 型安全なローカルデータベース |
| UI補助 | flutter_hooks | ウィジェットの状態管理 |

### アーキテクチャ原則

- **クリーンアーキテクチャ**: 4層構造による責務分離
- **依存性注入**: Riverpodによる型安全なDI
- **イミュータブル設計**: Freezedによるデータクラス
- **テスト駆動開発**: テストしやすい設計

## 📖 開発ガイドライン

### 1. 新機能開発の流れ

1. **フィーチャー生成**: `generate_feature.sh`でディレクトリ構造を作成
2. **ドメイン層**: エンティティとユースケースを定義
3. **インフラ層**: データソースとリポジトリを実装
4. **アプリケーション層**: 状態管理とビジネスロジックを実装
5. **プレゼンテーション層**: UIコンポーネントとページを作成

### 2. コーディング規約

- **命名規則**: snake_caseでフィーチャー名を定義
- **ファイル構成**: 各層の責務を明確に分離
- **依存関係**: 上位層から下位層への一方向依存
- **テスト**: 各層に対応するテストを作成

## 🔧 セットアップ

### 前提条件

- Flutter SDK (最新安定版)
- Dart SDK
- Git
- AI開発環境（VS Code + GitHub Copilot、Cursor IDE、または Trae AI IDE）

### 初期セットアップ

1. **リポジトリのクローン**:
   ```bash
   git clone https://github.com/your-username/flutter_init.git
   cd flutter_init
   ```

2. **新しいブランチの作成**:
   ```bash
   git checkout -b feature/your-project-name
   ```

3. **Flutterプロジェクトの初期化**:
   ```bash
   flutter create .
   ```

4. **依存関係の追加**:
   `AI/instructions/technology_stack.md`を参考にpubspec.yamlを設定

### AI環境別セットアップ

#### VS Code環境
1. GitHub Copilotを有効化
2. `.github/chatmodes/flutter.chatmode.md`のカスタムモードを使用
3. Copilot Chatでフィーチャー開発を開始

#### Cursor IDE環境
1. プロジェクトを開くと`.cursor/rules/`のワークスペースルールが自動的に読み込まれます
2. Claude Sonnet 4による Flutter App Builder として3段階の開発プロセスが利用可能
3. 高精度なコード生成と構造化されたアプリケーション開発支援

#### Trae AI IDE環境
1. プロジェクトを開くと`.trae/rules/project_rules.md`が自動的に読み込まれます
2. Flutter App Builderとして3段階の開発プロセスが利用可能
3. クリーンアーキテクチャに基づいた自動コード生成とリアルタイム支援

## 📝 ライセンス

このプロジェクトは以下のライセンス条件の下で公開されています：

### 利用条件

- **個人利用**: 無許可で自由に利用可能
- **商用利用**: 事前の許可が必要

### 詳細

- 個人的な学習、研究、非営利目的での利用は自由です
- 商用プロジェクトでの利用を希望される場合は、事前にお問い合わせください
- 再配布時は本ライセンス条件を明記してください

詳細なライセンス条項については、[LICENSE](LICENSE)ファイルをご確認ください。

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add some amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📺 関連チャンネル

### 泡沫Code

本プロジェクトの開発者によるYouTubeチャンネルです。Flutterアプリ開発に関する解説動画を配信しています。

🔗 **チャンネルURL**: [https://www.youtube.com/@utakata_code](https://www.youtube.com/@utakata_code)

- スマホだけでできるAndroidアプリ開発
- Flutter開発のコツとテクニック
- 実践的なアプリ開発チュートリアル

## 📞 サポート

質問や問題がある場合は、GitHubのIssuesページでお気軽にお問い合わせください。

---

**Happy Coding! 🚀**