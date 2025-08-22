// Presentation層: ボイスメモ作成/編集ページ（録音対応版）
// 役割: タイトル/タグ入力 + 録音開始/停止 + 視覚的フィードバック + 保存
// 注意: Androidでのマイク・ストレージ権限に対応

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../1_domain/1_entities/tag_entity.dart';
import '../../2_application/3_notifiers/voice_memo_create_notifier.dart';
import '../../2_application/3_notifiers/voice_memo_list_notifier.dart'; // 追加: 保存後に一覧を更新するため

class VoiceMemoEditPage extends HookConsumerWidget {
  const VoiceMemoEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 入力コントローラ（タイトル/タグ）
    final titleController = useTextEditingController();
    final tagsController = useTextEditingController();

    // BuildContextを跨いだ非同期利用を避けるため、メッセンジャー/ナビゲーターを確保
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // 録音用の状態
    final recorder = useMemoized(() => AudioRecorder());
    final isRecording = useState(false);
    final startAt = useState<DateTime?>(null);
    final recordedPath = useState<String?>(null);
    final durationMs = useState<int>(0);
    final amplitudeNorm = useState<double>(0); // 0.0〜1.0 に正規化

    // Amplitude監視（簡易波形）
    useEffect(() {
      final sub = recorder
          .onAmplitudeChanged(const Duration(milliseconds: 120))
          .listen((amp) {
        // record の Amplitude は dB（負の値〜0）を返す
        final currentDb = amp.current; // 非nullのためnull合体演算子は不要
        // -45dB 〜 0dB を 0.0 〜 1.0 に線形マッピング（簡易）
        double n;
        if (currentDb <= -45) {
          n = 0;
        } else if (currentDb >= 0) {
          n = 1;
        } else {
          n = (currentDb + 45) / 45;
        }
        amplitudeNorm.value = (n.clamp(0.0, 1.0)).toDouble();
      }, onError: (_) {});
      return () => sub.cancel();
    }, [recorder]);

    // dispose 時にリソース解放
    useEffect(() {
      return () async {
        try {
          if (isRecording.value) {
            await recorder.stop();
          }
        } catch (_) {}
        await recorder.dispose();
      };
    }, [recorder]);

    // 権限要求: マイク
    Future<bool> ensureMicPermission() async {
      // permission_handler で明示要求
      final micStatus = await Permission.microphone.request();
      if (micStatus.isGranted) return true;
      // 念の為、record 側の hasPermission も確認（Androidではダイアログ表示が行われることがある）
      try {
        return await recorder.hasPermission();
      } catch (_) {
        return false;
      }
    }

    // 権限要求: ストレージ（古いAndroid向け、アプリ専用ディレクトリでは基本不要）
    Future<void> requestStoragePermissionIfNeeded() async {
      if (!Platform.isAndroid) return;
      // ベストエフォートで要求（API29+では不要/無視される場合あり）
      await Permission.storage.request();
    }

    // 録音開始
    Future<void> startRecording() async {
      if (isRecording.value) return;
      // マイク許可
      final ok = await ensureMicPermission();
      if (!ok) {
        messenger.showSnackBar(
          const SnackBar(content: Text('マイク使用許可が必要です。設定から許可してください。')),
        );
        return;
      }
      // ストレージ許可（古い端末向け）
      await requestStoragePermissionIfNeeded();

      try {
        // アプリ専用ディレクトリに保存（追加の権限不要）
        final dir = await getApplicationDocumentsDirectory();
        final fileName = 'voice_memo_${DateTime.now().millisecondsSinceEpoch}.m4a';
        final path = p.join(dir.path, fileName);

        await recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc, // AAC-LC（m4a）
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path,
        );

        // 状態更新
        recordedPath.value = null; // stop() から最終パスを受け取る
        startAt.value = DateTime.now();
        isRecording.value = true;
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('録音開始に失敗しました: $e')),
        );
      }
    }

    // 録音停止
    Future<void> stopRecording() async {
      if (!isRecording.value) return;
      try {
        final stoppedPath = await recorder.stop();
        isRecording.value = false;

        // 長さを算出
        final s = startAt.value;
        if (s != null) {
          durationMs.value = DateTime.now().difference(s).inMilliseconds;
        }
        startAt.value = null;

        // 停止後のパスを確定
        if (stoppedPath != null && stoppedPath.isNotEmpty) {
          recordedPath.value = stoppedPath;
        }

        if (recordedPath.value != null) {
          messenger.showSnackBar(
            SnackBar(content: Text('録音を保存しました: ${p.basename(recordedPath.value!)}')),
          );
        } else {
          messenger.showSnackBar(
            const SnackBar(content: Text('録音ファイルの保存に失敗しました。')),
          );
        }
      } catch (e) {
        isRecording.value = false;
        messenger.showSnackBar(
          SnackBar(content: Text('録音停止に失敗しました: $e')),
        );
      }
    }

    // タグ生成: name をトリム、id は name の小文字正規化から決定（同名に対して一貫性を持たせる）
    List<Tag> buildTags(String input) {
      final parts = input.split(',');
      final List<Tag> tags = [];
      for (final raw in parts) {
        final name = raw.trim();
        if (name.isEmpty) continue;
        final normalized = name.toLowerCase();
        final id = 'tag_${normalized.replaceAll(RegExp(r"\\s+"), '_')}';
        tags.add(Tag(id: id, name: name));
      }
      return tags;
    }

    // 保存処理: Create UseCase を呼ぶ
    Future<void> saveMemo() async {
      final title = titleController.text.trim();
      if (title.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text('タイトルを入力してください。')),
        );
        return;
      }
      final path = recordedPath.value;
      if (path == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('録音を実行してから保存してください。')),
        );
        return;
      }

      final tags = buildTags(tagsController.text);

      try {
        final notifier = ref.read(voiceMemoCreateNotifierProvider.notifier);
        await notifier.create(
          title: title,
          tags: tags,
          isStarred: false,
          note: null,
          durationMs: durationMs.value,
          audioPath: path,
          createdAt: DateTime.now(),
        );
        // 一覧を再取得するため、一覧Notifierをinvalidateしてから戻る
        ref.invalidate(voiceMemoListNotifierProvider);
        navigator.maybePop();
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('保存に失敗しました: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規メモ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
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

              // 録音セクション
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.mic,
                            color: isRecording.value
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isRecording.value ? '録音中...' : '未録音',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          if (!isRecording.value)
                            ElevatedButton.icon(
                              onPressed: startRecording,
                              icon: const Icon(Icons.fiber_manual_record),
                              label: const Text('録音開始'),
                            )
                          else
                            OutlinedButton.icon(
                              onPressed: stopRecording,
                              icon: const Icon(Icons.stop),
                              label: const Text('停止'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 簡易波形（単一バーの高さで表現）
                      SizedBox(
                        height: 48,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 120),
                            curve: Curves.easeOut,
                            width: double.infinity,
                            height: 4 + 44 * amplitudeNorm.value, // 4〜48px
                            decoration: BoxDecoration(
                              color: isRecording.value
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (recordedPath.value != null)
                        Text(
                          '保存先: ${recordedPath.value}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 保存/キャンセルボタン
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: saveMemo,
                    icon: const Icon(Icons.save),
                    label: const Text('保存'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => navigator.maybePop(),
                    icon: const Icon(Icons.close),
                    label: const Text('キャンセル'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}