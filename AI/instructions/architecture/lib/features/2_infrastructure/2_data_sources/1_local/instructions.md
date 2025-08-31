---
applyTo: 'lib/features/**/2_infrastructure/2_data_sources/1_local/**'
---

# Local Data Source Layer Instructions - ローカルデータソース層

## 概要
ローカルデータソース層は、デバイス内のデータストレージ（SQLite、SharedPreferences、ファイルシステムなど）へのアクセスを担当します。データの永続化、キャッシュ、オフライン対応を実現するための重要な層です。

## 役割と責務

### ✅ すべきこと
- **ローカルストレージアクセス**: SQLite、SharedPreferences、ファイルシステムへの操作
- **データキャッシュ**: リモートから取得したデータのローカル保存
- **オフライン対応**: ネットワーク接続がない場合のデータ提供
- **データ同期**: ローカルとリモートデータの整合性管理
- **CRUD操作**: Create、Read、Update、Deleteの実装

### ❌ してはいけないこと
- **ビジネスロジックの実装**: ドメインルールやビジネス判断の記述
- **UIロジックの実装**: プレゼンテーション層のロジックの混入
- **ネットワーク通信**: HTTPリクエストやAPI呼び出し
- **エンティティの直接使用**: ドメインエンティティではなくモデルクラスを使用

## 実装ガイドライン

### 1. SQLiteデータソースの基本実装
```dart
// data_sources/local/user_local_data_source.dart
import 'package:sqflite/sqflite.dart';
import '../../1_models/user_db_model.dart';

abstract class UserLocalDataSource {
  Future<UserDbModel?> getUser(String id);
  Future<List<UserDbModel>> getAllUsers();
  Future<List<UserDbModel>> getUsersByRole(String role);
  Future<void> saveUser(UserDbModel user);
  Future<void> saveUsers(List<UserDbModel> users);
  Future<void> updateUser(UserDbModel user);
  Future<void> deleteUser(String id);
  Future<void> deleteAllUsers();
  Future<bool> userExists(String id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Database _database;

  UserLocalDataSourceImpl(this._database);

  @override
  Future<UserDbModel?> getUser(String id) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        UserDbModel.tableName,
        where: '${UserDbModel.columnId} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return UserDbModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      throw LocalDataSourceException('Failed to get user: $e');
    }
  }

  @override
  Future<List<UserDbModel>> getAllUsers() async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        UserDbModel.tableName,
        orderBy: '${UserDbModel.columnCreatedAt} DESC',
      );

      return maps.map((map) => UserDbModel.fromMap(map)).toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get all users: $e');
    }
  }

  @override
  Future<List<UserDbModel>> getUsersByRole(String role) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        UserDbModel.tableName,
        where: '${UserDbModel.columnRole} = ?',
        whereArgs: [role],
        orderBy: '${UserDbModel.columnName} ASC',
      );

      return maps.map((map) => UserDbModel.fromMap(map)).toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get users by role: $e');
    }
  }

  @override
  Future<void> saveUser(UserDbModel user) async {
    try {
      await _database.insert(
        UserDbModel.tableName,
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw LocalDataSourceException('Failed to save user: $e');
    }
  }

  @override
  Future<void> saveUsers(List<UserDbModel> users) async {
    final batch = _database.batch();
    
    try {
      for (final user in users) {
        batch.insert(
          UserDbModel.tableName,
          user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      
      await batch.commit(noResult: true);
    } catch (e) {
      throw LocalDataSourceException('Failed to save users: $e');
    }
  }

  @override
  Future<void> updateUser(UserDbModel user) async {
    try {
      final count = await _database.update(
        UserDbModel.tableName,
        user.toMap(),
        where: '${UserDbModel.columnId} = ?',
        whereArgs: [user.id],
      );

      if (count == 0) {
        throw LocalDataSourceException('User not found for update: ${user.id}');
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to update user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      final count = await _database.delete(
        UserDbModel.tableName,
        where: '${UserDbModel.columnId} = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        throw LocalDataSourceException('User not found for delete: $id');
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to delete user: $e');
    }
  }

  @override
  Future<void> deleteAllUsers() async {
    try {
      await _database.delete(UserDbModel.tableName);
    } catch (e) {
      throw LocalDataSourceException('Failed to delete all users: $e');
    }
  }

  @override
  Future<bool> userExists(String id) async {
    try {
      final List<Map<String, dynamic>> result = await _database.query(
        UserDbModel.tableName,
        columns: [UserDbModel.columnId],
        where: '${UserDbModel.columnId} = ?',
        whereArgs: [id],
        limit: 1,
      );

      return result.isNotEmpty;
    } catch (e) {
      throw LocalDataSourceException('Failed to check user existence: $e');
    }
  }
}
```

