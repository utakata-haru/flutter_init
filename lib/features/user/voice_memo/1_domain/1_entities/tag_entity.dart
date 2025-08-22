// ドメイン層: タグのエンティティ（MVP仕様に準拠）
// ユニークな name を想定。id は将来の拡張や参照のために保持。

class Tag {
  final String id;
  final String name;

  // 変更不可能な値オブジェクトとして定義
  const Tag({
    required this.id,
    required this.name,
  });

  // 値の複製（部分更新）
  Tag copyWith({
    String? id,
    String? name,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'Tag(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tag && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}