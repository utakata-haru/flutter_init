// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$noteFormNotifierHash() => r'7219a5f84361568f2bc3d881c66d1526ad240041';

/// メモフォームの状態管理を行うNotifier
///
/// メモの作成、更新、削除などのフォーム操作を管理し、
/// 対応する状態変更をUIに提供します。
///
/// Copied from [NoteFormNotifier].
@ProviderFor(NoteFormNotifier)
final noteFormNotifierProvider =
    AutoDisposeNotifierProvider<NoteFormNotifier, NoteFormState>.internal(
      NoteFormNotifier.new,
      name: r'noteFormNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$noteFormNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NoteFormNotifier = AutoDisposeNotifier<NoteFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