### 2. SharedPreferencesデータソース
```dart
// data_sources/local/settings_local_data_source.dart
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<bool?> getBool(String key);
  Future<double?> getDouble(String key);
  Future<List<String>?> getStringList(String key);
  
  Future<void> setString(String key, String value);
  Future<void> setInt(String key, int value);
  Future<void> setBool(String key, bool value);
  Future<void> setDouble(String key, double value);
  Future<void> setStringList(String key, List<String> value);
  
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences _preferences;

  SettingsLocalDataSourceImpl(this._preferences);

  @override
  Future<String?> getString(String key) async {
    try {
      return _preferences.getString(key);
    } catch (e) {
      throw LocalDataSourceException('Failed to get string: $e');
    }
  }

  @override
  Future<void> setString(String key, String value) async {
    try {
      final success = await _preferences.setString(key, value);
      if (!success) {
        throw LocalDataSourceException('Failed to set string for key: $key');
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to set string: $e');
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      return _preferences.getBool(key);
    } catch (e) {
      throw LocalDataSourceException('Failed to get bool: $e');
    }
  }

  @override
  Future<void> setBool(String key, bool value) async {
    try {
      final success = await _preferences.setBool(key, value);
      if (!success) {
        throw LocalDataSourceException('Failed to set bool for key: $key');
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to set bool: $e');
    }
  }

  // 他のメソッドも同様に実装...

  @override
  Future<void> clear() async {
    try {
      final success = await _preferences.clear();
      if (!success) {
        throw LocalDataSourceException('Failed to clear preferences');
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to clear preferences: $e');
    }
  }
}
```

### 3. ファイルシステムデータソース
```dart
// data_sources/local/file_local_data_source.dart
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

abstract class FileLocalDataSource {
  Future<String> readTextFile(String fileName);
  Future<void> writeTextFile(String fileName, String content);
  Future<Map<String, dynamic>> readJsonFile(String fileName);
  Future<void> writeJsonFile(String fileName, Map<String, dynamic> data);
  Future<bool> fileExists(String fileName);
  Future<void> deleteFile(String fileName);
  Future<List<String>> listFiles({String? extension});
}

class FileLocalDataSourceImpl implements FileLocalDataSource {
  late final Directory _appDocumentDir;
  
  FileLocalDataSourceImpl();

  Future<void> initialize() async {
    _appDocumentDir = await getApplicationDocumentsDirectory();
  }

  File _getFile(String fileName) {
    return File('${_appDocumentDir.path}/$fileName');
  }

  @override
  Future<String> readTextFile(String fileName) async {
    try {
      final file = _getFile(fileName);
      
      if (!await file.exists()) {
        throw LocalDataSourceException('File not found: $fileName');
      }
      
      return await file.readAsString();
    } catch (e) {
      throw LocalDataSourceException('Failed to read text file: $e');
    }
  }

  @override
  Future<void> writeTextFile(String fileName, String content) async {
    try {
      final file = _getFile(fileName);
      await file.writeAsString(content);
    } catch (e) {
      throw LocalDataSourceException('Failed to write text file: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> readJsonFile(String fileName) async {
    try {
      final content = await readTextFile(fileName);
      return json.decode(content) as Map<String, dynamic>;
    } catch (e) {
      throw LocalDataSourceException('Failed to read JSON file: $e');
    }
  }

  @override
  Future<void> writeJsonFile(String fileName, Map<String, dynamic> data) async {
    try {
      final content = json.encode(data);
      await writeTextFile(fileName, content);
    } catch (e) {
      throw LocalDataSourceException('Failed to write JSON file: $e');
    }
  }

  @override
  Future<bool> fileExists(String fileName) async {
    try {
      final file = _getFile(fileName);
      return await file.exists();
    } catch (e) {
      throw LocalDataSourceException('Failed to check file existence: $e');
    }
  }

  @override
  Future<void> deleteFile(String fileName) async {
    try {
      final file = _getFile(fileName);
      
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to delete file: $e');
    }
  }

  @override
  Future<List<String>> listFiles({String? extension}) async {
    try {
      final files = await _appDocumentDir.list().toList();
      final fileNames = files
          .whereType<File>()
          .map((file) => file.path.split('/').last)
          .where((name) => extension == null || name.endsWith(extension))
          .toList();
      
      return fileNames;
    } catch (e) {
      throw LocalDataSourceException('Failed to list files: $e');
    }
  }
}
```

### 4. キャッシュ機能付きデータソース
```dart
// data_sources/local/cache_local_data_source.dart
class CacheLocalDataSource<T> {
  final Map<String, CacheEntry<T>> _cache = {};
  final Duration _defaultTtl;

  CacheLocalDataSource({Duration? defaultTtl})
      : _defaultTtl = defaultTtl ?? const Duration(hours: 1);

  T? get(String key) {
    final entry = _cache[key];
    
    if (entry == null) {
      return null;
    }
    
    if (entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    
    return entry.value;
  }

  void put(String key, T value, {Duration? ttl}) {
    final expiry = DateTime.now().add(ttl ?? _defaultTtl);
    _cache[key] = CacheEntry(value, expiry);
  }

  void remove(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }

  bool containsKey(String key) {
    final entry = _cache[key];
    if (entry == null) {
      return false;
    }
    
    if (entry.isExpired) {
      _cache.remove(key);
      return false;
    }
    
    return true;
  }

  int get size => _cache.length;

  void cleanExpired() {
    final now = DateTime.now();
    _cache.removeWhere((key, entry) => entry.expiry.isBefore(now));
  }
}

class CacheEntry<T> {
  final T value;
  final DateTime expiry;

  CacheEntry(this.value, this.expiry);

  bool get isExpired => DateTime.now().isAfter(expiry);
}
```

