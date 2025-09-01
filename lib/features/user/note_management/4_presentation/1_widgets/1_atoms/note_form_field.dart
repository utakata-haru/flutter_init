import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// メモ作成・編集用のフォームフィールドコンポーネント
/// 
/// タイトルや内容の入力に使用される基本的なテキストフィールド
/// バリデーション、文字数制限、カスタムスタイリングに対応
class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.labelText,
    this.hintText,
    this.helpText,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
    this.fieldType = NoteFormFieldType.text,
    this.style,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final String? hintText;
  final String? helpText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final NoteFormFieldType fieldType;
  final NoteFormFieldStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveStyle = style ?? NoteFormFieldStyle.defaultStyle(theme);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // カスタムラベル（helpText付きの場合）
        if (labelText != null && helpText != null) ...[
          Row(
            children: [
              Text(
                labelText!,
                style: effectiveStyle.labelStyle,
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: helpText!,
                child: Icon(
                  Icons.help_outline,
                  size: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        
        // メインフォームフィールド
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: keyboardType ?? _getDefaultKeyboardType(),
          textInputAction: textInputAction ?? _getDefaultTextInputAction(),
          autofocus: autofocus,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obscureText,
          autocorrect: autocorrect,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters ?? _getDefaultInputFormatters(),
          style: effectiveStyle.textStyle,
          decoration: InputDecoration(
            labelText: (helpText == null) ? labelText : null,
            hintText: hintText ?? _getDefaultHintText(),
            helperText: (helpText == null) ? null : helpText,
            border: effectiveStyle.border,
            enabledBorder: effectiveStyle.enabledBorder,
            focusedBorder: effectiveStyle.focusedBorder,
            errorBorder: effectiveStyle.errorBorder,
            focusedErrorBorder: effectiveStyle.focusedErrorBorder,
            filled: effectiveStyle.filled,
            fillColor: effectiveStyle.fillColor,
            contentPadding: effectiveStyle.contentPadding,
            counterText: _shouldShowCounter() ? null : '',
          ),
        ),
      ],
    );
  }

  /// フィールドタイプに応じたデフォルトキーボードタイプを取得
  TextInputType _getDefaultKeyboardType() {
    switch (fieldType) {
      case NoteFormFieldType.title:
        return TextInputType.text;
      case NoteFormFieldType.content:
        return TextInputType.multiline;
      case NoteFormFieldType.search:
        return TextInputType.text;
      case NoteFormFieldType.text:
        return TextInputType.text;
    }
  }

  /// フィールドタイプに応じたデフォルトテキスト入力アクションを取得
  TextInputAction _getDefaultTextInputAction() {
    switch (fieldType) {
      case NoteFormFieldType.title:
        return TextInputAction.next;
      case NoteFormFieldType.content:
        return TextInputAction.newline;
      case NoteFormFieldType.search:
        return TextInputAction.search;
      case NoteFormFieldType.text:
        return TextInputAction.done;
    }
  }

  /// フィールドタイプに応じたデフォルトヒントテキストを取得
  String _getDefaultHintText() {
    switch (fieldType) {
      case NoteFormFieldType.title:
        return 'メモのタイトルを入力';
      case NoteFormFieldType.content:
        return 'メモの内容を入力';
      case NoteFormFieldType.search:
        return 'メモを検索';
      case NoteFormFieldType.text:
        return 'テキストを入力';
    }
  }

  /// フィールドタイプに応じたデフォルト入力フォーマッターを取得
  List<TextInputFormatter> _getDefaultInputFormatters() {
    switch (fieldType) {
      case NoteFormFieldType.title:
        return [
          LengthLimitingTextInputFormatter(100), // タイトルは100文字まで
          FilteringTextInputFormatter.deny(RegExp(r'\n')), // 改行禁止
        ];
      case NoteFormFieldType.content:
        return [
          LengthLimitingTextInputFormatter(10000), // 内容は10000文字まで
        ];
      case NoteFormFieldType.search:
        return [
          FilteringTextInputFormatter.deny(RegExp(r'\n')), // 改行禁止
        ];
      case NoteFormFieldType.text:
        return [];
    }
  }

  /// 文字数カウンターを表示するかどうか
  bool _shouldShowCounter() {
    return fieldType == NoteFormFieldType.content && maxLength != null;
  }
}

