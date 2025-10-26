# 構造計画書: AI Travel Persona Map

## メタ情報
- プロジェクト名: AI Travel Persona Map
- バージョン: v1.0.0
- 最終更新日: 2025-10-26
- 作成者: AI Assistant

## 構造ポリシー（重要制約）
- クリーンアーキテクチャの構造に厳密準拠: `AI/architecture/lib/features/features_architecture.md`
- 新しいフォルダの作成禁止（既存定義内でのファイル配置のみ）
- 命名規則の遵守（例: `snake_case`、責務ごとのフォルダ分割）

## 目的と範囲
- 対象アプリケーション: AI Travel Persona Map
- 対象レイヤー: Domain / Infrastructure / Application / Presentation / Core
- 主要フィーチャー: Map, Spot, Persona, Share, Onboarding, Settings

## 依存・技術参照
- 技術選定: `AI/architecture/technology_stack.md`
- 主要ライブラリ: Riverpod, GoRouter, Freezed, Drift, Google Maps, Generative AI

---

## フィーチャー分析

### 権限レベルの決定
このアプリはログイン機能がなく、全てのユーザーが同じ機能を使用するため、`user`レベルに全機能を配置します。

### 識別されたフィーチャー

1. **map** (地図/ホーム画面)
   - スポット一覧表示
   - 地図上のピン表示・操作
   - 現在位置表示
   - ピン検索・フィルタ

2. **spot** (スポット管理)
   - スポット詳細表示
   - スポット編集・削除
   - 写真ギャラリー表示・管理
   - レビュー表示・編集

3. **post** (投稿作成)
   - 新規スポット作成
   - 位置指定
   - 写真追加・管理
   - AIレビュー生成
   - ドラフト保存

4. **persona** (ペルソナ管理)
   - ペルソナ一覧表示
   - ペルソナ作成・編集・削除
   - テキストファイル取り込み
   - デフォルトペルソナ設定

5. **share** (共有機能)
   - 共有リンク生成
   - トークン管理
   - ゲストビューア
   - SNSシェア

6. **onboarding** (初回起動)
   - スプラッシュ画面
   - 権限リクエスト
   - APIキー設定
   - デフォルトペルソナ作成
   - チュートリアル

7. **settings** (設定)
   - アプリ設定管理
   - APIキー設定
   - 言語設定
   - キャッシュクリア

---

## ディレクトリ構造（予定）

```
lib/
├── core/
│   ├── routing/
│   │   └── path/
│   ├── theme/
│   ├── api/
│   ├── exceptions/
│   ├── database/
│   │   └── table/
│   └── utils/
├── features/
│   └── user/
│       ├── map/
│       │   ├── 1_domain/
│       │   │   ├── 1_entities/
│       │   │   ├── 2_repositories/
│       │   │   ├── 3_usecases/
│       │   │   └── exceptions/
│       │   ├── 2_infrastructure/
│       │   │   ├── 1_models/
│       │   │   ├── 2_data_sources/
│       │   │   │   ├── 1_local/
│       │   │   │   │   └── exceptions/
│       │   │   │   └── 2_remote/
│       │   │   │       └── exceptions/
│       │   │   └── 3_repositories/
│       │   ├── 3_application/
│       │   │   ├── 1_states/
│       │   │   ├── 2_providers/
│       │   │   └── 3_notifiers/
│       │   └── 4_presentation/
│       │       ├── 1_widgets/
│       │       │   ├── 1_atoms/
│       │       │   ├── 2_molecules/
│       │       │   └── 3_organisms/
│       │       └── 2_pages/
│       ├── spot/
│       │   └── (同じ4層構造)
│       ├── post/
│       │   └── (同じ4層構造)
│       ├── persona/
│       │   └── (同じ4層構造)
│       ├── share/
│       │   └── (同じ4層構造)
│       ├── onboarding/
│       │   └── (同じ4層構造)
│       └── settings/
│           └── (同じ4層構造)
└── main.dart
```

---

## Core層ファイル定義

### routing/
- `app_router.dart` - GoRouterの設定
- `router_observer.dart` - ナビゲーション監視

### routing/path/
- `app_paths.dart` - パス定数定義
- `route_names.dart` - ルート名定義

