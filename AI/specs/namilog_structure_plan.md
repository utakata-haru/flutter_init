# NamiLog 構造計画書（草案）

> 本計画書は第二段階（構造計画フェーズ）の草案です。第一段階で合意された仕様書を基に、アーキテクチャ設計とファイル構成を詳細化します。

## 1. アーキテクチャ概要

### 1.1 フィーチャーベース構成
- **権限レベル**: `user`（一般ユーザー機能）
- **アーキテクチャ**: クリーンアーキテクチャ4層構造
- **フォルダ制約**: 新規フォルダ作成禁止、定義済みフォルダ内への配置のみ

### 1.2 技術スタック（AI/instructions/technology_stack.md準拠）
- **状態管理**: riverpod / hooks_riverpod
- **データモデル**: freezed + json_serializable
- **画面遷移**: go_router
- **ローカルDB**: sqflite
- **UI補助**: flutter_hooks

## 2. フィーチャー分析

### 2.1 主要フィーチャー（仕様書 MVP機能より）
1. **session_management**: セッション記録・一覧・詳細・編集・削除
2. **condition_presets**: 波/風/潮のプリセット選択・保存・表示
3. **spot_management**: スポット管理・お気に入り・検索
4. **gear_management**: ボード管理・履歴紐づけ
5. **calendar_statistics**: カレンダー表示・統計（簡易）
6. **settings**: 単位設定・プライバシー設定

### 2.2 共通機能
1. **shared/database**: SQLiteスキーマ・マイグレーション
2. **shared/routing**: go_router設定・画面遷移定義

## 3. ファイル構成計画

### 3.1 Session Management フィーチャー
**配置パス**: `lib/features/user/session_management/`

#### Domain層 (1_domain)
```
1_entities/
├── session_entity.dart           # セッションエンティティ（id, datetime, spotName, waveSize等）
├── session_filter_entity.dart    # フィルタリング条件エンティティ（月/週/スポット別）

2_repositories/
├── session_repository.dart       # セッションリポジトリインターフェース（CRUD操作）

3_usecases/
├── create_session_usecase.dart   # セッション新規作成ユースケース
├── get_sessions_usecase.dart     # セッション一覧取得ユースケース
├── get_session_detail_usecase.dart # セッション詳細取得ユースケース
├── update_session_usecase.dart   # セッション更新ユースケース
├── delete_session_usecase.dart   # セッション削除ユースケース
```

#### Application層 (2_application)
```
1_states/
├── session_state.dart            # セッション状態（initial/loading/loaded/error）
├── session_list_state.dart       # セッション一覧状態
├── session_form_state.dart       # セッション入力フォーム状態

2_providers/
├── session_providers.dart        # セッション関連プロバイダー定義

3_notifiers/
├── session_notifier.dart         # セッション状態管理ノーティファイア
├── session_list_notifier.dart    # セッション一覧状態管理ノーティファイア
├── session_form_notifier.dart    # セッションフォーム状態管理ノーティファイア
```

#### Infrastructure層 (3_infrastructure)
```
1_data_sources/
├── 1_local/
│   ├── session_local_data_source.dart # セッションローカルデータソース（SQLite操作）

2_models/
├── session_model.dart            # セッションデータモデル（JSON↔Entity変換）

3_repositories/
├── session_repository_impl.dart  # セッションリポジトリ実装
```

#### Presentation層 (4_presentation)
```
2_pages/
├── session_list_page.dart        # セッション一覧画面
├── session_detail_page.dart      # セッション詳細画面
├── session_form_page.dart        # セッション作成・編集画面

1_widgets/
├── 1_atoms/
│   ├── session_date_chip.dart    # 日付表示チップ
│   ├── wave_size_badge.dart      # 波サイズバッジ
│   ├── session_duration_text.dart # セッション時間表示テキスト
├── 2_molecules/
│   ├── session_list_item.dart    # セッション一覧アイテム
│   ├── session_summary_card.dart # セッション概要カード
│   ├── session_filter_bar.dart   # フィルタバー
├── 3_organisms/
│   ├── session_list_view.dart    # セッション一覧ビュー
│   ├── session_detail_view.dart  # セッション詳細ビュー
│   ├── session_form_view.dart    # セッションフォームビュー
```

### 3.2 Condition Presets フィーチャー
**配置パス**: `lib/features/user/condition_presets/`

