# シンプルメモアプリ - 構造計画書

## 📋 基本情報

- **作成日**: 2025年9月1日
- **アプリ名**: シンプルメモ
- **フィーチャー名**: note_management（メモ管理機能）
- **権限レベル**: user（一般ユーザー機能）

## 🏗️ アーキテクチャ構造

### フィーチャー配置パス
```
lib/features/user/note_management/
```

## 📁 ファイル構成計画（正しい命名規則適用）

### 1️⃣ Domain層（ドメイン層）

#### 1_entities/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_entity.dart` | `lib/features/user/note_management/1_domain/1_entities/note_entity.dart` | メモエンティティ。メモの基本構造を定義（id, title, content, createdAt, updatedAt） |

#### 2_repositories/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_repository.dart` | `lib/features/user/note_management/1_domain/2_repositories/note_repository.dart` | メモリポジトリのインターフェース。CRUD操作とサーチ機能を定義 |

#### 3_usecases/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `create_note_usecase.dart` | `lib/features/user/note_management/1_domain/3_usecases/create_note_usecase.dart` | メモ作成ユースケース |
| `get_notes_usecase.dart` | `lib/features/user/note_management/1_domain/3_usecases/get_notes_usecase.dart` | メモ一覧取得ユースケース |
| `get_note_by_id_usecase.dart` | `lib/features/user/note_management/1_domain/3_usecases/get_note_by_id_usecase.dart` | メモ詳細取得ユースケース |
| `update_note_usecase.dart` | `lib/features/user/note_management/1_domain/3_usecases/update_note_usecase.dart` | メモ更新ユースケース |
| `delete_note_usecase.dart` | `lib/features/user/note_management/1_domain/3_usecases/delete_note_usecase.dart` | メモ削除ユースケース |
| `search_notes_usecase.dart` | `lib/features/user/note_management/1_domain/3_usecases/search_notes_usecase.dart` | メモ検索ユースケース |

### 2️⃣ Infrastructure層（インフラ層）

#### 1_models/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_model.dart` | `lib/features/user/note_management/2_infrastructure/1_models/note_model.dart` | メモデータモデル。JSON⇔Entityの変換とSQLite用のマッピング |

#### 2_data_sources/1_local/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_local_data_source.dart` | `lib/features/user/note_management/2_infrastructure/2_data_sources/1_local/note_local_data_source.dart` | ローカルデータソース。SQLiteへのCRUD操作を実装 |

#### 2_data_sources/2_remote/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| *(ファイルなし)* | - | リモートデータソースは不要（ローカルのみの仕様） |

#### 3_repositories/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_repository_impl.dart` | `lib/features/user/note_management/2_infrastructure/3_repositories/note_repository_impl.dart` | メモリポジトリ実装。Domain層のインターフェースを実装 |

### 3️⃣ Application層（アプリケーション層）

#### 1_states/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_state.dart` | `lib/features/user/note_management/3_application/1_states/note_state.dart` | メモ関連の状態クラス。読み込み状態、エラー状態、データ状態を定義 |

#### 2_providers/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_providers.dart` | `lib/features/user/note_management/3_application/2_providers/note_providers.dart` | 依存性注入Provider。Repository、UseCaseのインスタンス生成 |

#### 3_notifiers/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_list_notifier.dart` | `lib/features/user/note_management/3_application/3_notifiers/note_list_notifier.dart` | メモ一覧の状態管理。一覧表示、検索機能を管理 |
| `note_form_notifier.dart` | `lib/features/user/note_management/3_application/3_notifiers/note_form_notifier.dart` | メモ作成・編集フォームの状態管理。入力値とバリデーションを管理 |

### 4️⃣ Presentation層（プレゼンテーション層）

#### 2_pages/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_list_page.dart` | `lib/features/user/note_management/4_presentation/2_pages/note_list_page.dart` | メモ一覧画面。メモリスト表示、検索機能、新規作成ボタン |
| `note_form_page.dart` | `lib/features/user/note_management/4_presentation/2_pages/note_form_page.dart` | メモ作成・編集画面。タイトル・本文入力、保存・削除機能 |

#### 1_widgets/1_atoms/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_search_bar_atom.dart` | `lib/features/user/note_management/4_presentation/1_widgets/1_atoms/note_search_bar_atom.dart` | 検索バーコンポーネント |
| `note_input_field_atom.dart` | `lib/features/user/note_management/4_presentation/1_widgets/1_atoms/note_input_field_atom.dart` | メモ入力フィールドコンポーネント |
| `note_action_button_atom.dart` | `lib/features/user/note_management/4_presentation/1_widgets/1_atoms/note_action_button_atom.dart` | アクションボタン（保存、削除等） |

#### 1_widgets/2_molecules/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_list_item_molecule.dart` | `lib/features/user/note_management/4_presentation/1_widgets/2_molecules/note_list_item_molecule.dart` | メモリストアイテム。タイトル、本文プレビュー、作成日時を表示 |
| `note_form_fields_molecule.dart` | `lib/features/user/note_management/4_presentation/1_widgets/2_molecules/note_form_fields_molecule.dart` | メモフォームフィールド群。タイトル・本文入力エリア |

#### 1_widgets/3_organisms/
| ファイル名 | 配置パス | 役割 |
|------------|----------|------|
| `note_list_view.dart` | `lib/features/user/note_management/4_presentation/1_widgets/3_organisms/note_list_view.dart` | メモリスト全体。リストアイテムの集合とスクロール機能 |
| `note_form_section.dart` | `lib/features/user/note_management/4_presentation/1_widgets/3_organisms/note_form_section.dart` | メモフォーム全体。入力フィールドとアクションボタンの集合 |

