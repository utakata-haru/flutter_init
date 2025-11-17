// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RoutineTableTable extends RoutineTable
    with TableInfo<$RoutineTableTable, RoutineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetHourMeta = const VerificationMeta(
    'targetHour',
  );
  @override
  late final GeneratedColumn<int> targetHour = GeneratedColumn<int>(
    'target_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMinuteMeta = const VerificationMeta(
    'targetMinute',
  );
  @override
  late final GeneratedColumn<int> targetMinute = GeneratedColumn<int>(
    'target_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allowableDelayMinutesMeta =
      const VerificationMeta('allowableDelayMinutes');
  @override
  late final GeneratedColumn<int> allowableDelayMinutes = GeneratedColumn<int>(
    'allowable_delay_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _criticalDelayMinutesMeta =
      const VerificationMeta('criticalDelayMinutes');
  @override
  late final GeneratedColumn<int> criticalDelayMinutes = GeneratedColumn<int>(
    'critical_delay_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _sortIndexMeta = const VerificationMeta(
    'sortIndex',
  );
  @override
  late final GeneratedColumn<int> sortIndex = GeneratedColumn<int>(
    'sort_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastScheduledAtMeta = const VerificationMeta(
    'lastScheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastScheduledAt =
      GeneratedColumn<DateTime>(
        'last_scheduled_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastCompletedAtMeta = const VerificationMeta(
    'lastCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastCompletedAt =
      GeneratedColumn<DateTime>(
        'last_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastDelayMinutesMeta = const VerificationMeta(
    'lastDelayMinutes',
  );
  @override
  late final GeneratedColumn<int> lastDelayMinutes = GeneratedColumn<int>(
    'last_delay_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastStatusMeta = const VerificationMeta(
    'lastStatus',
  );
  @override
  late final GeneratedColumn<String> lastStatus = GeneratedColumn<String>(
    'last_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastEditedMeta = const VerificationMeta(
    'lastEdited',
  );
  @override
  late final GeneratedColumn<bool> lastEdited = GeneratedColumn<bool>(
    'last_edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("last_edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    targetHour,
    targetMinute,
    allowableDelayMinutes,
    criticalDelayMinutes,
    sortIndex,
    lastScheduledAt,
    lastCompletedAt,
    lastDelayMinutes,
    lastStatus,
    lastEdited,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_hour')) {
      context.handle(
        _targetHourMeta,
        targetHour.isAcceptableOrUnknown(data['target_hour']!, _targetHourMeta),
      );
    } else if (isInserting) {
      context.missing(_targetHourMeta);
    }
    if (data.containsKey('target_minute')) {
      context.handle(
        _targetMinuteMeta,
        targetMinute.isAcceptableOrUnknown(
          data['target_minute']!,
          _targetMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetMinuteMeta);
    }
    if (data.containsKey('allowable_delay_minutes')) {
      context.handle(
        _allowableDelayMinutesMeta,
        allowableDelayMinutes.isAcceptableOrUnknown(
          data['allowable_delay_minutes']!,
          _allowableDelayMinutesMeta,
        ),
      );
    }
    if (data.containsKey('critical_delay_minutes')) {
      context.handle(
        _criticalDelayMinutesMeta,
        criticalDelayMinutes.isAcceptableOrUnknown(
          data['critical_delay_minutes']!,
          _criticalDelayMinutesMeta,
        ),
      );
    }
    if (data.containsKey('sort_index')) {
      context.handle(
        _sortIndexMeta,
        sortIndex.isAcceptableOrUnknown(data['sort_index']!, _sortIndexMeta),
      );
    }
    if (data.containsKey('last_scheduled_at')) {
      context.handle(
        _lastScheduledAtMeta,
        lastScheduledAt.isAcceptableOrUnknown(
          data['last_scheduled_at']!,
          _lastScheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('last_completed_at')) {
      context.handle(
        _lastCompletedAtMeta,
        lastCompletedAt.isAcceptableOrUnknown(
          data['last_completed_at']!,
          _lastCompletedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_delay_minutes')) {
      context.handle(
        _lastDelayMinutesMeta,
        lastDelayMinutes.isAcceptableOrUnknown(
          data['last_delay_minutes']!,
          _lastDelayMinutesMeta,
        ),
      );
    }
    if (data.containsKey('last_status')) {
      context.handle(
        _lastStatusMeta,
        lastStatus.isAcceptableOrUnknown(data['last_status']!, _lastStatusMeta),
      );
    }
    if (data.containsKey('last_edited')) {
      context.handle(
        _lastEditedMeta,
        lastEdited.isAcceptableOrUnknown(data['last_edited']!, _lastEditedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_hour'],
      )!,
      targetMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_minute'],
      )!,
      allowableDelayMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allowable_delay_minutes'],
      )!,
      criticalDelayMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}critical_delay_minutes'],
      )!,
      sortIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_index'],
      )!,
      lastScheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_scheduled_at'],
      ),
      lastCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_completed_at'],
      ),
      lastDelayMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_delay_minutes'],
      ),
      lastStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_status'],
      ),
      lastEdited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}last_edited'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutineTableTable createAlias(String alias) {
    return $RoutineTableTable(attachedDatabase, alias);
  }
}

