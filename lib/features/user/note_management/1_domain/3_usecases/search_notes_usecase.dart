import '../1_entities/note_entity.dart';
import '../2_repositories/note_repository.dart';

/// メモ検索ユースケース
/// 
/// タイトルや本文でメモを検索するビジネスロジックを実装します。
/// 検索条件の処理、結果のフィルタリング、ソートを行います。
class SearchNotesUseCase {
  final NoteRepository _noteRepository;

  SearchNotesUseCase(this._noteRepository);

  /// メモを検索する
  /// 
  /// [query] 検索クエリ（タイトルと本文を対象）
  /// [limit] 取得件数の上限（指定しない場合は全件）
  /// [offset] 取得開始位置（ページネーション用）
  /// 
  /// Returns: 検索条件に合致するメモのリスト
  /// 
  /// Throws:
  /// - [ArgumentException] パラメータが無効な場合
  Future<List<NoteEntity>> call(
    String query, {
    int? limit,
    int? offset,
  }) async {
    // 入力検証
    if (limit != null && limit <= 0) {
      throw ArgumentError('limitは1以上である必要があります');
    }

    if (offset != null && offset < 0) {
      throw ArgumentError('offsetは0以上である必要があります');
    }

    // 検索クエリが空の場合は全メモを返す
    if (query.trim().isEmpty) {
      return await _noteRepository.getNotes(
        limit: limit,
        offset: offset,
      );
    }

    // リポジトリから検索実行
    final searchResults = await _noteRepository.searchNotes(
      query.trim(),
      limit: limit,
      offset: offset,
    );

    return searchResults;
  }

  /// 高度な検索を実行する
  /// 
  /// [query] 検索クエリ
  /// [searchInTitle] タイトルを検索対象に含めるか（デフォルト: true）
  /// [searchInContent] 本文を検索対象に含めるか（デフォルト: true）
  /// [caseSensitive] 大文字小文字を区別するか（デフォルト: false）
  /// [limit] 取得件数の上限
  /// [offset] 取得開始位置
  /// 
  /// Returns: 検索条件に合致するメモのリスト
  /// 
  /// 注意: この実装では、リポジトリレベルでの高度な検索がサポートされていない場合、
  /// 全データを取得してアプリケーション側でフィルタリングを行います。
  Future<List<NoteEntity>> advancedSearch(
    String query, {
    bool searchInTitle = true,
    bool searchInContent = true,
    bool caseSensitive = false,
    int? limit,
    int? offset,
  }) async {
    // 入力検証
    if (!searchInTitle && !searchInContent) {
      throw ArgumentError('タイトルまたは本文のいずれかは検索対象に含める必要があります');
    }

    if (query.trim().isEmpty) {
      return await _noteRepository.getNotes(
        limit: limit,
        offset: offset,
      );
    }

    // 基本検索を実行
    final basicResults = await _noteRepository.searchNotes(query.trim());

    // アプリケーション側でのフィルタリング
    final filteredResults = basicResults.where((note) {
      final searchQuery = caseSensitive ? query : query.toLowerCase();
      
      bool matches = false;
      
      if (searchInTitle) {
        final title = caseSensitive ? note.title : note.title.toLowerCase();
        matches |= title.contains(searchQuery);
      }
      
      if (searchInContent) {
        final content = caseSensitive ? note.content : note.content.toLowerCase();
        matches |= content.contains(searchQuery);
      }
      
      return matches;
    }).toList();

    // ページネーション処理
    final startIndex = offset ?? 0;
    final endIndex = limit != null ? startIndex + limit : filteredResults.length;
    
    if (startIndex >= filteredResults.length) {
      return [];
    }
    
    return filteredResults.sublist(
      startIndex,
      endIndex.clamp(0, filteredResults.length),
    );
  }

  /// 検索候補を取得する
  /// 
  /// [partialQuery] 部分的な検索クエリ
  /// [maxSuggestions] 最大候補数（デフォルト: 10）
  /// 
  /// Returns: 検索候補のリスト
  /// 
  /// 注意: 簡易実装として、部分クエリを含むタイトルの一覧を返します。
  Future<List<String>> getSuggestions(
    String partialQuery, {
    int maxSuggestions = 10,
  }) async {
    if (partialQuery.trim().isEmpty) {
      return [];
    }

    // 全メモを取得してタイトルから候補を抽出
    final allNotes = await _noteRepository.getNotes();
    
    final suggestions = <String>{};
    final lowerQuery = partialQuery.toLowerCase();
    
    for (final note in allNotes) {
      if (note.title.toLowerCase().contains(lowerQuery)) {
        suggestions.add(note.title);
      }
      
      // 単語レベルでの候補抽出
      final words = note.title.split(' ');
      for (final word in words) {
        if (word.toLowerCase().startsWith(lowerQuery)) {
          suggestions.add(word);
        }
      }
      
      if (suggestions.length >= maxSuggestions) {
        break;
      }
    }
    
    return suggestions.take(maxSuggestions).toList()..sort();
  }
}
