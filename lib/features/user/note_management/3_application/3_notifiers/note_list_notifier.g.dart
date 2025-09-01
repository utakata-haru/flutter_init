// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$noteListNotifierHash() => r'ae6652dcdea5f2e9c5c254da1240814ec3421b8e';

/// メモ一覧の状態管理を行うNotifier
///
/// メモの一覧取得、検索、リフレッシュなどの操作を管理し、
/// 対応する状態変更をUIに提供します。
///
/// Copied from [NoteListNotifier].
@ProviderFor(NoteListNotifier)
final noteListNotifierProvider =
    AutoDisposeNotifierProvider<NoteListNotifier, NoteListState>.internal(
      NoteListNotifier.new,
      name: r'noteListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$noteListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NoteListNotifier = AutoDisposeNotifier<NoteListState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