class RoutineTableData extends DataClass
    implements Insertable<RoutineTableData> {
  final String id;
  final String name;
  final int targetHour;
  final int targetMinute;
  final int allowableDelayMinutes;
  final int criticalDelayMinutes;
  final int sortIndex;
  final DateTime? lastScheduledAt;
  final DateTime? lastCompletedAt;
  final int? lastDelayMinutes;
  final String? lastStatus;
  final bool lastEdited;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RoutineTableData({
    required this.id,
    required this.name,
    required this.targetHour,
    required this.targetMinute,
    required this.allowableDelayMinutes,
    required this.criticalDelayMinutes,
    required this.sortIndex,
    this.lastScheduledAt,
    this.lastCompletedAt,
    this.lastDelayMinutes,
    this.lastStatus,
    required this.lastEdited,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_hour'] = Variable<int>(targetHour);
    map['target_minute'] = Variable<int>(targetMinute);
    map['allowable_delay_minutes'] = Variable<int>(allowableDelayMinutes);
    map['critical_delay_minutes'] = Variable<int>(criticalDelayMinutes);
    map['sort_index'] = Variable<int>(sortIndex);
    if (!nullToAbsent || lastScheduledAt != null) {
      map['last_scheduled_at'] = Variable<DateTime>(lastScheduledAt);
    }
    if (!nullToAbsent || lastCompletedAt != null) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt);
    }
    if (!nullToAbsent || lastDelayMinutes != null) {
      map['last_delay_minutes'] = Variable<int>(lastDelayMinutes);
    }
    if (!nullToAbsent || lastStatus != null) {
      map['last_status'] = Variable<String>(lastStatus);
    }
    map['last_edited'] = Variable<bool>(lastEdited);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutineTableCompanion toCompanion(bool nullToAbsent) {
    return RoutineTableCompanion(
      id: Value(id),
      name: Value(name),
      targetHour: Value(targetHour),
      targetMinute: Value(targetMinute),
      allowableDelayMinutes: Value(allowableDelayMinutes),
      criticalDelayMinutes: Value(criticalDelayMinutes),
      sortIndex: Value(sortIndex),
      lastScheduledAt: lastScheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScheduledAt),
      lastCompletedAt: lastCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCompletedAt),
      lastDelayMinutes: lastDelayMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDelayMinutes),
      lastStatus: lastStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStatus),
      lastEdited: Value(lastEdited),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RoutineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetHour: serializer.fromJson<int>(json['targetHour']),
      targetMinute: serializer.fromJson<int>(json['targetMinute']),
      allowableDelayMinutes: serializer.fromJson<int>(
        json['allowableDelayMinutes'],
      ),
      criticalDelayMinutes: serializer.fromJson<int>(
        json['criticalDelayMinutes'],
      ),
      sortIndex: serializer.fromJson<int>(json['sortIndex']),
      lastScheduledAt: serializer.fromJson<DateTime?>(json['lastScheduledAt']),
      lastCompletedAt: serializer.fromJson<DateTime?>(json['lastCompletedAt']),
      lastDelayMinutes: serializer.fromJson<int?>(json['lastDelayMinutes']),
      lastStatus: serializer.fromJson<String?>(json['lastStatus']),
      lastEdited: serializer.fromJson<bool>(json['lastEdited']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetHour': serializer.toJson<int>(targetHour),
      'targetMinute': serializer.toJson<int>(targetMinute),
      'allowableDelayMinutes': serializer.toJson<int>(allowableDelayMinutes),
      'criticalDelayMinutes': serializer.toJson<int>(criticalDelayMinutes),
      'sortIndex': serializer.toJson<int>(sortIndex),
      'lastScheduledAt': serializer.toJson<DateTime?>(lastScheduledAt),
      'lastCompletedAt': serializer.toJson<DateTime?>(lastCompletedAt),
      'lastDelayMinutes': serializer.toJson<int?>(lastDelayMinutes),
      'lastStatus': serializer.toJson<String?>(lastStatus),
      'lastEdited': serializer.toJson<bool>(lastEdited),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RoutineTableData copyWith({
    String? id,
    String? name,
    int? targetHour,
    int? targetMinute,
    int? allowableDelayMinutes,
    int? criticalDelayMinutes,
    int? sortIndex,
    Value<DateTime?> lastScheduledAt = const Value.absent(),
    Value<DateTime?> lastCompletedAt = const Value.absent(),
    Value<int?> lastDelayMinutes = const Value.absent(),
    Value<String?> lastStatus = const Value.absent(),
    bool? lastEdited,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RoutineTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    targetHour: targetHour ?? this.targetHour,
    targetMinute: targetMinute ?? this.targetMinute,
    allowableDelayMinutes: allowableDelayMinutes ?? this.allowableDelayMinutes,
    criticalDelayMinutes: criticalDelayMinutes ?? this.criticalDelayMinutes,
    sortIndex: sortIndex ?? this.sortIndex,
    lastScheduledAt: lastScheduledAt.present
        ? lastScheduledAt.value
        : this.lastScheduledAt,
    lastCompletedAt: lastCompletedAt.present
        ? lastCompletedAt.value
        : this.lastCompletedAt,
    lastDelayMinutes: lastDelayMinutes.present
        ? lastDelayMinutes.value
        : this.lastDelayMinutes,
    lastStatus: lastStatus.present ? lastStatus.value : this.lastStatus,
    lastEdited: lastEdited ?? this.lastEdited,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RoutineTableData copyWithCompanion(RoutineTableCompanion data) {
    return RoutineTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetHour: data.targetHour.present
          ? data.targetHour.value
          : this.targetHour,
      targetMinute: data.targetMinute.present
          ? data.targetMinute.value
          : this.targetMinute,
      allowableDelayMinutes: data.allowableDelayMinutes.present
          ? data.allowableDelayMinutes.value
          : this.allowableDelayMinutes,
      criticalDelayMinutes: data.criticalDelayMinutes.present
          ? data.criticalDelayMinutes.value
          : this.criticalDelayMinutes,
      sortIndex: data.sortIndex.present ? data.sortIndex.value : this.sortIndex,
      lastScheduledAt: data.lastScheduledAt.present
          ? data.lastScheduledAt.value
          : this.lastScheduledAt,
      lastCompletedAt: data.lastCompletedAt.present
          ? data.lastCompletedAt.value
          : this.lastCompletedAt,
      lastDelayMinutes: data.lastDelayMinutes.present
          ? data.lastDelayMinutes.value
          : this.lastDelayMinutes,
      lastStatus: data.lastStatus.present
          ? data.lastStatus.value
          : this.lastStatus,
      lastEdited: data.lastEdited.present
          ? data.lastEdited.value
          : this.lastEdited,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetHour: $targetHour, ')
          ..write('targetMinute: $targetMinute, ')
          ..write('allowableDelayMinutes: $allowableDelayMinutes, ')
          ..write('criticalDelayMinutes: $criticalDelayMinutes, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('lastScheduledAt: $lastScheduledAt, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('lastDelayMinutes: $lastDelayMinutes, ')
          ..write('lastStatus: $lastStatus, ')
          ..write('lastEdited: $lastEdited, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    targetHour,
    targetMinute,
    allowableDelayMinutes,
    criticalDelayMinutes,
    sortIndex,
    lastScheduledAt,
    lastCompletedAt,
    lastDelayMinutes,
    lastStatus,
    lastEdited,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetHour == this.targetHour &&
          other.targetMinute == this.targetMinute &&
          other.allowableDelayMinutes == this.allowableDelayMinutes &&
          other.criticalDelayMinutes == this.criticalDelayMinutes &&
          other.sortIndex == this.sortIndex &&
          other.lastScheduledAt == this.lastScheduledAt &&
          other.lastCompletedAt == this.lastCompletedAt &&
          other.lastDelayMinutes == this.lastDelayMinutes &&
          other.lastStatus == this.lastStatus &&
          other.lastEdited == this.lastEdited &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutineTableCompanion extends UpdateCompanion<RoutineTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> targetHour;
  final Value<int> targetMinute;
  final Value<int> allowableDelayMinutes;
  final Value<int> criticalDelayMinutes;
  final Value<int> sortIndex;
  final Value<DateTime?> lastScheduledAt;
  final Value<DateTime?> lastCompletedAt;
  final Value<int?> lastDelayMinutes;
  final Value<String?> lastStatus;
  final Value<bool> lastEdited;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RoutineTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetHour = const Value.absent(),
    this.targetMinute = const Value.absent(),
    this.allowableDelayMinutes = const Value.absent(),
    this.criticalDelayMinutes = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.lastScheduledAt = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.lastDelayMinutes = const Value.absent(),
    this.lastStatus = const Value.absent(),
    this.lastEdited = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineTableCompanion.insert({
    required String id,
    required String name,
    required int targetHour,
    required int targetMinute,
    this.allowableDelayMinutes = const Value.absent(),
    this.criticalDelayMinutes = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.lastScheduledAt = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.lastDelayMinutes = const Value.absent(),
    this.lastStatus = const Value.absent(),
    this.lastEdited = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       targetHour = Value(targetHour),
       targetMinute = Value(targetMinute);
  static Insertable<RoutineTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? targetHour,
    Expression<int>? targetMinute,
    Expression<int>? allowableDelayMinutes,
    Expression<int>? criticalDelayMinutes,
    Expression<int>? sortIndex,
    Expression<DateTime>? lastScheduledAt,
    Expression<DateTime>? lastCompletedAt,
    Expression<int>? lastDelayMinutes,
    Expression<String>? lastStatus,
    Expression<bool>? lastEdited,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetHour != null) 'target_hour': targetHour,
      if (targetMinute != null) 'target_minute': targetMinute,
      if (allowableDelayMinutes != null)
        'allowable_delay_minutes': allowableDelayMinutes,
      if (criticalDelayMinutes != null)
        'critical_delay_minutes': criticalDelayMinutes,
      if (sortIndex != null) 'sort_index': sortIndex,
      if (lastScheduledAt != null) 'last_scheduled_at': lastScheduledAt,
      if (lastCompletedAt != null) 'last_completed_at': lastCompletedAt,
      if (lastDelayMinutes != null) 'last_delay_minutes': lastDelayMinutes,
      if (lastStatus != null) 'last_status': lastStatus,
      if (lastEdited != null) 'last_edited': lastEdited,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? targetHour,
    Value<int>? targetMinute,
    Value<int>? allowableDelayMinutes,
    Value<int>? criticalDelayMinutes,
    Value<int>? sortIndex,
    Value<DateTime?>? lastScheduledAt,
    Value<DateTime?>? lastCompletedAt,
    Value<int?>? lastDelayMinutes,
    Value<String?>? lastStatus,
    Value<bool>? lastEdited,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RoutineTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetHour: targetHour ?? this.targetHour,
      targetMinute: targetMinute ?? this.targetMinute,
      allowableDelayMinutes:
          allowableDelayMinutes ?? this.allowableDelayMinutes,
      criticalDelayMinutes: criticalDelayMinutes ?? this.criticalDelayMinutes,
      sortIndex: sortIndex ?? this.sortIndex,
      lastScheduledAt: lastScheduledAt ?? this.lastScheduledAt,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      lastDelayMinutes: lastDelayMinutes ?? this.lastDelayMinutes,
      lastStatus: lastStatus ?? this.lastStatus,
      lastEdited: lastEdited ?? this.lastEdited,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetHour.present) {
      map['target_hour'] = Variable<int>(targetHour.value);
    }
    if (targetMinute.present) {
      map['target_minute'] = Variable<int>(targetMinute.value);
    }
    if (allowableDelayMinutes.present) {
      map['allowable_delay_minutes'] = Variable<int>(
        allowableDelayMinutes.value,
      );
    }
    if (criticalDelayMinutes.present) {
      map['critical_delay_minutes'] = Variable<int>(criticalDelayMinutes.value);
    }
    if (sortIndex.present) {
      map['sort_index'] = Variable<int>(sortIndex.value);
    }
    if (lastScheduledAt.present) {
      map['last_scheduled_at'] = Variable<DateTime>(lastScheduledAt.value);
    }
    if (lastCompletedAt.present) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt.value);
    }
    if (lastDelayMinutes.present) {
      map['last_delay_minutes'] = Variable<int>(lastDelayMinutes.value);
    }
    if (lastStatus.present) {
      map['last_status'] = Variable<String>(lastStatus.value);
    }
    if (lastEdited.present) {
      map['last_edited'] = Variable<bool>(lastEdited.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetHour: $targetHour, ')
          ..write('targetMinute: $targetMinute, ')
          ..write('allowableDelayMinutes: $allowableDelayMinutes, ')
          ..write('criticalDelayMinutes: $criticalDelayMinutes, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('lastScheduledAt: $lastScheduledAt, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('lastDelayMinutes: $lastDelayMinutes, ')
          ..write('lastStatus: $lastStatus, ')
          ..write('lastEdited: $lastEdited, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutineSettingsTableTable extends RoutineSettingsTable
    with TableInfo<$RoutineSettingsTableTable, RoutineSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allowableDelayMinutesMeta =
      const VerificationMeta('allowableDelayMinutes');
  @override
  late final GeneratedColumn<int> allowableDelayMinutes = GeneratedColumn<int>(
    'allowable_delay_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _criticalDelayMinutesMeta =
      const VerificationMeta('criticalDelayMinutes');
  @override
  late final GeneratedColumn<int> criticalDelayMinutes = GeneratedColumn<int>(
    'critical_delay_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    allowableDelayMinutes,
    criticalDelayMinutes,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('allowable_delay_minutes')) {
      context.handle(
        _allowableDelayMinutesMeta,
        allowableDelayMinutes.isAcceptableOrUnknown(
          data['allowable_delay_minutes']!,
          _allowableDelayMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allowableDelayMinutesMeta);
    }
    if (data.containsKey('critical_delay_minutes')) {
      context.handle(
        _criticalDelayMinutesMeta,
        criticalDelayMinutes.isAcceptableOrUnknown(
          data['critical_delay_minutes']!,
          _criticalDelayMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_criticalDelayMinutesMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineSettingsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      allowableDelayMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allowable_delay_minutes'],
      )!,
      criticalDelayMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}critical_delay_minutes'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutineSettingsTableTable createAlias(String alias) {
    return $RoutineSettingsTableTable(attachedDatabase, alias);
  }
}

class RoutineSettingsTableData extends DataClass
    implements Insertable<RoutineSettingsTableData> {
  final String id;
  final int allowableDelayMinutes;
  final int criticalDelayMinutes;
  final DateTime updatedAt;
  const RoutineSettingsTableData({
    required this.id,
    required this.allowableDelayMinutes,
    required this.criticalDelayMinutes,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['allowable_delay_minutes'] = Variable<int>(allowableDelayMinutes);
    map['critical_delay_minutes'] = Variable<int>(criticalDelayMinutes);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutineSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return RoutineSettingsTableCompanion(
      id: Value(id),
      allowableDelayMinutes: Value(allowableDelayMinutes),
      criticalDelayMinutes: Value(criticalDelayMinutes),
      updatedAt: Value(updatedAt),
    );
  }

  factory RoutineSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineSettingsTableData(
      id: serializer.fromJson<String>(json['id']),
      allowableDelayMinutes: serializer.fromJson<int>(
        json['allowableDelayMinutes'],
      ),
      criticalDelayMinutes: serializer.fromJson<int>(
        json['criticalDelayMinutes'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'allowableDelayMinutes': serializer.toJson<int>(allowableDelayMinutes),
      'criticalDelayMinutes': serializer.toJson<int>(criticalDelayMinutes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RoutineSettingsTableData copyWith({
    String? id,
    int? allowableDelayMinutes,
    int? criticalDelayMinutes,
    DateTime? updatedAt,
  }) => RoutineSettingsTableData(
    id: id ?? this.id,
    allowableDelayMinutes: allowableDelayMinutes ?? this.allowableDelayMinutes,
    criticalDelayMinutes: criticalDelayMinutes ?? this.criticalDelayMinutes,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RoutineSettingsTableData copyWithCompanion(
    RoutineSettingsTableCompanion data,
  ) {
    return RoutineSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      allowableDelayMinutes: data.allowableDelayMinutes.present
          ? data.allowableDelayMinutes.value
          : this.allowableDelayMinutes,
      criticalDelayMinutes: data.criticalDelayMinutes.present
          ? data.criticalDelayMinutes.value
          : this.criticalDelayMinutes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineSettingsTableData(')
          ..write('id: $id, ')
          ..write('allowableDelayMinutes: $allowableDelayMinutes, ')
          ..write('criticalDelayMinutes: $criticalDelayMinutes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, allowableDelayMinutes, criticalDelayMinutes, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineSettingsTableData &&
          other.id == this.id &&
          other.allowableDelayMinutes == this.allowableDelayMinutes &&
          other.criticalDelayMinutes == this.criticalDelayMinutes &&
          other.updatedAt == this.updatedAt);
}

class RoutineSettingsTableCompanion
    extends UpdateCompanion<RoutineSettingsTableData> {
  final Value<String> id;
  final Value<int> allowableDelayMinutes;
  final Value<int> criticalDelayMinutes;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RoutineSettingsTableCompanion({
    this.id = const Value.absent(),
    this.allowableDelayMinutes = const Value.absent(),
    this.criticalDelayMinutes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineSettingsTableCompanion.insert({
    required String id,
    required int allowableDelayMinutes,
    required int criticalDelayMinutes,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       allowableDelayMinutes = Value(allowableDelayMinutes),
       criticalDelayMinutes = Value(criticalDelayMinutes);
  static Insertable<RoutineSettingsTableData> custom({
    Expression<String>? id,
    Expression<int>? allowableDelayMinutes,
    Expression<int>? criticalDelayMinutes,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (allowableDelayMinutes != null)
        'allowable_delay_minutes': allowableDelayMinutes,
      if (criticalDelayMinutes != null)
        'critical_delay_minutes': criticalDelayMinutes,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<int>? allowableDelayMinutes,
    Value<int>? criticalDelayMinutes,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RoutineSettingsTableCompanion(
      id: id ?? this.id,
      allowableDelayMinutes:
          allowableDelayMinutes ?? this.allowableDelayMinutes,
      criticalDelayMinutes: criticalDelayMinutes ?? this.criticalDelayMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (allowableDelayMinutes.present) {
      map['allowable_delay_minutes'] = Variable<int>(
        allowableDelayMinutes.value,
      );
    }
    if (criticalDelayMinutes.present) {
      map['critical_delay_minutes'] = Variable<int>(criticalDelayMinutes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('allowableDelayMinutes: $allowableDelayMinutes, ')
          ..write('criticalDelayMinutes: $criticalDelayMinutes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutineTableTable routineTable = $RoutineTableTable(this);
  late final $RoutineSettingsTableTable routineSettingsTable =
      $RoutineSettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    routineTable,
    routineSettingsTable,
  ];
}

typedef $$RoutineTableTableCreateCompanionBuilder =
    RoutineTableCompanion Function({
      required String id,
      required String name,
      required int targetHour,
      required int targetMinute,
      Value<int> allowableDelayMinutes,
      Value<int> criticalDelayMinutes,
      Value<int> sortIndex,
      Value<DateTime?> lastScheduledAt,
      Value<DateTime?> lastCompletedAt,
      Value<int?> lastDelayMinutes,
      Value<String?> lastStatus,
      Value<bool> lastEdited,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$RoutineTableTableUpdateCompanionBuilder =
    RoutineTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> targetHour,
      Value<int> targetMinute,
      Value<int> allowableDelayMinutes,
      Value<int> criticalDelayMinutes,
      Value<int> sortIndex,
      Value<DateTime?> lastScheduledAt,
      Value<DateTime?> lastCompletedAt,
      Value<int?> lastDelayMinutes,
      Value<String?> lastStatus,
      Value<bool> lastEdited,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RoutineTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetHour => $composableBuilder(
    column: $table.targetHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMinute => $composableBuilder(
    column: $table.targetMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get allowableDelayMinutes => $composableBuilder(
    column: $table.allowableDelayMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get criticalDelayMinutes => $composableBuilder(
    column: $table.criticalDelayMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastScheduledAt => $composableBuilder(
    column: $table.lastScheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastDelayMinutes => $composableBuilder(
    column: $table.lastDelayMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lastEdited => $composableBuilder(
    column: $table.lastEdited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetHour => $composableBuilder(
    column: $table.targetHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMinute => $composableBuilder(
    column: $table.targetMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get allowableDelayMinutes => $composableBuilder(
    column: $table.allowableDelayMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get criticalDelayMinutes => $composableBuilder(
    column: $table.criticalDelayMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastScheduledAt => $composableBuilder(
    column: $table.lastScheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastDelayMinutes => $composableBuilder(
    column: $table.lastDelayMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lastEdited => $composableBuilder(
    column: $table.lastEdited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get targetHour => $composableBuilder(
    column: $table.targetHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetMinute => $composableBuilder(
    column: $table.targetMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get allowableDelayMinutes => $composableBuilder(
    column: $table.allowableDelayMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get criticalDelayMinutes => $composableBuilder(
    column: $table.criticalDelayMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortIndex =>
      $composableBuilder(column: $table.sortIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get lastScheduledAt => $composableBuilder(
    column: $table.lastScheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastDelayMinutes => $composableBuilder(
    column: $table.lastDelayMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lastEdited => $composableBuilder(
    column: $table.lastEdited,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RoutineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineTableTable,
          RoutineTableData,
          $$RoutineTableTableFilterComposer,
          $$RoutineTableTableOrderingComposer,
          $$RoutineTableTableAnnotationComposer,
          $$RoutineTableTableCreateCompanionBuilder,
          $$RoutineTableTableUpdateCompanionBuilder,
          (
            RoutineTableData,
            BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTableData>,
          ),
          RoutineTableData,
          PrefetchHooks Function()
        > {
  $$RoutineTableTableTableManager(_$AppDatabase db, $RoutineTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> targetHour = const Value.absent(),
                Value<int> targetMinute = const Value.absent(),
                Value<int> allowableDelayMinutes = const Value.absent(),
                Value<int> criticalDelayMinutes = const Value.absent(),
                Value<int> sortIndex = const Value.absent(),
                Value<DateTime?> lastScheduledAt = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<int?> lastDelayMinutes = const Value.absent(),
                Value<String?> lastStatus = const Value.absent(),
                Value<bool> lastEdited = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineTableCompanion(
                id: id,
                name: name,
                targetHour: targetHour,
                targetMinute: targetMinute,
                allowableDelayMinutes: allowableDelayMinutes,
                criticalDelayMinutes: criticalDelayMinutes,
                sortIndex: sortIndex,
                lastScheduledAt: lastScheduledAt,
                lastCompletedAt: lastCompletedAt,
                lastDelayMinutes: lastDelayMinutes,
                lastStatus: lastStatus,
                lastEdited: lastEdited,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int targetHour,
                required int targetMinute,
                Value<int> allowableDelayMinutes = const Value.absent(),
                Value<int> criticalDelayMinutes = const Value.absent(),
                Value<int> sortIndex = const Value.absent(),
                Value<DateTime?> lastScheduledAt = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<int?> lastDelayMinutes = const Value.absent(),
                Value<String?> lastStatus = const Value.absent(),
                Value<bool> lastEdited = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineTableCompanion.insert(
                id: id,
                name: name,
                targetHour: targetHour,
                targetMinute: targetMinute,
                allowableDelayMinutes: allowableDelayMinutes,
                criticalDelayMinutes: criticalDelayMinutes,
                sortIndex: sortIndex,
                lastScheduledAt: lastScheduledAt,
                lastCompletedAt: lastCompletedAt,
                lastDelayMinutes: lastDelayMinutes,
                lastStatus: lastStatus,
                lastEdited: lastEdited,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineTableTable,
      RoutineTableData,
      $$RoutineTableTableFilterComposer,
      $$RoutineTableTableOrderingComposer,
      $$RoutineTableTableAnnotationComposer,
      $$RoutineTableTableCreateCompanionBuilder,
      $$RoutineTableTableUpdateCompanionBuilder,
      (
        RoutineTableData,
        BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTableData>,
      ),
      RoutineTableData,
      PrefetchHooks Function()
    >;
typedef $$RoutineSettingsTableTableCreateCompanionBuilder =
    RoutineSettingsTableCompanion Function({
      required String id,
      required int allowableDelayMinutes,
      required int criticalDelayMinutes,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$RoutineSettingsTableTableUpdateCompanionBuilder =
    RoutineSettingsTableCompanion Function({
      Value<String> id,
      Value<int> allowableDelayMinutes,
      Value<int> criticalDelayMinutes,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RoutineSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineSettingsTableTable> {
  $$RoutineSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get allowableDelayMinutes => $composableBuilder(
    column: $table.allowableDelayMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get criticalDelayMinutes => $composableBuilder(
    column: $table.criticalDelayMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineSettingsTableTable> {
  $$RoutineSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get allowableDelayMinutes => $composableBuilder(
    column: $table.allowableDelayMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get criticalDelayMinutes => $composableBuilder(
    column: $table.criticalDelayMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineSettingsTableTable> {
  $$RoutineSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get allowableDelayMinutes => $composableBuilder(
    column: $table.allowableDelayMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get criticalDelayMinutes => $composableBuilder(
    column: $table.criticalDelayMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RoutineSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineSettingsTableTable,
          RoutineSettingsTableData,
          $$RoutineSettingsTableTableFilterComposer,
          $$RoutineSettingsTableTableOrderingComposer,
          $$RoutineSettingsTableTableAnnotationComposer,
          $$RoutineSettingsTableTableCreateCompanionBuilder,
          $$RoutineSettingsTableTableUpdateCompanionBuilder,
          (
            RoutineSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $RoutineSettingsTableTable,
              RoutineSettingsTableData
            >,
          ),
          RoutineSettingsTableData,
          PrefetchHooks Function()
        > {
  $$RoutineSettingsTableTableTableManager(
    _$AppDatabase db,
    $RoutineSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RoutineSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> allowableDelayMinutes = const Value.absent(),
                Value<int> criticalDelayMinutes = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineSettingsTableCompanion(
                id: id,
                allowableDelayMinutes: allowableDelayMinutes,
                criticalDelayMinutes: criticalDelayMinutes,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int allowableDelayMinutes,
                required int criticalDelayMinutes,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineSettingsTableCompanion.insert(
                id: id,
                allowableDelayMinutes: allowableDelayMinutes,
                criticalDelayMinutes: criticalDelayMinutes,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineSettingsTableTable,
      RoutineSettingsTableData,
      $$RoutineSettingsTableTableFilterComposer,
      $$RoutineSettingsTableTableOrderingComposer,
      $$RoutineSettingsTableTableAnnotationComposer,
      $$RoutineSettingsTableTableCreateCompanionBuilder,
      $$RoutineSettingsTableTableUpdateCompanionBuilder,
      (
        RoutineSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $RoutineSettingsTableTable,
          RoutineSettingsTableData
        >,
      ),
      RoutineSettingsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutineTableTableTableManager get routineTable =>
      $$RoutineTableTableTableManager(_db, _db.routineTable);
  $$RoutineSettingsTableTableTableManager get routineSettingsTable =>
      $$RoutineSettingsTableTableTableManager(_db, _db.routineSettingsTable);
}
