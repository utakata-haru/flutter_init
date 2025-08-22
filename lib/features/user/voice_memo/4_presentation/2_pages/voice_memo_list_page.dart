// Presentation層: ボイスメモ一覧ページ
// 役割: VoiceMemoListNotifier を購読し、一覧表示/リフレッシュ/簡易操作を提供します。

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../2_application/1_states/voice_memo_list_state.dart';
import '../../2_application/3_notifiers/voice_memo_list_notifier.dart';

class VoiceMemoListPage extends HookConsumerWidget {
  const VoiceMemoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一覧の状態を購読（RiverpodのAsyncValue）
    final AsyncValue<VoiceMemoListState> asyncState = ref.watch(voiceMemoListNotifierProvider);

    // Pull-to-Refreshの実装
    Future<void> onRefresh() async {
      await ref.read(voiceMemoListNotifierProvider.notifier).refresh();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Memos'),
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => _ErrorView(
          message: err.toString(),
          onRetry: () => ref.read(voiceMemoListNotifierProvider.notifier).refresh(),
        ),
        data: (state) {
          // データ取得済み時の表示
          final items = state.items;
          if (items.isEmpty) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                children: const [
                  SizedBox(height: 48),
                  Center(child: Text('メモがありません。右下の + から作成できます。')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final memo = items[index];
                final tagsLabel = memo.tags.map((t) => t.name).join(', ');
                final durationSec = (memo.durationMs / 1000).round();
                return ListTile(
                  title: Text(memo.title.isEmpty ? '(無題)' : memo.title),
                  subtitle: Text([
                    if (tagsLabel.isNotEmpty) '#$tagsLabel',
                    '${durationSec}s',
                  ].join('  ')),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (memo.isStarred)
                        const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 8),
                      if (memo.isTrashed)
                        const Icon(Icons.delete, color: Colors.redAccent),
                    ],
                  ),
                  onTap: () {
                    context.pushNamed(
                      'voiceMemoDetail',
                      pathParameters: {'id': memo.id},
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('voiceMemoCreate');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 36),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}