### theme/
- `app_theme.dart` - テーマ設定
- `colors.dart` - カラーパレット
- `typography.dart` - タイポグラフィ
- `spacing.dart` - スペーシング

### api/
- `maps_client.dart` - Google Maps API クライアント
- `ai_client.dart` - Generative AI API クライアント
- `api_config.dart` - API設定管理

### exceptions/
- `base_exception.dart` - 基底例外
- `network_exception.dart` - ネットワーク例外
- `storage_exception.dart` - ストレージ例外
- `api_exception.dart` - API例外
- `database_exception.dart` - データベース例外

### database/
- `app_database.dart` - Drift データベース設定

### database/table/
- `spots_table.dart` - スポットテーブル
- `personas_table.dart` - ペルソナテーブル
- `photos_table.dart` - 写真テーブル
- `app_settings_table.dart` - アプリ設定テーブル

### utils/
- `validators.dart` - バリデーション関数
- `formatters.dart` - フォーマット関数
- `constants.dart` - アプリ全体の定数
- `logger.dart` - ログ記録ユーティリティ

---

## Feature層ファイル定義（例: map フィーチャー）

### map/1_domain/1_entities/
- `spot_entity.dart` - スポットエンティティ（Freezed）
- `location_entity.dart` - 位置情報エンティティ

### map/1_domain/2_repositories/
- `spot_repository.dart` - スポットリポジトリインターフェース
- `location_repository.dart` - 位置情報リポジトリインターフェース

### map/1_domain/3_usecases/
- `get_all_spots_usecase.dart` - 全スポット取得
- `get_spots_by_area_usecase.dart` - エリア内スポット取得
- `get_current_location_usecase.dart` - 現在位置取得

### map/1_domain/exceptions/
- `location_exception.dart` - 位置情報取得例外

### map/2_infrastructure/1_models/
- `spot_model.dart` - スポットモデル（Drift用）
- `location_model.dart` - 位置情報モデル

### map/2_infrastructure/2_data_sources/1_local/
- `spot_local_data_source.dart` - スポットローカルデータソース（Drift）

### map/2_infrastructure/2_data_sources/2_remote/
- `maps_remote_data_source.dart` - Google Maps データソース
- `location_remote_data_source.dart` - 位置情報データソース

### map/2_infrastructure/3_repositories/
- `spot_repository_impl.dart` - スポットリポジトリ実装
- `location_repository_impl.dart` - 位置情報リポジトリ実装

### map/3_application/1_states/
- `map_state.dart` - 地図画面の状態（Freezed）
- `spot_list_state.dart` - スポット一覧の状態

### map/3_application/2_providers/
- `spot_repository_provider.dart` - スポットリポジトリプロバイダー
- `location_repository_provider.dart` - 位置情報リポジトリプロバイダー

### map/3_application/3_notifiers/
- `map_notifier.dart` - 地図画面状態管理（@riverpod）
- `spot_list_notifier.dart` - スポット一覧状態管理

### map/4_presentation/2_pages/
- `map_page.dart` - 地図画面（ホーム）

### map/4_presentation/1_widgets/1_atoms/
- `map_pin_icon.dart` - マップピンアイコン
- `location_button.dart` - 現在位置ボタン

### map/4_presentation/1_widgets/2_molecules/
- `spot_marker.dart` - スポットマーカー
- `map_controls.dart` - 地図コントロール

### map/4_presentation/1_widgets/3_organisms/
- `google_map_view.dart` - Google Maps表示
- `spot_list_overlay.dart` - スポット一覧オーバーレイ

---

## 他フィーチャーのファイル定義（概要）

### spot (スポット管理)
- Domain: SpotEntity, PhotoEntity, ReviewEntity
- UseCase: GetSpotDetail, UpdateSpot, DeleteSpot, AddPhoto, GenerateReview
- Infrastructure: SpotLocalDataSource, AIRemoteDataSource
- Presentation: SpotDetailPage, PhotoGallery, ReviewEditor

### post (投稿作成)
- Domain: DraftEntity, PostEntity
- UseCase: CreateDraft, SaveDraft, PublishPost, GenerateAIReview
- Infrastructure: DraftLocalDataSource, AIRemoteDataSource, ImageLocalDataSource
- Presentation: PostCreatePage, PhotoPicker, LocationPicker, ReviewGenerator

