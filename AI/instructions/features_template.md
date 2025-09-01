# Flutter Feature Development Template

## 概要

このドキュメントは、flutterプロジェクトにおけるフィーチャー開発のテンプレートとガイドラインを提供します。
`generate_feature.sh`と`generate_feature.ps1`スクリプトを使用してクリーンアーキテクチャに基づいた機能を効率的に開発できます。

## アーキテクチャ概要

### クリーンアーキテクチャの4層構造

```
lib/features/{permission_level}/{feature_name}/
├── 1_domain/           # ドメイン層（ビジネスロジック）
├── 2_infrastructure/   # インフラストラクチャ層（データアクセス）
├── 3_application/      # アプリケーション層（状態管理）
└── 4_presentation/     # プレゼンテーション層（UI）
```

### 権限レベル

- **admin**: 管理者専用機能
- **user**: 一般ユーザー機能
- **shared**: 共通機能（認証、共通UIコンポーネントなど）


### 3. 生成されるディレクトリ構造

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

### 共通例外ディレクトリ

```
lib/core/
└── exceptions/               # 共通例外（全フィーチャーで使用）
    ├── base_exception.dart   # 基底例外クラス
    ├── network_exception.dart # ネットワーク関連例外
    └── storage_exception.dart # ストレージ関連例外
```

## 例外処理アーキテクチャ

### 例外の階層構造

#### 1. 共通例外（lib/core/exceptions/）

**基底例外クラス**
```dart
// core/exceptions/base_exception.dart
abstract class BaseException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  
  const BaseException(this.message, {this.code, this.originalError});
  
  @override
  String toString() => 'BaseException: $message';
}
```

**ネットワーク例外**
```dart
// core/exceptions/network_exception.dart
class NetworkException extends BaseException {
  const NetworkException(super.message, {super.code, super.originalError});
  
  factory NetworkException.connectionTimeout() => 
    const NetworkException('接続がタイムアウトしました', code: 'CONNECTION_TIMEOUT');
  
  factory NetworkException.noInternet() => 
    const NetworkException('インターネット接続がありません', code: 'NO_INTERNET');
}
```

**ストレージ例外**
```dart
// core/exceptions/storage_exception.dart
class StorageException extends BaseException {
  const StorageException(super.message, {super.code, super.originalError});
  
  factory StorageException.databaseError(String details) => 
    StorageException('データベースエラー: $details', code: 'DATABASE_ERROR');
  
  factory StorageException.fileNotFound(String path) => 
    StorageException('ファイルが見つかりません: $path', code: 'FILE_NOT_FOUND');
}
```

#### 2. ドメイン例外（各フィーチャーの1_domain/exceptions/）

```dart
// features/user/1_domain/exceptions/user_domain_exception.dart
class UserNotFoundException extends BaseException {
  const UserNotFoundException(String userId) 
    : super('ユーザーが見つかりません: $userId', code: 'USER_NOT_FOUND');
}

class InvalidUserDataException extends BaseException {
  const InvalidUserDataException(String reason) 
    : super('無効なユーザーデータ: $reason', code: 'INVALID_USER_DATA');
}

class UserAlreadyExistsException extends BaseException {
  const UserAlreadyExistsException(String email) 
    : super('ユーザーは既に存在します: $email', code: 'USER_ALREADY_EXISTS');
}
```

#### 3. データソース例外

**Drift例外**
```dart
// features/user/2_infrastructure/2_data_sources/1_local/exceptions/drift_exception.dart
class DriftDatabaseException extends StorageException {
  const DriftDatabaseException(super.message, {super.code, super.originalError});
  
  factory DriftDatabaseException.insertFailed(String table) => 
    DriftDatabaseException('データの挿入に失敗しました: $table', code: 'INSERT_FAILED');
  
  factory DriftDatabaseException.queryFailed(String query) => 
    DriftDatabaseException('クエリの実行に失敗しました: $query', code: 'QUERY_FAILED');
}
```

**API例外**
```dart
// features/user/2_infrastructure/2_data_sources/2_remote/exceptions/api_exception.dart
class ApiException extends NetworkException {
  final int? statusCode;
  
  const ApiException(super.message, {this.statusCode, super.code, super.originalError});
  
  factory ApiException.unauthorized() => 
    const ApiException('認証が必要です', statusCode: 401, code: 'UNAUTHORIZED');
  
  factory ApiException.forbidden() => 
    const ApiException('アクセスが拒否されました', statusCode: 403, code: 'FORBIDDEN');
  
  factory ApiException.notFound() => 
    const ApiException('リソースが見つかりません', statusCode: 404, code: 'NOT_FOUND');
}
```

