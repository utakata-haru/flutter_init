import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import '../../3_application/3_notifiers/file_history_notifier.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(fileHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple PDF Editor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              ref.read(fileHistoryProvider.notifier).clearHistory();
            },
          ),
        ],
      ),
      body: historyState.when(
        data: (history) {
          if (history.isEmpty) {
            return const Center(
              child: Text('No files recently opened'),
            );
          }
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: Text(item.path.split('/').last),
                subtitle: Text(item.lastAccessed.toString()),
                onTap: () {
                  // Navigate to editor with file path
                  context.push('/editor', extra: item.path);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(fileHistoryProvider.notifier).removeFile(item.id);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );

          if (result != null && result.files.single.path != null) {
            final path = result.files.single.path!;
            await ref.read(fileHistoryProvider.notifier).addFile(path);
            if (context.mounted) {
              context.push('/editor', extra: path);
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
