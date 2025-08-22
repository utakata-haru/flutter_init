// Presentation層: ボイスメモ詳細ページ
// 役割: 指定IDの VoiceMemo を取得して表示します。Riverpod Notifier を購読し、初回マウント時に fetch を実行します。

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../2_application/1_states/voice_memo_detail_state.dart';
import '../../2_application/3_notifiers/voice_memo_detail_notifier.dart';

class VoiceMemoDetailPage extends HookConsumerWidget {
  final String id;
  const VoiceMemoDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 詳細状態を購読
    final AsyncValue<VoiceMemoDetailState> asyncState = ref.watch(voiceMemoDetailNotifierProvider);

    // マウント時に対象IDのメモを取得（id が変わった場合も再取得）
    useEffect(() {
      Future.microtask(() => ref.read(voiceMemoDetailNotifierProvider.notifier).fetch(id));
      return null; // クリーンアップ不要
    }, [id]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ詳細'),
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => _ErrorView(
          message: err.toString(),
          onRetry: () => ref.read(voiceMemoDetailNotifierProvider.notifier).fetch(id),
        ),
        data: (state) {
          final item = state.item;
          if (item == null) {
            return _EmptyView(
              onReload: () => ref.read(voiceMemoDetailNotifierProvider.notifier).fetch(id),
            );
          }

          final tagsLabel = item.tags.map((t) => t.name).join(', ');
          final durationSec = (item.durationMs / 1000).round();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // タイトル
              Text(
                item.title.isEmpty ? '(無題)' : item.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              // メタ情報（タグ/長さ/状態）
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (tagsLabel.isNotEmpty)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.tag, size: 16),
                      const SizedBox(width: 4),
                      Text('#$tagsLabel'),
                    ]),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.timer, size: 16),
                    const SizedBox(width: 4),
                    Text('${durationSec}s'),
                  ]),
                  if (item.isStarred)
                    const Chip(
                      avatar: Icon(Icons.star, color: Colors.amber, size: 16),
                      label: Text('スター'),
                    ),
                  if (item.isTrashed)
                    const Chip(
                      avatar: Icon(Icons.delete, color: Colors.redAccent, size: 16),
                      label: Text('ゴミ箱'),
                    ),
                ],
              ),

              const SizedBox(height: 24),
              // 文字起こしなど詳細本文は将来拡張
              const Text('詳細本文（文字起こしなど）は後続ステップで実装します。'),
            ],
          );
        },
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

class _EmptyView extends StatelessWidget {
  final VoidCallback onReload;
  const _EmptyView({required this.onReload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, size: 36),
            const SizedBox(height: 8),
            const Text('対象のメモが見つかりませんでした。'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onReload,
              icon: const Icon(Icons.refresh),
              label: const Text('再読み込み'),
            ),
          ],
        ),
      ),
    );
  }
}