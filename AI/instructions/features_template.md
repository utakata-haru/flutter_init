# Flutter Feature Development Template

## 概要

このドキュメントは、flutterプロジェクトにおけるフィーチャー開発のテンプレートとガイドラインを提供します。
`generate_feature.sh`スクリプトを使用してクリーンアーキテクチャに基づいた機能を効率的に開発できます。

## アーキテクチャ概要

### クリーンアーキテクチャの4層構造

```
lib/features/{permission_level}/{feature_name}/
├── 1_domain/           # ドメイン層（ビジネスロジック）
├── 2_application/      # アプリケーション層（状態管理）
├── 3_infrastructure/   # インフラストラクチャ層（データアクセス）
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
├── 2_application/
│   ├── 1_states/             # 状態クラス
│   ├── 2_providers/          # プロバイダー定義
│   └── 3_notifiers/          # 状態管理（Riverpod Notifier）
├── 3_infrastructure/
│   ├── 1_data_sources/
│   │   ├── local/        # ローカルデータソース
│   │   └── remote/       # リモートデータソース
│   ├── 2_models/           # データモデル
│   └── 3_repositories/     # リポジトリ実装
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
class UserEntity {
  final String id;
  final String name;
  final String email;
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
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
class UserNotifier extends StateNotifier<UserState> {
  final GetUserUseCase _getUserUseCase;
  
  UserNotifier(this._getUserUseCase) : super(const UserState.initial());
  
  Future<void> getUser(String id) async {
    state = const UserState.loading();
    try {
      final user = await _getUserUseCase(id);
      state = UserState.loaded(user);
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }
}
```

#### Providers
```dart
// providers/user_providers.dart
final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(ref.read(getUserUseCaseProvider)),
);
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
class UserProfilePage extends ConsumerWidget {
  final String userId;
  
  const UserProfilePage({Key? key, required this.userId}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  freezed_annotation:
  dio:
  go_router: 
  sqflite: 
  path: 

dev_dependencies:
  freezed: 
  json_annotation:
  build_runner: 
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

## CLI 使用方法（generate_feature.sh と整合）
このリポジトリに含まれる generate_feature.sh は対話式だけでなく、コマンド実行時の引数指定でも動作します。CI やコード生成エージェントから一発でディレクトリを作成したい場合は引数を利用してください。

主なオプション
- -n, --name NAME  
  フィーチャー名（例: UserProfile, order_history）
- -p, --permission NUM_OR_STR  
  権限（1|2|3|4 または admin|user|shared|direct）。数値は以下にマップされます: 1→admin, 2→user, 3→shared, 4→direct
- -l, --permission-level LEVEL  
  --permission と同等。文字列で直接指定する場合に使用します（admin/user/shared/direct）。
- -y, --yes  
  確認プロンプトをスキップして即時生成します（非対話的実行向け）。
- -h, --help  
  ヘルプを表示します。

動作のポイント
- 引数が与えられなければ従来どおり対話式で入力を促します（互換性を維持）。
- 権限の解釈は数値（1-4）と文字列の両方を受け付けます（大文字・小文字を問わない）。
- direct を指定すると lib/features/ 以下に直接フィーチャーディレクトリを作成します。その他は lib/features/{permission}/{feature_name_snake} に作成されます。
- フィーチャー名はスクリプト内で snake_case に変換されます（大文字→小文字、スペース/ハイフンをアンダースコアへ置換）。
- -y を指定すると「作成してよいか」の確認をスキップします。

使い方例
- 対話式（従来どおり）  
  ./Template/AI/generate_feature.sh
- 引数で一発（管理者用 feature を作成、確認スキップ）  
  ./Template/AI/generate_feature.sh -n UserProfile -p admin -y
- 数値で指定（shared を作成）  
  ./Template/AI/generate_feature.sh --name order_history --permission 3
- direct（features 配下に直接配置）  
  ./Template/AI/generate_feature.sh -n metrics -p direct