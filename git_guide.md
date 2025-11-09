# Git ガイド

このドキュメントは、flutter_init プロジェクトでの Git 操作に関する包括的なガイドです。

## 目次

1. [基本的な Git コマンド](#基本的な-git-コマンド)
2. [ブランチ操作](#ブランチ操作)
3. [コミット操作](#コミット操作)
4. [リモートリポジトリ操作](#リモートリポジトリ操作)
5. [履歴とログ](#履歴とログ)
6. [差分と変更確認](#差分と変更確認)
7. [便利なオプション](#便利なオプション)
8. [トラブルシューティング](#トラブルシューティング)
9. [flutter_init 固有のワークフロー](#flutter_init-固有のワークフロー)

## 基本的な Git コマンド

### 初期設定
```powershell
# ユーザー情報の設定
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# デフォルトブランチ名の設定
git config --global init.defaultBranch main

# 設定確認
git config --list
```

### リポジトリの初期化とクローン
```powershell
# 新しいリポジトリを初期化
git init

# リモートリポジトリをクローン
git clone https://github.com/username/repository.git

# 特定のブランチをクローン
git clone -b branch-name https://github.com/username/repository.git
```

## ブランチ操作

### ブランチの作成と切り替え
```powershell
# ブランチ一覧を表示
git branch                  # ローカルブランチのみ
git branch -a              # リモートブランチも含む
git branch -r              # リモートブランチのみ

# 新しいブランチを作成
git branch feature/new-feature

# ブランチを作成して切り替え（従来の方法）
git checkout -b feature/new-feature

# ブランチを作成して切り替え（新しい方法）
git switch -c feature/new-feature

# 既存のブランチに切り替え
git checkout feature/existing-feature
git switch feature/existing-feature    # 新しい方法

# リモートブランチを追跡して新しいローカルブランチを作成
git checkout -b feature/remote-feature origin/feature/remote-feature
git switch -c feature/remote-feature origin/feature/remote-feature
```

### ブランチの削除
```powershell
# ローカルブランチを削除（マージ済みの場合）
git branch -d feature/completed-feature

# ローカルブランチを強制削除（マージされていない場合）
git branch -D feature/unwanted-feature

# リモートブランチを削除
git push origin --delete feature/old-feature
```

## コミット操作

### ファイルのステージング
```powershell
# 特定のファイルをステージング
git add filename.dart

# 全ての変更をステージング
git add .
git add -A

# 対話的にステージング
git add -i

# パッチ単位でステージング
git add -p filename.dart
```

### コミット
```powershell
# メッセージ付きでコミット
git commit -m "feat: add new authentication feature"

# ステージングとコミットを同時実行（追跡済みファイルのみ）
git commit -am "fix: resolve login validation issue"

# 詳細なコミットメッセージを入力
git commit

# 直前のコミットを修正
git commit --amend

# 直前のコミットメッセージを変更
git commit --amend -m "corrected commit message"
```

### コミットメッセージの規約
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type の種類:**
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント変更
- `style`: コードスタイル変更
- `refactor`: リファクタリング
- `test`: テスト追加・修正
- `chore`: その他の変更

## リモートリポジトリ操作

### リモートの管理
```powershell
# リモートリポジトリを追加
git remote add origin https://github.com/username/repository.git

# リモートリポジトリの一覧表示
git remote -v

# リモートリポジトリの詳細情報
git remote show origin

# リモートリポジトリのURLを変更
git remote set-url origin https://github.com/newusername/repository.git
```

### フェッチ、プル、プッシュ
```powershell
# リモートの変更をフェッチ（ローカルブランチは変更されない）
git fetch origin

# 全てのリモートから変更をフェッチ
git fetch --all

# 現在のブランチにリモートの変更をマージ
git pull origin main

# リベースしながらプル
git pull --rebase origin main

# ローカルの変更をプッシュ
git push origin feature/your-branch

# 初回プッシュ時に上流ブランチを設定
git push -u origin feature/your-branch

# 強制プッシュ（注意して使用）
git push --force-with-lease origin feature/your-branch
```

## 履歴とログ

### ログの表示
```powershell
# 基本的なログ表示
git log

# 一行でコミット履歴を表示
git log --oneline

# グラフ表示で履歴を確認
git log --graph --oneline --all

# 特定のファイルの履歴
git log -- filename.dart

# 作者でフィルター
git log --author="Your Name"

# 日付でフィルター
git log --since="2024-01-01" --until="2024-12-31"

# コミットメッセージで検索
git log --grep="bug fix"
```

### ステータスとディレクトリの状態
```powershell
# 現在の状態を表示
git status

# 簡潔な状態表示
git status -s

# 無視されているファイルも表示
git status --ignored
```

## 差分と変更確認

### 差分の表示
```powershell
# 作業ディレクトリとステージングエリアの差分
git diff

# ステージングエリアと最新コミットの差分
git diff --cached
git diff --staged

# 作業ディレクトリと最新コミットの差分
git diff HEAD

# 特定のファイルの差分
git diff filename.dart

# 2つのコミット間の差分
git diff commit1 commit2

# 2つのブランチ間の差分
git diff main feature/new-feature
```

### 変更されたファイルの確認
```powershell
# 変更されたファイル名のみ表示
git diff --name-only

# 変更されたファイルと変更行数
git diff --stat

# 単語単位での差分表示
git diff --word-diff
```

## 便利なオプション

### グローバルオプション
```powershell
# 特定のディレクトリで Git コマンドを実行
git -C /path/to/repository status

# 一時的な設定でコマンド実行
git -c user.name="Temporary Name" commit -m "message"

# ページャーを無効にして出力
git --no-pager log --oneline

# バージョン確認
git --version
```

### エイリアス設定
```powershell
# よく使うコマンドにエイリアスを設定
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# 使用例
git st                     # git status の代わり
git co main               # git checkout main の代わり
git unstage filename.dart # git reset HEAD filename.dart の代わり
```

## トラブルシューティング

### よくある問題と解決方法

#### マージコンフリクトの解決
```powershell
# マージでコンフリクトが発生した場合
git status                 # コンフリクトファイルを確認
# ファイルを手動で編集してコンフリクトを解決
git add resolved-file.dart
git commit -m "resolve merge conflict"
```

#### 間違ったコミットの修正
```powershell
# 直前のコミットを取り消し（変更は保持）
git reset --soft HEAD~1

# 直前のコミットを完全に取り消し
git reset --hard HEAD~1

# 特定のコミットを取り消し（新しいコミットを作成）
git revert commit-hash
```

#### ファイルの復元
```powershell
# 作業ディレクトリの変更を破棄
git checkout -- filename.dart
git restore filename.dart

# ステージングエリアから削除
git reset HEAD filename.dart
git restore --staged filename.dart

# 特定のコミットからファイルを復元
git checkout commit-hash -- filename.dart
```

#### ブランチの復元
```powershell
# 削除したブランチの復元
git reflog               # 削除前のコミットハッシュを確認
git checkout -b recovered-branch commit-hash
```

## flutter_init 固有のワークフロー

### 推奨ブランチ命名規則
```powershell
# 機能開発
git checkout -b feature/authentication
git checkout -b feature/user-profile
git checkout -b feature/travel-planning

# バグ修正
git checkout -b fix/login-validation
git checkout -b fix/navigation-issue

# ドキュメント更新
git checkout -b docs/api-documentation
git checkout -b docs/readme-update

# リファクタリング
git checkout -b refactor/auth-service
git checkout -b refactor/state-management
```

### 開発フロー例
```powershell
# 1. 最新のメインブランチに切り替え
git checkout main
git pull origin main

# 2. 新しい機能ブランチを作成
git checkout -b feature/travel-booking

# 3. 開発作業とコミット
git add .
git commit -m "feat: implement travel booking functionality"

# 4. リモートにプッシュ
git push -u origin feature/travel-booking

# 5. プルリクエスト作成後、マージ完了したらブランチを削除
git checkout main
git pull origin main
git branch -d feature/travel-booking
git push origin --delete feature/travel-booking
```

### Stage ごとの Git 操作

#### Stage1: 仕様策定
```powershell
git checkout -b docs/application-specification
# AI/document/application_specification.md を更新
git add AI/document/application_specification.md
git commit -m "docs: update application specification for travel app"
```

#### Stage2: 構造計画
```powershell
git checkout -b docs/structure-plan
# AI/document/structure_plan.md を更新
git add AI/document/structure_plan.md
git commit -m "docs: define project structure for travel features"
```

#### Stage3: 実装
```powershell
git checkout -b feature/core-implementation
# Core 基盤の実装
git add lib/core/
git commit -m "feat: implement core architecture foundation"

git checkout -b feature/travel-domain
# Domain層の実装
git add lib/features/shared/travel/1_domain/
git commit -m "feat: implement travel domain layer"
```

## まとめ

このガイドでは、flutter_init プロジェクトでの Git 操作について説明しました。効率的な開発のために：

1. **明確なブランチ命名規則**を使用する
2. **意味のあるコミットメッセージ**を書く
3. **小さく頻繁なコミット**を心がける
4. **Stage ごとにブランチを分ける**
5. **定期的にリモートと同期**する

詳細なトラブルシューティングや高度な操作については、公式ドキュメントやチームのガイドラインを参照してください。

---

*最終更新: 2025年10月27日*