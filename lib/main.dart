import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'features/shared/database/2_application/2_providers/database_providers.dart';
import 'features/shared/database/1_domain/1_entities/database_migration_entity.dart';
import 'features/shared/database/3_infrastructure/1_data_sources/1_local/database_local_data_source.dart';
import 'features/shared/database/3_infrastructure/3_repositories/database_repository_impl.dart';
import 'features/shared/database/4_presentation/2_pages/database_status_page.dart';
import 'package:flutter/foundation.dart';

void main() {
  // インフラ依存の生成（ローカルデータソース/リポジトリ）
  final ds = DatabaseLocalDataSource();
  final repo = DatabaseRepositoryImpl(ds);

  // v2 マイグレーション計画（例：sessions に rating カラムを追加）
  const plan = <DatabaseMigration>[
    DatabaseMigration(
      version: 2,
      upSql: [
        // セッションに評価カラムを追加（デフォルト0）
        'ALTER TABLE sessions ADD COLUMN rating INTEGER DEFAULT 0',
      ],
    ),
  ];

  runApp(
    ProviderScope(
      overrides: [
        // リポジトリの具象を注入
        databaseRepositoryProvider.overrideWithValue(repo),
        // マイグレーション計画を注入（v2を適用）
        migrationPlanProvider.overrideWithValue(plan),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // 初回フレーム後にDB初期化を実行
    // バナー広告SDKの初期化（テスト広告を利用）
    // Webでは未対応のため、モバイル（Android/iOS）のみ初期化
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    MobileAds.instance.initialize();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // DBを初期化
      ref.read(databaseNotifierProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NamiLog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DatabaseStatusPage(),
    );
  }
}
