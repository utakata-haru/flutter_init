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
│   └── 3_usecases/           # ユースケース（ビジネスロジック）
├── 2_infrastructure/
│   ├── 1_models/           # データモデル
│   ├── 2_data_sources/
│   │   ├── 1_local/        # ローカルデータソース
│   │   └── 2_remote/       # リモートデータソース
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

**Local Data Source (SQLite)**
```dart
// data_sources/local/user_local_data_source.dart
abstract class UserLocalDataSource {
  Future<UserModel?> getUser(String id);
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser(String id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Database _database;
  
  UserLocalDataSourceImpl(this._database);
  
  @override
  Future<UserModel?> getUser(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }
  
  @override
  Future<void> saveUser(UserModel user) async {
    await _database.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  @override
  Future<void> deleteUser(String id) async {
    await _database.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
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
import 'package:flutter_hooks/flutter_hooks.dart';
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

### クラス命名
- **PascalCase**を使用
- 例：`UserProfilePage`, `GetUserUseCase`

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
  sqflite: 
  path: 

dev_dependencies:
  build_runner: 
  freezed: 
  json_serializable: 
  riverpod_generator: 
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

1. **単一責任の原則**: 各クラスは一つの責任のみを持つ
2. **依存性の逆転**: 上位層は下位層に依存しない
3. **コードレビュー**: プルリクエストでの品質管理
4. **ドキュメント**: 複雑なロジックには適切なコメント

## 参考資料

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Riverpod](https://riverpod.dev/)
- [Atomic Design](https://atomicdesign.bradfrost.com/)