// Presentation層: ボイスメモ作成/編集ページ（今回は作成用のプレースホルダー実装）
// 役割: タイトルやタグなどの基本情報を入力するフォームを提供します。
// 保存処理は後続ステップ（Application/Infrastructureの整備後）で実装します。

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VoiceMemoEditPage extends HookConsumerWidget {
  const VoiceMemoEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 入力コントローラ（タイトル/タグ）
    final titleController = useTextEditingController();
    final tagsController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規メモ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // タイトル入力
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'タイトル',
                hintText: 'メモのタイトルを入力',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // タグ入力（カンマ区切り）
            TextField(
              controller: tagsController,
              decoration: const InputDecoration(
                labelText: 'タグ（カンマ区切り）',
                hintText: 'work, idea, todo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // 保存/キャンセルボタン
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // 後続で保存処理を実装
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('保存は後続ステップで実装します。')),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('保存'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close),
                  label: const Text('キャンセル'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}