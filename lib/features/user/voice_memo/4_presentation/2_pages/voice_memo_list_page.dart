// Presentation層: ボイスメモ一覧ページ
// 役割: VoiceMemoListNotifier を購読し、一覧表示/リフレッシュ/簡易操作を提供します。

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../2_application/1_states/voice_memo_list_state.dart';
import '../../2_application/3_notifiers/voice_memo_list_notifier.dart';
import '../../2_application/3_notifiers/voice_memo_search_notifier.dart';

class VoiceMemoListPage extends HookConsumerWidget {
  const VoiceMemoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一覧の状態を購読（RiverpodのAsyncValue）
    final AsyncValue<VoiceMemoListState> asyncState = ref.watch(voiceMemoListNotifierProvider);
    // 検索の状態を購読（検索時のみ使用）
    final asyncSearch = ref.watch(voiceMemoSearchNotifierProvider);

    // Pull-to-Refreshの実装
    Future<void> onRefresh({bool includeTrashed = false, bool isSearching = false, String? query}) async {
      if (isSearching && (query != null && query.trim().isNotEmpty)) {
        await ref.read(voiceMemoSearchNotifierProvider.notifier).search(query: query);
      } else {
        await ref.read(voiceMemoListNotifierProvider.notifier).refresh(includeTrashed: includeTrashed);
      }
    }

    // 検索入力用のコントローラ
    final searchController = useTextEditingController();
    // テキストの変化で再ビルド（suffixIconの表示切替などのため）
    useListenable(searchController);
    // 検索クエリ保持（空やnullなら未検索として扱う）
    final searchQuery = useState<String?>(null);
    // ゴミ箱表示トグル
    final showTrashed = useState(false);

    final bool isSearching = (searchQuery.value != null && searchQuery.value!.trim().isNotEmpty);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Memos'),
        actions: [
          // ゴミ箱の表示/非表示切り替え
          IconButton(
            tooltip: showTrashed.value ? '通常一覧を表示' : 'ゴミ箱を表示',
            icon: Icon(showTrashed.value ? Icons.inbox : Icons.delete_outline),
            onPressed: () async {
              showTrashed.value = !showTrashed.value;
              // 検索中は再取得不要（UI側でフィルタリング）、通常一覧のみ再取得
              if (!isSearching) {
                await ref
                    .read(voiceMemoListNotifierProvider.notifier)
                    .refresh(includeTrashed: showTrashed.value);
              }
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'メモを検索（タイトル/メモ/文字起こし）',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                isDense: true,
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        tooltip: 'クリア',
                        icon: const Icon(Icons.clear),
                        onPressed: () async {
                          searchController.clear();
                          searchQuery.value = null; // 検索解除
                          // 通常一覧を再取得（ゴミ箱トグルに合わせる）
                          await ref
                              .read(voiceMemoListNotifierProvider.notifier)
                              .refresh(includeTrashed: showTrashed.value);
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (q) async {
                final query = q.trim();
                if (query.isEmpty) {
                  searchQuery.value = null; // 未検索扱い
                  await ref
                      .read(voiceMemoListNotifierProvider.notifier)
                      .refresh(includeTrashed: showTrashed.value);
                } else {
                  searchQuery.value = query;
                  await ref.read(voiceMemoSearchNotifierProvider.notifier).search(query: query);
                }
              },
            ),
          ),
        ),
      ),
      body: isSearching
          // 検索結果の表示
          ? asyncSearch.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => _ErrorView(
                message: err.toString(),
                onRetry: () => ref
                    .read(voiceMemoSearchNotifierProvider.notifier)
                    .search(query: searchQuery.value),
              ),
              data: (searchState) {
                // ゴミ箱の切り替えに合わせてUI側でフィルタ
                final results = searchState.results
                    .where((m) => showTrashed.value ? m.isTrashed : !m.isTrashed)
                    .toList(growable: false);

                if (results.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => onRefresh(
                      includeTrashed: showTrashed.value,
                      isSearching: true,
                      query: searchQuery.value,
                    ),
                    child: ListView(
                      children: const [
                        SizedBox(height: 48),
                        Center(child: Text('該当するメモがありません')),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => onRefresh(
                    includeTrashed: showTrashed.value,
                    isSearching: true,
                    query: searchQuery.value,
                  ),
                  child: ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final memo = results[index];
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
                            if (memo.isStarred) const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            if (memo.isTrashed) const Icon(Icons.delete, color: Colors.redAccent),
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
            )
          // 通常一覧の表示
          : asyncState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => _ErrorView(
                message: err.toString(),
                onRetry: () => ref
                    .read(voiceMemoListNotifierProvider.notifier)
                    .refresh(includeTrashed: showTrashed.value),
              ),
              data: (state) {
                // データ取得済み時の表示
                final items = state.items;
                if (items.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => onRefresh(includeTrashed: showTrashed.value),
                    child: ListView(
                      children: const [
                        SizedBox(height: 48),
                        Center(child: Text('メモがありません。右下の + から作成できます。')),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => onRefresh(includeTrashed: showTrashed.value),
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
                            if (memo.isStarred) const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            if (memo.isTrashed) const Icon(Icons.delete, color: Colors.redAccent),
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