### エラーハンドリングパターン

#### Repository層での例外変換
```dart
// features/user/2_infrastructure/3_repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity> getUser(String id) async {
    try {
      // ローカルデータソースから取得を試行
      final localUser = await _localDataSource.getUser(id);
      if (localUser != null) return localUser.toEntity();
      
      // リモートデータソースから取得
      final remoteUser = await _remoteDataSource.getUser(id);
      await _localDataSource.saveUser(remoteUser);
      return remoteUser.toEntity();
    } on DriftDatabaseException catch (e) {
      // インフラ例外をドメイン例外に変換
      throw StorageException('ローカルストレージエラー: ${e.message}', originalError: e);
    } on ApiException catch (e) {
      if (e.statusCode == 404) {
        throw UserNotFoundException(id);
      }
      throw NetworkException('リモート取得エラー: ${e.message}', originalError: e);
    } catch (e) {
      throw UserNotFoundException(id);
    }
  }
}
```

#### UseCase層での例外処理
```dart
// features/user/1_domain/3_usecases/get_user_usecase.dart
class GetUserUseCase {
  Future<UserEntity> call(String id) async {
    try {
      return await _repository.getUser(id);
    } on UserNotFoundException {
      rethrow; // ドメイン例外はそのまま上位に伝播
    } on StorageException catch (e) {
      // インフラ例外をドメイン例外に変換
      throw UserNotFoundException(id);
    }
  }
}
```

#### Presentation層での例外処理
```dart
// features/user/3_application/3_notifiers/user_notifier.dart
class UserNotifier extends _$UserNotifier {
  Future<void> getUser(String id) async {
    state = const UserState.loading();
    try {
      final user = await ref.read(getUserUseCaseProvider)(id);
      state = UserState.loaded(user);
    } on UserNotFoundException {
      state = const UserState.error('ユーザーが見つかりません');
    } on NetworkException {
      state = const UserState.error('ネットワークエラーが発生しました');
    } on StorageException {
      state = const UserState.error('データの保存に失敗しました');
    } catch (e) {
      state = const UserState.error('予期しないエラーが発生しました');
    }
  }
}
```

## 開発ガイドライン

### 1. Domain Layer（ドメイン層）

#### Entities
```dart
// entities/user_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String name,
    required String email,
  }) = _UserEntity;

  // JSONシリアライズ/デシリアライズ（必要に応じて使用してください）
  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
```

#### Repositories
```dart
// repositories/user_repository.dart
abstract class UserRepository {
  Future<UserEntity> getUser(String id);
  Future<void> updateUser(UserEntity user);
}
```

#### Use Cases
```dart
// usecases/get_user_usecase.dart
class GetUserUseCase {
  final UserRepository _repository;
  
  GetUserUseCase(this._repository);
  
  Future<UserEntity> call(String id) {
    return _repository.getUser(id);
  }
}
```

### 2. Application Layer（アプリケーション層）

#### States
```dart
// states/user_state.dart
@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserEntity user) = _Loaded;
  const factory UserState.error(String message) = _Error;
}
```

#### Notifiers
```dart
// notifiers/user_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier.g.dart';

// Notifier の責務
// - 状態の生成・更新・副作用などのビジネスロジックを集約
// - Provider からは依存を注入するのみで、実装詳細はここに隠蔽
// - Riverpod のアノテーション（@riverpod）により型安全な Notifier/AsyncNotifier を提供
 @riverpod
 class UserNotifier extends _$UserNotifier {
   // 初期状態を返す（UserState は states で定義）
   @override
   UserState build() => const UserState.initial();

  Future<void> getUser(String id) async {
    state = const UserState.loading();
    try {
      // UseCase は Provider から取得（依存注入）
      final getUserUseCase = ref.read(getUserUseCaseProvider);
      final user = await getUserUseCase(id);
      state = UserState.loaded(user);
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }
}
```

#### Providers

Provider と Notifier の責務は以下の通りです（重要）。

- Provider: 依存注入と購読のエントリポイントのみを提供（抽象の公開）。内部ロジックは書かない。
- Notifier: 状態の生成・更新・副作用などのビジネスロジックを集約。Provider から実装詳細を隠蔽。
- Notifier は Riverpod のアノテーション（例: @riverpod）で定義し、コード生成により型安全な Notifier/AsyncNotifier を提供。