#### Domain層 (1_domain)
```
1_entities/
├── wave_size_entity.dart         # 波サイズエンティティ（enum: flat, sune, hiza...）
├── wind_condition_entity.dart    # 風コンディションエンティティ（type, strength）
├── tide_condition_entity.dart    # 潮汐エンティティ（stage, cycle）

2_repositories/
├── condition_preset_repository.dart # プリセット設定リポジトリインターフェース

3_usecases/
├── get_wave_presets_usecase.dart # 波プリセット取得ユースケース
├── get_wind_presets_usecase.dart # 風プリセット取得ユースケース
├── get_tide_presets_usecase.dart # 潮汐プリセット取得ユースケース
```

#### Application層 (2_application)
```
1_states/
├── condition_preset_state.dart   # プリセット選択状態

2_providers/
├── condition_preset_providers.dart # プリセット関連プロバイダー

3_notifiers/
├── condition_preset_notifier.dart # プリセット選択状態管理
```

#### Infrastructure層 (3_infrastructure)
```
1_data_sources/
├── 1_local/
│   ├── condition_preset_local_data_source.dart # プリセット定数定義

2_models/
├── wave_size_model.dart          # 波サイズモデル
├── wind_condition_model.dart     # 風コンディションモデル
├── tide_condition_model.dart     # 潮汐モデル

3_repositories/
├── condition_preset_repository_impl.dart # プリセットリポジトリ実装
```

#### Presentation層 (4_presentation)
```
1_widgets/
├── 1_atoms/
│   ├── wave_preset_chip.dart     # 波プリセットチップ
│   ├── wind_preset_chip.dart     # 風プリセットチップ
│   ├── tide_preset_chip.dart     # 潮汐プリセットチップ
├── 2_molecules/
│   ├── wave_preset_selector.dart # 波プリセット選択器
│   ├── wind_preset_selector.dart # 風プリセット選択器
│   ├── tide_preset_selector.dart # 潮汐プリセット選択器
├── 3_organisms/
│   ├── condition_preset_panel.dart # コンディションプリセットパネル
```

### 3.3 Spot Management フィーチャー
**配置パス**: `lib/features/user/spot_management/`

#### Domain層 (1_domain)
```
1_entities/
├── spot_entity.dart              # スポットエンティティ（id, name, region, notes）

2_repositories/
├── spot_repository.dart          # スポットリポジトリインターフェース

3_usecases/
├── get_spots_usecase.dart        # スポット一覧取得
├── create_spot_usecase.dart      # スポット作成
├── get_favorite_spots_usecase.dart # お気に入りスポット取得
├── search_spots_usecase.dart     # スポット検索
```

#### Application層 (2_application)
```
1_states/
├── spot_state.dart               # スポット状態
├── spot_search_state.dart        # スポット検索状態

2_providers/
├── spot_providers.dart           # スポット関連プロバイダー

3_notifiers/
├── spot_notifier.dart            # スポット状態管理
├── spot_search_notifier.dart     # スポット検索状態管理
```

#### Infrastructure層 (3_infrastructure)
```
1_data_sources/
├── 1_local/
│   ├── spot_local_data_source.dart # スポットローカルデータソース

2_models/
├── spot_model.dart               # スポットデータモデル

3_repositories/
├── spot_repository_impl.dart     # スポットリポジトリ実装
```

#### Presentation層 (4_presentation)
```
2_pages/
├── spot_selection_page.dart      # スポット選択画面

1_widgets/
├── 1_atoms/
│   ├── spot_name_text.dart       # スポット名表示
│   ├── favorite_spot_icon.dart   # お気に入りアイコン
├── 2_molecules/
│   ├── spot_list_item.dart       # スポット一覧アイテム
│   ├── spot_search_bar.dart      # スポット検索バー
├── 3_organisms/
│   ├── spot_selection_view.dart  # スポット選択ビュー
```

### 3.4 Gear Management フィーチャー
**配置パス**: `lib/features/user/gear_management/`

#### Domain層 (1_domain)
```
1_entities/
├── board_entity.dart             # ボードエンティティ（id, name, length, width等）

2_repositories/
├── board_repository.dart         # ボードリポジトリインターフェース

3_usecases/
├── get_boards_usecase.dart       # ボード一覧取得
├── create_board_usecase.dart     # ボード作成
├── update_board_usecase.dart     # ボード更新
├── delete_board_usecase.dart     # ボード削除
```