### persona (ペルソナ管理)
- Domain: PersonaEntity
- UseCase: GetAllPersonas, CreatePersona, UpdatePersona, DeletePersona, SetDefaultPersona
- Infrastructure: PersonaLocalDataSource, FileDataSource
- Presentation: PersonaListPage, PersonaFormPage, PersonaDetailPage

### share (共有機能)
- Domain: ShareLinkEntity, ShareTokenEntity
- UseCase: GenerateShareLink, ValidateToken, RevokeShareLink
- Infrastructure: ShareTokenLocalDataSource
- Presentation: ShareLinkGenerator, GuestViewer, ShareSheet

### onboarding (初回起動)
- Domain: OnboardingStepEntity, PermissionEntity
- UseCase: CheckOnboardingStatus, RequestPermission, CompleteOnboarding
- Infrastructure: OnboardingLocalDataSource, PermissionDataSource
- Presentation: SplashPage, PermissionPage, TutorialPage

### settings (設定)
- Domain: AppSettingsEntity, APIKeyEntity
- UseCase: GetSettings, UpdateSettings, ValidateAPIKey, ClearCache
- Infrastructure: SettingsLocalDataSource, CacheDataSource
- Presentation: SettingsPage, APIKeyConfigPage, LanguageSelectPage

---

## ルーティング計画

### パス設計（core/routing/path/app_paths.dart）

```dart
class AppPaths {
  // Onboarding
  static const splash = '/';
  static const permission = '/permission';
  static const apiKeySetup = '/api-key-setup';
  static const tutorial = '/tutorial';

  // Main
  static const home = '/home';

  // Spot
  static const spotDetail = '/spot/:id';
  static const spotEdit = '/spot/:id/edit';

  // Post
  static const postCreate = '/post/create';
  static const postDraft = '/post/draft/:id';

  // Persona
  static const personaList = '/persona';
  static const personaCreate = '/persona/create';
  static const personaEdit = '/persona/:id/edit';
  static const personaDetail = '/persona/:id';

  // Share
  static const guestView = '/share/:token';

  // Settings
  static const settings = '/settings';
  static const apiKeySettings = '/settings/api-key';
  static const languageSettings = '/settings/language';
}
```

### 画面ページ対応

| パス | ページファイル | フィーチャー |
|------|--------------|------------|
| / | onboarding/4_presentation/2_pages/splash_page.dart | onboarding |
| /permission | onboarding/4_presentation/2_pages/permission_page.dart | onboarding |
| /home | map/4_presentation/2_pages/map_page.dart | map |
| /spot/:id | spot/4_presentation/2_pages/spot_detail_page.dart | spot |
| /post/create | post/4_presentation/2_pages/post_create_page.dart | post |
| /persona | persona/4_presentation/2_pages/persona_list_page.dart | persona |
| /share/:token | share/4_presentation/2_pages/guest_view_page.dart | share |
| /settings | settings/4_presentation/2_pages/settings_page.dart | settings |

---

## 状態管理計画（Riverpod）

### Provider（依存性注入）
各フィーチャーの `3_application/2_providers/` に配置

例:
```dart
// map/3_application/2_providers/spot_repository_provider.dart
@riverpod
SpotRepository spotRepository(SpotRepositoryRef ref) {
  final database = ref.watch(appDatabaseProvider);
  return SpotRepositoryImpl(
    localDataSource: SpotLocalDataSource(database),
  );
}
```

### Notifier（状態・副作用管理）
各フィーチャーの `3_application/3_notifiers/` に配置

例:
```dart
// map/3_application/3_notifiers/map_notifier.dart
@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  MapState build() {
    return const MapState.initial();
  }

  Future<void> loadSpots() async {
    // ...
  }
}
```

### UIからのアクセス
生成された Provider 経由のみ
```dart
// UI層
final mapState = ref.watch(mapNotifierProvider);
ref.read(mapNotifierProvider.notifier).loadSpots();
```

---

## データソース計画