```dart
// providers/user_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 実際のパス構成に合わせて import を調整してください（例）
// import 'features/user/domain/repositories/user_repository.dart';
// import 'features/user/domain/usecases/get_user_usecase.dart';
// import 'features/user/infrastructure/repositories/user_repository_impl.dart';
// import 'features/user/infrastructure/datasources/user_remote_data_source.dart';
// import 'features/user/infrastructure/datasources/user_local_data_source.dart';

part 'user_providers.g.dart';

/// Provider と Notifier の責務分離（要点）
/// - Provider: 依存注入と公開のみ（インスタンスの組み立て）。ロジックは書かない。
/// - Notifier: 状態の生成・更新・副作用などのビジネスロジックを担う。

// Repository の抽象を公開（実装詳細は隠蔽）
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  // DI 配線のみ。ロジックはここに書かない
  // 例: インフラ層で定義した DataSource Provider を watch して組み立てる
  final remote = ref.watch(userRemoteDataSourceProvider);
  final local = ref.watch(userLocalDataSourceProvider);
  return UserRepositoryImpl(remote, local);
}

// UseCase の抽象を公開（Repository を依存注入）
@riverpod
GetUserUseCase getUserUseCase(GetUserUseCaseRef ref) {
  final repo = ref.watch(userRepositoryProvider);
  return GetUserUseCase(repo);
}

// Notifier はクラス側の @riverpod により `userNotifierProvider` が自動生成されます。
// 例）ウィジェット内での利用（購読のみ、ロジックは Notifier 側にある）
// final userState = ref.watch(userNotifierProvider);
```

### 3. Infrastructure Layer（インフラストラクチャ層）

#### Models
```dart
// models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
  
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
    );
  }
}
```

#### Data Sources

**Remote Data Source**
```dart
// data_sources/remote/user_remote_data_source.dart
abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;
  
  UserRemoteDataSourceImpl(this._dio);
  
  @override
  Future<UserModel> getUser(String id) async {
    final response = await _dio.get('/users/$id');
    return UserModel.fromJson(response.data);
  }
}
```

**Local Data Source (Drift)**
```dart
// data_sources/local/user_local_data_source.dart
import 'package:drift/drift.dart';

// Driftテーブル定義
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  
  @override
  Set<Column> get primaryKey => {id};
}

// Driftデータベース定義
@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
}

abstract class UserLocalDataSource {
  Future<UserModel?> getUser(String id);
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser(String id);
  Stream<List<UserModel>> watchAllUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final AppDatabase _database;
  
  UserLocalDataSourceImpl(this._database);
  
  @override
  Future<UserModel?> getUser(String id) async {
    final user = await (_database.select(_database.users)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    
    if (user != null) {
      return UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
      );
    }
    return null;
  }
  
  @override
  Future<void> saveUser(UserModel user) async {
    await _database.into(_database.users).insertOnConflictUpdate(
      UsersCompanion(
        id: Value(user.id),
        name: Value(user.name),
        email: Value(user.email),
      ),
    );
  }
  
  @override
  Future<void> deleteUser(String id) async {
    await (_database.delete(_database.users)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
  
  @override
  Stream<List<UserModel>> watchAllUsers() {
    return _database.select(_database.users).watch().map(
      (rows) => rows.map((row) => UserModel(
        id: row.id,
        name: row.name,
        email: row.email,
      )).toList(),
    );
  }
}

// データベース接続の設定
QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.db'));
    return NativeDatabase.createInBackground(file);
  });
}
```

#### Repository Implementation
```dart
// repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  
  UserRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );
  
  @override
  Future<UserEntity> getUser(String id) async {
    try {
      // まずローカルデータベースから取得を試行
      final localUser = await _localDataSource.getUser(id);
      if (localUser != null) {
        return localUser.toEntity();
      }
      
      // ローカルにない場合はリモートから取得
      final remoteUser = await _remoteDataSource.getUser(id);
      
      // ローカルデータベースに保存
      await _localDataSource.saveUser(remoteUser);
      
      return remoteUser.toEntity();
    } catch (e) {
      // リモート取得に失敗した場合はローカルデータを返す
      final localUser = await _localDataSource.getUser(id);
      if (localUser != null) {
        return localUser.toEntity();
      }
      rethrow;
    }
  }
  
  @override
  Future<void> updateUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    
    // ローカルデータベースを更新
    await _localDataSource.saveUser(userModel);
    
    try {
      // リモートサーバーにも送信
      await _remoteDataSource.updateUser(userModel);
    } catch (e) {
      // リモート更新に失敗してもローカルは更新済み
      // 後でリトライ機能を実装可能
    }
  }
}
```

