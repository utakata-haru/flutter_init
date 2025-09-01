import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../1_domain/1_entities/note_entity.dart';
import '../2_molecules/note_card.dart';
import '../1_atoms/note_tile.dart';

/// メモ一覧表示オーガニズム
/// 
/// 検索機能、フィルタリング機能を含むメモ一覧セクション
/// 異なる表示形式（カード、リスト、グリッド）に対応
class NoteListView extends HookWidget {
  const NoteListView({
    super.key,
    required this.notes,
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.viewMode = NoteViewMode.card,
    this.sortOption = NoteSortOption.updatedAtDesc,
    this.onNoteTap,
    this.onNoteEdit,
    this.onNoteDelete,
    this.onNoteTogglePinned,
    this.onSearch,
    this.onRefresh,
    this.onViewModeChanged,
    this.onSortChanged,
    this.emptyMessage = 'メモがありません',
    this.showSearch = true,
    this.showSortControls = true,
    this.showViewModeToggle = true,
  });

  /// 表示するメモ一覧
  final List<NoteEntity> notes;
  
  /// ローディング状態
  final bool isLoading;
  
  /// エラー情報
  final String? error;
  
  /// 検索クエリ
  final String searchQuery;
  
  /// 表示モード
  final NoteViewMode viewMode;
  
  /// ソート方式
  final NoteSortOption sortOption;
  
  /// メモタップ時のコールバック
  final void Function(NoteEntity note)? onNoteTap;
  
  /// メモ編集時のコールバック
  final void Function(NoteEntity note)? onNoteEdit;
  
  /// メモ削除時のコールバック
  final void Function(NoteEntity note)? onNoteDelete;
  
  /// メモピン留め切り替え時のコールバック
  final void Function(NoteEntity note)? onNoteTogglePinned;
  
  /// 検索時のコールバック
  final void Function(String query)? onSearch;
  
  /// リフレッシュ時のコールバック
  final VoidCallback? onRefresh;
  
  /// 表示モード変更時のコールバック
  final void Function(NoteViewMode mode)? onViewModeChanged;
  
  /// ソート変更時のコールバック
  final void Function(NoteSortOption option)? onSortChanged;
  
  /// 空状態のメッセージ
  final String emptyMessage;
  
  /// 検索機能を表示するか
  final bool showSearch;
  
  /// ソートコントロールを表示するか
  final bool showSortControls;
  
  /// 表示モード切り替えを表示するか
  final bool showViewModeToggle;

  @override
  Widget build(BuildContext context) {
    
    // 検索コントローラー
    final searchController = useTextEditingController(text: searchQuery);
    
    // 検索入力の監視
    useEffect(() {
      void handleSearchChanged() {
        onSearch?.call(searchController.text);
      }
      
      searchController.addListener(handleSearchChanged);
      
      return () {
        searchController.removeListener(handleSearchChanged);
      };
    }, []);
    
    return Column(
      children: [
        // ヘッダーセクション
        if (showSearch || showSortControls || showViewModeToggle)
          _buildHeaderSection(context, searchController),
        
        // コンテンツセクション
        Expanded(
          child: _buildContentSection(context),
        ),
      ],
    );
  }
  
  /// ヘッダーセクション構築
  Widget _buildHeaderSection(BuildContext context, TextEditingController searchController) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 検索バー
          if (showSearch)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'メモを検索...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          
          // コントロールセクション
          if (showSortControls || showViewModeToggle) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                // ソートコントロール
                if (showSortControls) ...[
                  DropdownButton<NoteSortOption>(
                    value: sortOption,
                    items: NoteSortOption.values.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) onSortChanged?.call(value);
                    },
                  ),
                ],
                
                const Spacer(),
                
                // 表示モード切り替え
                if (showViewModeToggle)
                  SegmentedButton<NoteViewMode>(
                    segments: const [
                      ButtonSegment<NoteViewMode>(
                        value: NoteViewMode.list,
                        icon: Icon(Icons.view_list),
                      ),
                      ButtonSegment<NoteViewMode>(
                        value: NoteViewMode.card,
                        icon: Icon(Icons.view_module),
                      ),
                      ButtonSegment<NoteViewMode>(
                        value: NoteViewMode.grid,
                        icon: Icon(Icons.grid_view),
                      ),
                    ],
                    selected: {viewMode},
                    onSelectionChanged: (Set<NoteViewMode> selection) {
                      onViewModeChanged?.call(selection.first);
                    },
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  /// コンテンツセクション構築
  Widget _buildContentSection(BuildContext context) {
    // エラー状態
    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'エラーが発生しました',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (onRefresh != null)
              FilledButton(
                onPressed: onRefresh,
                child: const Text('再試行'),
              ),
          ],
        ),
      );
    }
    
    // ローディング状態
    if (isLoading && notes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    // 空状態
    if (notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_add_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }
    
    // メモ一覧表示
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },
      child: _buildNoteList(context),
    );
  }
  
  /// メモリスト構築
  Widget _buildNoteList(BuildContext context) {
    switch (viewMode) {
      case NoteViewMode.list:
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteTile(
              note: note,
              onTap: () => onNoteTap?.call(note),
            );
          },
        );
        
      case NoteViewMode.card:
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: NoteCard(
                note: note,
                onTap: () => onNoteTap?.call(note),
                onEdit: () => onNoteEdit?.call(note),
                onDelete: () => onNoteDelete?.call(note),
              ),
            );
          },
        );
        
      case NoteViewMode.grid:
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              variant: NoteCardVariant.compact,
              onTap: () => onNoteTap?.call(note),
              onEdit: () => onNoteEdit?.call(note),
              onDelete: () => onNoteDelete?.call(note),
            );
          },
        );
    }
  }
}

/// 表示モード列挙型
enum NoteViewMode {
  list,
  card,
  grid,
}

/// ソート方式列挙型
enum NoteSortOption {
  updatedAtDesc('更新日時（新しい順）'),
  updatedAtAsc('更新日時（古い順）'),
  createdAtDesc('作成日時（新しい順）'),
  createdAtAsc('作成日時（古い順）'),
  titleAsc('タイトル（A-Z）'),
  titleDesc('タイトル（Z-A）'),
  pinnedFirst('ピン留め優先');

  const NoteSortOption(this.label);
  
  final String label;
}