## 📋 各層の命名規則（architectureルール準拠）

### 1️⃣ Domain層
| レイヤー | ファイル命名形式 | クラス命名形式 | 例 |
|----------|------------------|----------------|-----|
| **Entities** | `{対象名}_entity.dart` | `{対象名}Entity` | `note_entity.dart` → `NoteEntity` |
| **Repositories** | `{対象名}_repository.dart` | `{対象名}Repository` | `note_repository.dart` → `NoteRepository` |
| **UseCases** | `{機能名}_usecase.dart` | `{機能名}UseCase` | `create_note_usecase.dart` → `CreateNoteUseCase` |

### 2️⃣ Infrastructure層
| レイヤー | ファイル命名形式 | クラス命名形式 | 例 |
|----------|------------------|----------------|-----|
| **Models** | `{対象名}_model.dart` | `{対象名}Model` | `note_model.dart` → `NoteModel` |
| **Local Data Sources** | `{対象名}_local_data_source.dart` | `{対象名}LocalDataSource` | `note_local_data_source.dart` → `NoteLocalDataSource` |
| **Repository Impl** | `{対象名}_repository_impl.dart` | `{対象名}RepositoryImpl` | `note_repository_impl.dart` → `NoteRepositoryImpl` |

### 3️⃣ Application層
| レイヤー | ファイル命名形式 | クラス命名形式 | 例 |
|----------|------------------|----------------|-----|
| **States** | `{対象名}_state.dart` | `{対象名}State` | `note_state.dart` → `NoteState` |
| **Providers** | `{機能名}_providers.dart` | `{対象名}Provider` | `note_providers.dart` → `noteRepositoryProvider` |
| **Notifiers** | `{対象名}_notifier.dart` | `{対象名}Notifier` | `note_list_notifier.dart` → `NoteListNotifier` |

### 4️⃣ Presentation層
| レイヤー | ファイル命名形式 | クラス命名形式 | 例 |
|----------|------------------|----------------|-----|
| **Pages** | `{画面名}_page.dart` | `{画面名}Page` | `note_list_page.dart` → `NoteListPage` |
| **Atoms** | `{機能名}_atom.dart` | `Custom{コンポーネント名}` | `note_search_bar_atom.dart` → `CustomSearchBar` |
| **Molecules** | `{機能名}_molecule.dart` | `{機能名}Card/Bar/Group` | `note_list_item_molecule.dart` → `NoteListCard` |
| **Organisms** | `{機能名}_view.dart` | `{機能名}View/Section` | `note_list_view.dart` → `NoteListView` |

## 📋 機能とファイルの対応関係

### 🎯 仕様書の機能網羅チェック

| 仕様書の機能 | 対応するファイル | 実装レイヤー |
|-------------|------------------|-------------|
| **メモ作成** | `create_note_usecase.dart`, `note_form_notifier.dart`, `note_form_page.dart` | Domain → Application → Presentation |
| **メモ一覧表示** | `get_notes_usecase.dart`, `note_list_notifier.dart`, `note_list_page.dart` | Domain → Application → Presentation |
| **メモ編集** | `update_note_usecase.dart`, `note_form_notifier.dart`, `note_form_page.dart` | Domain → Application → Presentation |
| **メモ削除** | `delete_note_usecase.dart`, `note_form_notifier.dart`, `note_action_button_atom.dart` | Domain → Application → Presentation |
| **メモ検索** | `search_notes_usecase.dart`, `note_list_notifier.dart`, `note_search_bar_atom.dart` | Domain → Application → Presentation |
| **ローカル保存** | `note_local_data_source.dart`, `note_repository_impl.dart` | Infrastructure |

## 🔄 データフロー設計

```
UI (Presentation) 
    ↓ ユーザー操作
Notifier (Application) 
    ↓ ビジネスロジック呼び出し
UseCase (Domain) 
    ↓ データ操作要求
Repository Interface (Domain) 
    ↓ 実装委譲
Repository Implementation (Infrastructure) 
    ↓ データアクセス
Local Data Source (Infrastructure) 
    ↓ SQLite操作
Database
```

## ⚠️ 重要な設計原則

### 依存関係の方向
- **Presentation → Application → Domain**
- **Infrastructure → Domain** （インターフェースに依存）
- **逆方向の依存は禁止**

### ファイル分割の理由
- **単一責任原則**: 各ファイルが1つの責務のみを持つ
- **テストしやすさ**: 個別の機能単位でテスト可能
- **保守性**: 機能追加・変更時の影響範囲を最小化
- **再利用性**: UIコンポーネントの他画面での再利用

---

## 📝 更新履歴

### Version 1.0.1 (2025年9月1日)
- 構造計画書を正しい命名規則で再作成
- AI/instructions/architecture各層のinstructions.mdルールに準拠
- entities層: `{対象名}_entity.dart` 形式に修正
- usecases層: `{機能名}_usecase.dart` 形式に修正
- atoms層: `{機能名}_atom.dart` 形式に修正
- molecules層: `{機能名}_molecule.dart` 形式に修正
- organisms層: `{機能名}_view.dart`, `{機能名}_section.dart` 形式に修正

### Version 1.0.0 (2025年9月1日)
- 初回構造計画書作成
- シンプルメモアプリの全ファイル構成計画完了
- 仕様書の全機能を網羅したファイル配置計画確定