### 4. Presentation Layer（プレゼンテーション層）

#### Pages
```dart
// pages/user_profile_page.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfilePage extends HookConsumerWidget {
  final String userId;
  
  const UserProfilePage({super.key, required this.userId});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 例: Hookを使って初回マウント時に取得
    useEffect(() {
      Future.microtask(() => ref.read(userNotifierProvider.notifier).getUser(userId));
      return null; // dispose不要
    }, const []);

    final userState = ref.watch(userNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: userState.when(
        initial: () => const Center(child: Text('Initial')),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (user) => UserProfileWidget(user: user),
        error: (message) => Center(child: Text('Error: $message')),
      ),
    );
  }
}
```

#### Widgets

**Atoms（原子コンポーネント）**
```dart
// widgets/atoms/user_avatar.dart
class UserAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  
  const UserAvatar({
    Key? key,
    required this.imageUrl,
    this.size = 50,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
```

**Molecules（分子コンポーネント）**
```dart
// widgets/molecules/user_info_card.dart
class UserInfoCard extends StatelessWidget {
  final UserEntity user;
  
  const UserInfoCard({Key? key, required this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            UserAvatar(imageUrl: user.avatarUrl),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: Theme.of(context).textTheme.titleMedium),
                Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 命名規則

### ファイル命名
- **snake_case**を使用
- 例：`user_profile_page.dart`, `get_user_usecase.dart`
- **例外ファイル**: `{対象名}_exception.dart`
- 例：`user_domain_exception.dart`, `drift_exception.dart`

### クラス命名
- **PascalCase**を使用
- 例：`UserProfilePage`, `GetUserUseCase`
- **例外クラス**: `{対象名}Exception`
- 例：`UserNotFoundException`, `NetworkException`

### 変数・関数命名
- **camelCase**を使用
- 例：`userName`, `getUserData()`

## 依存関係の管理

### Core Dependencies
```yaml
dependencies:
  flutter_riverpod: 
  riverpod_annotation: 
  freezed_annotation:
  json_annotation:
  dio:
  go_router: 
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  path: 

dev_dependencies:
  build_runner: 
  freezed: 
  json_serializable: 
  riverpod_generator: 
  drift_dev: ^2.14.0
```

### Provider Registration
```dart
// core/providers/app_providers.dart
final appProviders = [
  // Repository providers
  userRepositoryProvider,
  
  // Use case providers
  getUserUseCaseProvider,
  
  // Notifier providers
  userNotifierProvider,
];
```
## ベストプラクティス

### 単一責任の原則
- 各クラスは一つの責任のみを持つ
- 機能の変更理由は一つに限定

### 依存性の逆転
- 上位層は下位層の抽象に依存
- 具象クラスではなくインターフェースに依存

### テスタビリティ
- 依存性注入によるモックテストの実現
- 各層の独立したテストが可能

### 状態管理
- Riverpodによる宣言的な状態管理
- 状態の変更は予測可能で追跡可能

### 例外処理のベストプラクティス

#### 1. 例外の階層設計
- 共通の基底例外クラス（`BaseException`）を継承
- 層ごとに適切な例外クラスを定義
- 具体的で意味のある例外名を使用

#### 2. エラーメッセージの統一
- ユーザー向けメッセージと開発者向けメッセージを分離
- 国際化（i18n）に対応した構造
- ログ出力用の詳細情報を含める

#### 3. 例外の変換と伝播
- 下位層の例外を上位層で適切に変換
- 必要な情報を保持しながら抽象化
- スタックトレースの保持

#### 4. リソース管理
- try-finally文やusing文の活用
- データベース接続やファイルハンドルの確実なクローズ
- メモリリークの防止

#### 5. ログ記録
- 例外発生時の適切なログレベル設定
- 機密情報の除外
- デバッグに必要な情報の記録

### コードレビュー
- プルリクエストでの品質管理
- アーキテクチャ原則の遵守確認

### ドキュメント
- 複雑なロジックには適切なコメント
- API仕様書の維持

## 参考資料

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Riverpod](https://riverpod.dev/)
- [Atomic Design](https://atomicdesign.bradfrost.com/)