### Local（Drift）
- SpotLocalDataSource - スポットCRUD
- PersonaLocalDataSource - ペルソナCRUD
- PhotoLocalDataSource - 写真メタデータCRUD
- DraftLocalDataSource - ドラフトCRUD
- SettingsLocalDataSource - 設定CRUD
- ShareTokenLocalDataSource - 共有トークンCRUD

### Remote（API）
- MapsRemoteDataSource - Google Maps API
- AIRemoteDataSource - Generative AI API
- LocationRemoteDataSource - 位置情報サービス

### File System
- ImageFileDataSource - 写真ファイル操作
- PersonaFileDataSource - テキストファイル取り込み

---

## モデル・リポジトリ計画

### Models（2_infrastructure/1_models/）
Drift用のデータモデル、JSON変換対応

### Repositories（2_infrastructure/3_repositories/）
Domain層のインターフェースを実装し、複数のデータソースを統合

例:
```dart
class SpotRepositoryImpl implements SpotRepository {
  final SpotLocalDataSource _localDataSource;
  final MapsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Spot>>> getAllSpots() async {
    // 実装
  }
}
```

---

## コード生成・ビルド

### 使用するジェネレーター
- `riverpod_generator` - Riverpod Provider/Notifier生成
- `freezed` - イミュータブルクラス生成
- `json_serializable` - JSON変換コード生成
- `drift_dev` - Drift DAOクラス生成

### ビルドコマンド
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 生成ファイルパターン
- `*.g.dart` - Riverpod, JSON Serializable
- `*.freezed.dart` - Freezed
- `*.drift.dart` - Drift

---

## 実装順序（構造計画ベース）

### フェーズ1: Core層とDatabase
1. Core構造生成
2. 例外クラス実装
3. Driftテーブル定義
4. Database設定

### フェーズ2: Domain層（全フィーチャー）
1. Entities定義（Freezed）
2. Repository インターフェース定義
3. UseCases定義

### フェーズ3: Infrastructure層（全フィーチャー）
1. Models定義（Drift用）
2. DataSources実装（Local/Remote）
3. Repositories実装

### フェーズ4: Application層（全フィーチャー）
1. States定義（Freezed）
2. Providers定義（@riverpod）
3. Notifiers実装（@riverpod）

### フェーズ5: Presentation層（全フィーチャー）
1. Atoms（基本ウィジェット）
2. Molecules（複合ウィジェット）
3. Organisms（複雑なウィジェット）
4. Pages（画面）

### フェーズ6: Routing & Integration
1. GoRouter設定
2. パス定義
3. 画面遷移実装

### フェーズ7: テスト & ビルド
1. ユニットテスト
2. ウィジェットテスト
3. 統合テスト
4. ビルド確認

---

## 検証・合意

### レビュー観点
- ✅ 網羅性: 全ての仕様要件がフィーチャーに含まれているか
- ✅ 分割の妥当性: フィーチャー分割が適切か
- ✅ 役割の過不足: 各層の責務が明確か
- ✅ 解像度: ファイル定義が実装に十分な詳細度か

### 確認事項
- クリーンアーキテクチャの4層構造に準拠
- 既存のディレクトリ構造定義に厳密準拠
- 命名規則（snake_case）の遵守
- 依存関係の方向性（Domain ← Infrastructure ← Application ← Presentation）

### 合意文言
「AI Travel Persona Mapの構造計画書（v1.0）について、フィーチャー分割、ファイル配置、実装順序に合意し、第三段階（実装フェーズ）への移行を了承します。」

---

## 更新履歴

| 日時 | バージョン | 内容 |
|------|-----------|------|
| 2025-10-26 | v1.0.0 | 初版作成・構造計画完成 |

---

## 参考・関連

### プロセス詳細（第二段階）
- `AI/instructions/002/project_rules_stage2_step1.md`
- `AI/instructions/002/project_rules_stage2_step2.md`
- `AI/instructions/002/project_rules_stage2_step3.md`
- `AI/instructions/002/project_rules_stage2_step4.md`

### 上位方針
- `AI/instructions/project_rules.md`

### アーキテクチャ規約
- `AI/architecture/lib/features/features_architecture.md`
- `AI/architecture/lib/core/core_architecture.md`
- `AI/architecture/technology_stack.md`

### 仕様書
- `AI/document/application_specification.md`