## 命名規則

### ファイル名
- **命名形式**: `{対象名}_local_data_source.dart`
- **例**: `user_local_data_source.dart`, `settings_local_data_source.dart`

### クラス名
- **インターフェース**: `{対象名}LocalDataSource`
- **実装クラス**: `{対象名}LocalDataSourceImpl`
- **例**: `UserLocalDataSource`, `UserLocalDataSourceImpl`

### メソッド名
- **取得系**: `get{対象}`, `getAll{対象}`, `find{対象}`
- **保存系**: `save{対象}`, `insert{対象}`, `store{対象}`
- **更新系**: `update{対象}`, `modify{対象}`
- **削除系**: `delete{対象}`, `remove{対象}`
- **存在確認**: `{対象}Exists`, `contains{対象}`

## ベストプラクティス

### 1. トランザクション処理
```dart
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Database _database;

  Future<void> saveUserWithProfile(
    UserDbModel user,
    UserProfileDbModel profile,
  ) async {
    await _database.transaction((txn) async {
      try {
        // ユーザー保存
        await txn.insert(
          UserDbModel.tableName,
          user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // プロフィール保存
        await txn.insert(
          UserProfileDbModel.tableName,
          profile.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } catch (e) {
        // トランザクションは自動的にロールバックされる
        throw LocalDataSourceException('Failed to save user with profile: $e');
      }
    });
  }
}
```

### 2. バッチ操作の最適化
```dart
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<void> saveProducts(List<ProductDbModel> products) async {
    if (products.isEmpty) return;

    const batchSize = 500; // バッチサイズを制限
    
    for (int i = 0; i < products.length; i += batchSize) {
      final batch = _database.batch();
      final end = (i + batchSize < products.length) ? i + batchSize : products.length;
      
      for (int j = i; j < end; j++) {
        batch.insert(
          ProductDbModel.tableName,
          products[j].toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      
      await batch.commit(noResult: true);
    }
  }
}
```

### 3. エラーハンドリングと例外定義
```dart
// exceptions/local_data_source_exceptions.dart
abstract class LocalDataSourceException implements Exception {
  final String message;
  LocalDataSourceException(this.message);
  
  @override
  String toString() => 'LocalDataSourceException: $message';
}

class DatabaseException extends LocalDataSourceException {
  DatabaseException(super.message);
}

class FileSystemException extends LocalDataSourceException {
  FileSystemException(super.message);
}

class CacheException extends LocalDataSourceException {
  CacheException(super.message);
}
```

## 依存関係の制約

### 許可されるimport
```dart
// ✅ 標準ライブラリ
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// ✅ ローカルストレージライブラリ
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

// ✅ モデルクラス
import '../../1_models/user_db_model.dart';

// ✅ 例外クラス
import '../exceptions/local_data_source_exceptions.dart';
```

### 禁止されるimport
```dart
// ❌ UIフレームワーク
import 'package:flutter/material.dart';

// ❌ HTTP通信
import 'package:dio/dio.dart';
import 'package:http/http.dart';

// ❌ ドメインエンティティ
import '../../../1_domain/1_entities/user_entity.dart';

// ❌ アプリケーション層
import '../../../3_application/states/user_state.dart';
```

## テスト指針

### 1. SQLiteテスト
```dart
// test/infrastructure/data_sources/local/user_local_data_source_test.dart
void main() {
  group('UserLocalDataSource', () {
    late Database database;
    late UserLocalDataSourceImpl dataSource;

    setUp(() async {
      database = await openDatabase(
        ':memory:',
        version: 1,
        onCreate: (db, version) async {
          await db.execute(UserDbModel.createTableSql);
        },
      );
      dataSource = UserLocalDataSourceImpl(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('should save and retrieve user', () async {
      // Given
      final user = UserDbModel(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // When
      await dataSource.saveUser(user);
      final retrievedUser = await dataSource.getUser('1');

      // Then
      expect(retrievedUser, isNotNull);
      expect(retrievedUser!.id, '1');
      expect(retrievedUser.name, 'Test User');
    });

    test('should return null when user not found', () async {
      // When
      final user = await dataSource.getUser('nonexistent');

      // Then
      expect(user, isNull);
    });
  });
}
```

## 注意事項

1. **パフォーマンス**: 大量データの処理時はバッチ操作やページネーションを使用
2. **エラーハンドリング**: データベースやファイルシステムの例外を適切にキャッチ
3. **データ整合性**: トランザクションを使用して一貫性を保証
4. **メモリ管理**: 大きなデータを扱う際はメモリリークに注意
5. **セキュリティ**: 機密データは適切に暗号化して保存
