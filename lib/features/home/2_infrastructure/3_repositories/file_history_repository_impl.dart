import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../1_domain/1_entities/file_history.dart';
import '../../1_domain/2_repositories/file_history_repository.dart';
import '../1_models/file_history_model.dart';

class FileHistoryRepositoryImpl implements FileHistoryRepository {
  static const _key = 'file_history';

  @override
  Future<List<FileHistory>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList
        .map((json) => FileHistoryModel.fromJson(jsonDecode(json)).toEntity())
        .toList();
  }

  @override
  Future<void> addHistory(FileHistory history) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = await getHistory();
    
    // Remove existing entry with same path to avoid duplicates and update timestamp
    final updatedList = currentList.where((h) => h.path != history.path).toList();
    updatedList.insert(0, history); // Add to top

    final jsonList = updatedList
        .map((h) => jsonEncode(FileHistoryModel.fromEntity(h).toJson()))
        .toList();
    
    await prefs.setStringList(_key, jsonList);
  }

  @override
  Future<void> deleteHistory(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = await getHistory();
    final updatedList = currentList.where((h) => h.id != id).toList();
    
    final jsonList = updatedList
        .map((h) => jsonEncode(FileHistoryModel.fromEntity(h).toJson()))
        .toList();
        
    await prefs.setStringList(_key, jsonList);
  }

  @override
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