#### Application層 (2_application)
```
1_states/
├── board_state.dart              # ボード状態
├── board_form_state.dart         # ボードフォーム状態

2_providers/
├── board_providers.dart          # ボード関連プロバイダー

3_notifiers/
├── board_notifier.dart           # ボード状態管理
├── board_form_notifier.dart      # ボードフォーム状態管理
```

#### Infrastructure層 (3_infrastructure)
```
1_data_sources/
├── 1_local/
│   ├── board_local_data_source.dart # ボードローカルデータソース

2_models/
├── board_model.dart              # ボードデータモデル

3_repositories/
├── board_repository_impl.dart    # ボードリポジトリ実装
```

#### Presentation層 (4_presentation)
```
2_pages/
├── board_list_page.dart          # ボード一覧画面
├── board_form_page.dart          # ボード登録・編集画面

1_widgets/
├── 1_atoms/
│   ├── board_spec_text.dart      # ボード仕様テキスト
│   ├── board_thumbnail.dart      # ボードサムネイル
├── 2_molecules/
│   ├── board_list_item.dart      # ボード一覧アイテム
│   ├── board_spec_form.dart      # ボード仕様入力フォーム
├── 3_organisms/
│   ├── board_list_view.dart      # ボード一覧ビュー
│   ├── board_form_view.dart      # ボードフォームビュー
```

### 3.5 Calendar Statistics フィーチャー
**配置パス**: `lib/features/user/calendar_statistics/`

#### Domain層 (1_domain)
```
1_entities/
├── session_statistics_entity.dart # セッション統計エンティティ（月回数、本数合計等）
├── calendar_data_entity.dart     # カレンダーデータエンティティ

2_repositories/
├── statistics_repository.dart    # 統計リポジトリインターフェース

3_usecases/
├── get_monthly_statistics_usecase.dart # 月別統計取得
├── get_calendar_data_usecase.dart # カレンダーデータ取得
```

#### Application層 (2_application)
```
1_states/
├── statistics_state.dart         # 統計状態
├── calendar_state.dart           # カレンダー状態

2_providers/
├── statistics_providers.dart     # 統計関連プロバイダー

3_notifiers/
├── statistics_notifier.dart      # 統計状態管理
├── calendar_notifier.dart        # カレンダー状態管理
```

#### Infrastructure層 (3_infrastructure)
```
1_data_sources/
├── 1_local/
│   ├── statistics_local_data_source.dart # 統計計算データソース

2_models/
├── session_statistics_model.dart # セッション統計モデル
├── calendar_data_model.dart      # カレンダーデータモデル

3_repositories/
├── statistics_repository_impl.dart # 統計リポジトリ実装
```

#### Presentation層 (4_presentation)
```
2_pages/
├── statistics_page.dart          # 統計画面
├── calendar_page.dart            # カレンダー画面（ホーム画面統合も可）

1_widgets/
├── 1_atoms/
│   ├── stat_number_text.dart     # 統計数値表示
│   ├── calendar_day_cell.dart    # カレンダー日セル
├── 2_molecules/
│   ├── monthly_summary_card.dart # 月別サマリーカード
│   ├── best_session_card.dart    # ベストセッションカード
├── 3_organisms/
│   ├── statistics_dashboard.dart # 統計ダッシュボード
│   ├── session_calendar.dart     # セッションカレンダー
```

### 3.6 Settings フィーチャー
**配置パス**: `lib/features/user/settings/`

#### Domain層 (1_domain)
```
1_entities/
├── app_settings_entity.dart      # アプリ設定エンティティ（単位、プライバシー等）

2_repositories/
├── settings_repository.dart      # 設定リポジトリインターフェース

3_usecases/
├── get_settings_usecase.dart     # 設定取得
├── update_settings_usecase.dart  # 設定更新
```

#### Application層 (2_application)
```
1_states/
├── settings_state.dart           # 設定状態

2_providers/
├── settings_providers.dart       # 設定関連プロバイダー

3_notifiers/
├── settings_notifier.dart        # 設定状態管理
```

#### Infrastructure層 (3_infrastructure)
```
1_data_sources/
├── 1_local/
│   ├── settings_local_data_source.dart # 設定ローカルデータソース（SharedPreferences）

2_models/
├── app_settings_model.dart       # アプリ設定モデル

3_repositories/
├── settings_repository_impl.dart # 設定リポジトリ実装
```

