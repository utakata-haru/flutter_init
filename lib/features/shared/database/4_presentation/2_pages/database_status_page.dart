// データベース状態を表示するページ（Presentation層）
// RiverpodのNotifier/Providerを用いて、初期化状態と現在のDBバージョンを表示します。

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/2_application/2_providers/database_providers.dart';
import '../../../database/2_application/1_states/database_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class DatabaseStatusPage extends ConsumerWidget {
  const DatabaseStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // モバイル端末（Android/iOS）のみ広告を初期化・表示
    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    BannerAd? banner;
    if (isMobile) {
      // バナー広告（テスト用ユニットID）
      banner = BannerAd(
        // プラットフォーム別にテスト用ユニットIDを使用（実機配信時は本番IDに差し替え）
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/6300978111' // Android テスト用
            : 'ca-app-pub-3940256099942544/2934735716', // iOS テスト用
        size: AdSize.banner,
        request: const AdRequest(),
        listener: const BannerAdListener(),
      )..load();
    }

    final state = ref.watch(databaseNotifierProvider);
    final repo = ref.watch(databaseRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Database Status')),
      // 画面下部に固定でバナー広告を表示（モバイル時のみ）
      bottomNavigationBar: isMobile && banner != null
          ? SafeArea(
              child: SizedBox(
                height: banner.size.height.toDouble(),
                child: AdWidget(ad: banner),
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '初期化ステータス',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            switch (state) {
              DatabaseInitial() => const Text('Initial: 未初期化'),
              DatabaseLoading() => const Row(
                  children: [
                    SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                    SizedBox(width: 8),
                    Text('Loading: 初期化中...'),
                  ],
                ),
              DatabaseReady() => const Text('Ready: 初期化済み'),
              DatabaseError(:final error) => Text('Error: $error'),
            },
            const SizedBox(height: 24),
            const Text(
              '現在のDBバージョン',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // DatabaseReady のときにバージョン表示を更新
            if (state is DatabaseReady)
              FutureBuilder<int>(
                future: repo.getCurrentVersion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('読み込み中...');
                  }
                  if (snapshot.hasError) {
                    return Text('取得エラー: ${snapshot.error}');
                  }
                  final v = snapshot.data ?? 0;
                  return Text('v$v');
                },
              )
            else
              const Text('-'),
            const Spacer(),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // 再初期化ボタン（Notifierのinitializeを再実行）
                    ref.read(databaseNotifierProvider.notifier).initialize();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('再初期化'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: state is DatabaseReady
                      ? () async {
                          // 簡易動作確認: sessions の件数を取得してSnackBarで表示
                          try {
                            final rows = await repo.rawQuery('SELECT COUNT(*) AS cnt FROM sessions');
                            final cnt = rows.isNotEmpty ? rows.first['cnt'] : null;
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('sessions 件数: $cnt')),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('クエリエラー: $e')),
                              );
                            }
                          }
                        }
                      : null,
                  icon: const Icon(Icons.query_stats),
                  label: const Text('セッション件数取得'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: state is DatabaseReady
                      ? () async {
                          // スキーマ確認: PRAGMA table_info(sessions) を実行して rating カラム有無を確認
                          try {
                            final rows = await repo.rawQuery('PRAGMA table_info(sessions)');
                            if (!context.mounted) return;

                            // 結果をダイアログで表示
                            await showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text('sessions テーブルスキーマ'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('cid | name | type | notnull | dflt_value'),
                                          const SizedBox(height: 8),
                                          for (final r in rows)
                                            Text(
                                              '${r['cid']} | ${r['name']} | ${r['type']} | ${r['notnull']} | ${r['dflt_value']}',
                                              style: const TextStyle(fontFamily: 'monospace'),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text('閉じる'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('スキーマ取得エラー: $e')),
                              );
                            }
                          }
                        }
                      : null,
                  icon: const Icon(Icons.schema),
                  label: const Text('スキーマ確認'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}