/// フォームフィールドのタイプ
enum NoteFormFieldType {
  /// メモタイトル
  title,
  /// メモ内容
  content,
  /// 検索
  search,
  /// 汎用テキスト
  text,
}

/// フォームフィールドのスタイル設定
class NoteFormFieldStyle {
  const NoteFormFieldStyle({
    this.textStyle,
    this.labelStyle,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.filled = true,
    this.fillColor,
    this.contentPadding = const EdgeInsets.all(16),
  });

  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool filled;
  final Color? fillColor;
  final EdgeInsets contentPadding;

  /// デフォルトスタイルを作成
  static NoteFormFieldStyle defaultStyle(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return NoteFormFieldStyle(
      textStyle: theme.textTheme.bodyLarge,
      labelStyle: theme.textTheme.labelLarge?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 2,
        ),
      ),
      filled: true,
      fillColor: colorScheme.surface,
    );
  }

  /// コンパクトスタイル
  static NoteFormFieldStyle compactStyle(ThemeData theme) {
    final defaultStyle = NoteFormFieldStyle.defaultStyle(theme);
    
    return NoteFormFieldStyle(
      textStyle: defaultStyle.textStyle,
      labelStyle: defaultStyle.labelStyle,
      border: defaultStyle.border,
      enabledBorder: defaultStyle.enabledBorder,
      focusedBorder: defaultStyle.focusedBorder,
      errorBorder: defaultStyle.errorBorder,
      focusedErrorBorder: defaultStyle.focusedErrorBorder,
      filled: defaultStyle.filled,
      fillColor: defaultStyle.fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  /// 詳細編集スタイル
  static NoteFormFieldStyle detailedStyle(ThemeData theme) {
    final defaultStyle = NoteFormFieldStyle.defaultStyle(theme);
    
    return NoteFormFieldStyle(
      textStyle: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
      labelStyle: defaultStyle.labelStyle,
      border: defaultStyle.border,
      enabledBorder: defaultStyle.enabledBorder,
      focusedBorder: defaultStyle.focusedBorder,
      errorBorder: defaultStyle.errorBorder,
      focusedErrorBorder: defaultStyle.focusedErrorBorder,
      filled: defaultStyle.filled,
      fillColor: defaultStyle.fillColor,
      contentPadding: const EdgeInsets.all(20),
    );
  }
}

/// 事前定義されたバリデーター
class NoteFormValidators {
  /// タイトルバリデーター
  static String? titleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'タイトルを入力してください';
    }
    if (value.trim().length > 100) {
      return 'タイトルは100文字以内で入力してください';
    }
    return null;
  }

  /// 内容バリデーター
  static String? contentValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '内容を入力してください';
    }
    if (value.trim().length > 10000) {
      return '内容は10000文字以内で入力してください';
    }
    return null;
  }

  /// 検索クエリバリデーター
  static String? searchValidator(String? value) {
    if (value != null && value.trim().length > 50) {
      return '検索キーワードは50文字以内で入力してください';
    }
    return null;
  }
}

/// 特定用途に特化したフォームフィールド
class NoteTitleField extends StatelessWidget {
  const NoteTitleField({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autofocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return NoteFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'タイトル',
      hintText: 'メモのタイトルを入力',
      maxLength: 100,
      validator: NoteFormValidators.titleValidator,
      autofocus: autofocus,
      enabled: enabled,
      fieldType: NoteFormFieldType.title,
    );
  }
}

/// メモ内容フィールド
class NoteContentField extends StatelessWidget {
  const NoteContentField({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.minLines = 5,
    this.maxLines = 20,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final int minLines;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return NoteFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      labelText: '内容',
      hintText: 'メモの内容を入力してください',
      maxLength: 10000,
      minLines: minLines,
      maxLines: maxLines,
      validator: NoteFormValidators.contentValidator,
      enabled: enabled,
      fieldType: NoteFormFieldType.content,
    );
  }
}

/// 検索フィールド
class NoteSearchField extends StatelessWidget {
  const NoteSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText = 'メモを検索',
    this.autofocus = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String hintText;
  final bool autofocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return NoteFormField(
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      hintText: hintText,
      autofocus: autofocus,
      enabled: enabled,
      fieldType: NoteFormFieldType.search,
      style: NoteFormFieldStyle.compactStyle(Theme.of(context)),
    );
  }
}