#### Presentation層 (4_presentation)
```
2_pages/
├── settings_page.dart            # 設定画面

1_widgets/
├── 1_atoms/
│   ├── setting_switch.dart       # 設定スイッチ
│   ├── setting_dropdown.dart     # 設定ドロップダウン
├── 2_molecules/
│   ├── setting_list_item.dart    # 設定一覧アイテム
│   ├── unit_setting_section.dart # 単位設定セクション
├── 3_organisms/
│   ├── settings_view.dart        # 設定ビュー
```

### 3.7 Shared フィーチャー
**配置パス**: `lib/features/shared/`

#### Database フィーチャー (shared/database)
```
shared/database/
├── 1_domain/
│   ├── 1_entities/
│   │   ├── database_migration_entity.dart # DBマイグレーションエンティティ
│   ├── 2_repositories/
│   │   ├── database_repository.dart    # データベースリポジトリインターフェース
│   └── 3_usecases/
│       ├── initialize_database_usecase.dart # DB初期化ユースケース
├── 2_application/
│   ├── 1_states/
│   │   ├── database_state.dart         # データベース状態
│   ├── 2_providers/
│   │   ├── database_providers.dart     # DB関連プロバイダー
│   └── 3_notifiers/
│       ├── database_notifier.dart      # DB状態管理
├── 3_infrastructure/
│   ├── 1_data_sources/
│   │   └── 1_local/
│   │       ├── database_local_data_source.dart # SQLiteデータベース実装
│   ├── 2_models/
│   │   ├── database_schema.dart        # データベーススキーマ定義
│   └── 3_repositories/
│       ├── database_repository_impl.dart # DB リポジトリ実装
```

#### Routing フィーチャー (shared/routing)
```
shared/routing/
├── 1_domain/
│   ├── 1_entities/
│   │   ├── route_entity.dart           # ルートエンティティ
│   └── 2_repositories/
│       ├── routing_repository.dart     # ルーティングリポジトリインターフェース
├── 2_application/
│   ├── 2_providers/
│   │   ├── routing_providers.dart      # ルーティング関連プロバイダー
├── 3_infrastructure/
│   ├── 2_models/
│   │   ├── app_route_model.dart        # アプリルートモデル
│   └── 3_repositories/
│       ├── routing_repository_impl.dart # ルーティングリポジトリ実装
└── 4_presentation/
    ├── 2_pages/
    │   ├── home_page.dart              # ホーム画面
    │   ├── splash_page.dart            # スプラッシュ画面
    └── 1_widgets/
        ├── 2_molecules/
        │   ├── bottom_navigation_bar.dart # ボトムナビゲーションバー
        └── 3_organisms/
            ├── app_navigation.dart     # アプリナビゲーション
```

## 4. 依存関係マップ

### 4.1 フィーチャー間依存
```
session_management → condition_presets (プリセット選択)
session_management → spot_management (スポット選択)
session_management → gear_management (ボード選択)
calendar_statistics → session_management (セッションデータ参照)
shared/database ← all features (全フィーチャーがDB依存)
shared/routing ← all features (全フィーチャーが画面遷移依存)
```

### 4.2 レイヤー間依存（クリーンアーキテクチャ）
```
Presentation → Application → Domain
Infrastructure → Domain
Application → Domain
```

## 5. 実装優先度

### Phase 1（最優先）
1. **shared/database**: 全フィーチャーの基盤
2. **condition_presets**: セッション記録に必須
3. **session_management**: アプリの中核機能

### Phase 2（中優先）
4. **spot_management**: セッション記録の利便性向上
5. **gear_management**: セッション記録の完全性

### Phase 3（低優先）
6. **calendar_statistics**: 分析機能
7. **settings**: カスタマイズ機能
8. **shared/routing**: 最終的な画面遷移統合

## 6. 次段階への移行条件

- [ ] 全フィーチャーのファイル構成が決定済み
- [ ] 各ファイルの役割が明確化済み
- [ ] クリーンアーキテクチャ準拠確認済み
- [ ] 技術スタック整合性確認済み
- [ ] ユーザー合意取得済み

---

**注意事項**: 
- この構造計画書に記載されていないファイルの作成は第三段階で禁止されます
- 計画変更が必要な場合は第二段階に戻って修正します
- すべてのパスはAI/instructions/features_template.mdの構造に準拠しています