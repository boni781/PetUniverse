// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppUsersTable extends AppUsers with TableInfo<$AppUsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    email,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
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
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  final String id;
  final String displayName;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppUser({
    required this.id,
    required this.displayName,
    this.email,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      id: Value(id),
      displayName: Value(displayName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      email: serializer.fromJson<String?>(json['email']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'email': serializer.toJson<String?>(email),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppUser copyWith({
    String? id,
    String? displayName,
    Value<String?> email = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppUser(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    email: email.present ? email.value : this.email,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppUser copyWithCompanion(AppUsersCompanion data) {
    return AppUser(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      email: data.email.present ? data.email.value : this.email,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, displayName, email, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.email == this.email &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppUsersCompanion extends UpdateCompanion<AppUser> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String?> email;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppUsersCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.email = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsersCompanion.insert({
    required String id,
    required String displayName,
    this.email = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppUser> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? email,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (email != null) 'email': email,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsersCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String?>? email,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppUsersCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
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
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
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
    return (StringBuffer('AppUsersCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkspacesTable extends Workspaces
    with TableInfo<$WorkspacesTable, Workspace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceTypeMeta = const VerificationMeta(
    'workspaceType',
  );
  @override
  late final GeneratedColumn<String> workspaceType = GeneratedColumn<String>(
    'workspace_type',
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByUserIdMeta = const VerificationMeta(
    'createdByUserId',
  );
  @override
  late final GeneratedColumn<String> createdByUserId = GeneratedColumn<String>(
    'created_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_users (id)',
    ),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceType,
    name,
    createdByUserId,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspaces';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workspace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_type')) {
      context.handle(
        _workspaceTypeMeta,
        workspaceType.isAcceptableOrUnknown(
          data['workspace_type']!,
          _workspaceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceTypeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
        _createdByUserIdMeta,
        createdByUserId.isAcceptableOrUnknown(
          data['created_by_user_id']!,
          _createdByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdByUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workspace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workspace(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by_user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $WorkspacesTable createAlias(String alias) {
    return $WorkspacesTable(attachedDatabase, alias);
  }
}

class Workspace extends DataClass implements Insertable<Workspace> {
  final String id;
  final String workspaceType;
  final String name;
  final String createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Workspace({
    required this.id,
    required this.workspaceType,
    required this.name,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_type'] = Variable<String>(workspaceType);
    map['name'] = Variable<String>(name);
    map['created_by_user_id'] = Variable<String>(createdByUserId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  WorkspacesCompanion toCompanion(bool nullToAbsent) {
    return WorkspacesCompanion(
      id: Value(id),
      workspaceType: Value(workspaceType),
      name: Value(name),
      createdByUserId: Value(createdByUserId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Workspace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workspace(
      id: serializer.fromJson<String>(json['id']),
      workspaceType: serializer.fromJson<String>(json['workspaceType']),
      name: serializer.fromJson<String>(json['name']),
      createdByUserId: serializer.fromJson<String>(json['createdByUserId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceType': serializer.toJson<String>(workspaceType),
      'name': serializer.toJson<String>(name),
      'createdByUserId': serializer.toJson<String>(createdByUserId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Workspace copyWith({
    String? id,
    String? workspaceType,
    String? name,
    String? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Workspace(
    id: id ?? this.id,
    workspaceType: workspaceType ?? this.workspaceType,
    name: name ?? this.name,
    createdByUserId: createdByUserId ?? this.createdByUserId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Workspace copyWithCompanion(WorkspacesCompanion data) {
    return Workspace(
      id: data.id.present ? data.id.value : this.id,
      workspaceType: data.workspaceType.present
          ? data.workspaceType.value
          : this.workspaceType,
      name: data.name.present ? data.name.value : this.name,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workspace(')
          ..write('id: $id, ')
          ..write('workspaceType: $workspaceType, ')
          ..write('name: $name, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceType,
    name,
    createdByUserId,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workspace &&
          other.id == this.id &&
          other.workspaceType == this.workspaceType &&
          other.name == this.name &&
          other.createdByUserId == this.createdByUserId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class WorkspacesCompanion extends UpdateCompanion<Workspace> {
  final Value<String> id;
  final Value<String> workspaceType;
  final Value<String> name;
  final Value<String> createdByUserId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const WorkspacesCompanion({
    this.id = const Value.absent(),
    this.workspaceType = const Value.absent(),
    this.name = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspacesCompanion.insert({
    required String id,
    required String workspaceType,
    required String name,
    required String createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceType = Value(workspaceType),
       name = Value(name),
       createdByUserId = Value(createdByUserId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Workspace> custom({
    Expression<String>? id,
    Expression<String>? workspaceType,
    Expression<String>? name,
    Expression<String>? createdByUserId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceType != null) 'workspace_type': workspaceType,
      if (name != null) 'name': name,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspacesCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceType,
    Value<String>? name,
    Value<String>? createdByUserId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return WorkspacesCompanion(
      id: id ?? this.id,
      workspaceType: workspaceType ?? this.workspaceType,
      name: name ?? this.name,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceType.present) {
      map['workspace_type'] = Variable<String>(workspaceType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<String>(createdByUserId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkspacesCompanion(')
          ..write('id: $id, ')
          ..write('workspaceType: $workspaceType, ')
          ..write('name: $name, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkspaceMembershipsTable extends WorkspaceMemberships
    with TableInfo<$WorkspaceMembershipsTable, WorkspaceMembership> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspaceMembershipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_users (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _membershipStatusMeta = const VerificationMeta(
    'membershipStatus',
  );
  @override
  late final GeneratedColumn<String> membershipStatus = GeneratedColumn<String>(
    'membership_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    userId,
    role,
    membershipStatus,
    joinedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspace_memberships';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkspaceMembership> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('membership_status')) {
      context.handle(
        _membershipStatusMeta,
        membershipStatus.isAcceptableOrUnknown(
          data['membership_status']!,
          _membershipStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_membershipStatusMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkspaceMembership map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkspaceMembership(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      membershipStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}membership_status'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      ),
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
  $WorkspaceMembershipsTable createAlias(String alias) {
    return $WorkspaceMembershipsTable(attachedDatabase, alias);
  }
}

class WorkspaceMembership extends DataClass
    implements Insertable<WorkspaceMembership> {
  final String id;
  final String workspaceId;
  final String userId;
  final String role;
  final String membershipStatus;
  final DateTime? joinedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkspaceMembership({
    required this.id,
    required this.workspaceId,
    required this.userId,
    required this.role,
    required this.membershipStatus,
    this.joinedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['membership_status'] = Variable<String>(membershipStatus);
    if (!nullToAbsent || joinedAt != null) {
      map['joined_at'] = Variable<DateTime>(joinedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkspaceMembershipsCompanion toCompanion(bool nullToAbsent) {
    return WorkspaceMembershipsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      userId: Value(userId),
      role: Value(role),
      membershipStatus: Value(membershipStatus),
      joinedAt: joinedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(joinedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkspaceMembership.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkspaceMembership(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      membershipStatus: serializer.fromJson<String>(json['membershipStatus']),
      joinedAt: serializer.fromJson<DateTime?>(json['joinedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'membershipStatus': serializer.toJson<String>(membershipStatus),
      'joinedAt': serializer.toJson<DateTime?>(joinedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkspaceMembership copyWith({
    String? id,
    String? workspaceId,
    String? userId,
    String? role,
    String? membershipStatus,
    Value<DateTime?> joinedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkspaceMembership(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    membershipStatus: membershipStatus ?? this.membershipStatus,
    joinedAt: joinedAt.present ? joinedAt.value : this.joinedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkspaceMembership copyWithCompanion(WorkspaceMembershipsCompanion data) {
    return WorkspaceMembership(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      membershipStatus: data.membershipStatus.present
          ? data.membershipStatus.value
          : this.membershipStatus,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkspaceMembership(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('membershipStatus: $membershipStatus, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    userId,
    role,
    membershipStatus,
    joinedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceMembership &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.membershipStatus == this.membershipStatus &&
          other.joinedAt == this.joinedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkspaceMembershipsCompanion
    extends UpdateCompanion<WorkspaceMembership> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> userId;
  final Value<String> role;
  final Value<String> membershipStatus;
  final Value<DateTime?> joinedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkspaceMembershipsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.membershipStatus = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspaceMembershipsCompanion.insert({
    required String id,
    required String workspaceId,
    required String userId,
    required String role,
    required String membershipStatus,
    this.joinedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       userId = Value(userId),
       role = Value(role),
       membershipStatus = Value(membershipStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkspaceMembership> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<String>? membershipStatus,
    Expression<DateTime>? joinedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (membershipStatus != null) 'membership_status': membershipStatus,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspaceMembershipsCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? userId,
    Value<String>? role,
    Value<String>? membershipStatus,
    Value<DateTime?>? joinedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WorkspaceMembershipsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      joinedAt: joinedAt ?? this.joinedAt,
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
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (membershipStatus.present) {
      map['membership_status'] = Variable<String>(membershipStatus.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
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
    return (StringBuffer('WorkspaceMembershipsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('membershipStatus: $membershipStatus, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpeciesTable extends Species with TableInfo<$SpeciesTable, SpeciesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _taxonomicRankMeta = const VerificationMeta(
    'taxonomicRank',
  );
  @override
  late final GeneratedColumn<String> taxonomicRank = GeneratedColumn<String>(
    'taxonomic_rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scientificNameMeta = const VerificationMeta(
    'scientificName',
  );
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commonNameMeta = const VerificationMeta(
    'commonName',
  );
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
    'common_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryKeyMeta = const VerificationMeta(
    'categoryKey',
  );
  @override
  late final GeneratedColumn<String> categoryKey = GeneratedColumn<String>(
    'category_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentTaxonIdMeta = const VerificationMeta(
    'parentTaxonId',
  );
  @override
  late final GeneratedColumn<String> parentTaxonId = GeneratedColumn<String>(
    'parent_taxon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _catalogStatusMeta = const VerificationMeta(
    'catalogStatus',
  );
  @override
  late final GeneratedColumn<String> catalogStatus = GeneratedColumn<String>(
    'catalog_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    origin,
    workspaceId,
    taxonomicRank,
    scientificName,
    commonName,
    categoryKey,
    parentTaxonId,
    catalogStatus,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    }
    if (data.containsKey('taxonomic_rank')) {
      context.handle(
        _taxonomicRankMeta,
        taxonomicRank.isAcceptableOrUnknown(
          data['taxonomic_rank']!,
          _taxonomicRankMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taxonomicRankMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(
          data['scientific_name']!,
          _scientificNameMeta,
        ),
      );
    }
    if (data.containsKey('common_name')) {
      context.handle(
        _commonNameMeta,
        commonName.isAcceptableOrUnknown(data['common_name']!, _commonNameMeta),
      );
    } else if (isInserting) {
      context.missing(_commonNameMeta);
    }
    if (data.containsKey('category_key')) {
      context.handle(
        _categoryKeyMeta,
        categoryKey.isAcceptableOrUnknown(
          data['category_key']!,
          _categoryKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryKeyMeta);
    }
    if (data.containsKey('parent_taxon_id')) {
      context.handle(
        _parentTaxonIdMeta,
        parentTaxonId.isAcceptableOrUnknown(
          data['parent_taxon_id']!,
          _parentTaxonIdMeta,
        ),
      );
    }
    if (data.containsKey('catalog_status')) {
      context.handle(
        _catalogStatusMeta,
        catalogStatus.isAcceptableOrUnknown(
          data['catalog_status']!,
          _catalogStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_catalogStatusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      ),
      taxonomicRank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taxonomic_rank'],
      )!,
      scientificName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scientific_name'],
      ),
      commonName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_name'],
      )!,
      categoryKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_key'],
      )!,
      parentTaxonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_taxon_id'],
      ),
      catalogStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catalog_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SpeciesTable createAlias(String alias) {
    return $SpeciesTable(attachedDatabase, alias);
  }
}

class SpeciesData extends DataClass implements Insertable<SpeciesData> {
  final String id;
  final String origin;
  final String? workspaceId;
  final String taxonomicRank;
  final String? scientificName;
  final String commonName;
  final String categoryKey;
  final String? parentTaxonId;
  final String catalogStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const SpeciesData({
    required this.id,
    required this.origin,
    this.workspaceId,
    required this.taxonomicRank,
    this.scientificName,
    required this.commonName,
    required this.categoryKey,
    this.parentTaxonId,
    required this.catalogStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['origin'] = Variable<String>(origin);
    if (!nullToAbsent || workspaceId != null) {
      map['workspace_id'] = Variable<String>(workspaceId);
    }
    map['taxonomic_rank'] = Variable<String>(taxonomicRank);
    if (!nullToAbsent || scientificName != null) {
      map['scientific_name'] = Variable<String>(scientificName);
    }
    map['common_name'] = Variable<String>(commonName);
    map['category_key'] = Variable<String>(categoryKey);
    if (!nullToAbsent || parentTaxonId != null) {
      map['parent_taxon_id'] = Variable<String>(parentTaxonId);
    }
    map['catalog_status'] = Variable<String>(catalogStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SpeciesCompanion toCompanion(bool nullToAbsent) {
    return SpeciesCompanion(
      id: Value(id),
      origin: Value(origin),
      workspaceId: workspaceId == null && nullToAbsent
          ? const Value.absent()
          : Value(workspaceId),
      taxonomicRank: Value(taxonomicRank),
      scientificName: scientificName == null && nullToAbsent
          ? const Value.absent()
          : Value(scientificName),
      commonName: Value(commonName),
      categoryKey: Value(categoryKey),
      parentTaxonId: parentTaxonId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTaxonId),
      catalogStatus: Value(catalogStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SpeciesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesData(
      id: serializer.fromJson<String>(json['id']),
      origin: serializer.fromJson<String>(json['origin']),
      workspaceId: serializer.fromJson<String?>(json['workspaceId']),
      taxonomicRank: serializer.fromJson<String>(json['taxonomicRank']),
      scientificName: serializer.fromJson<String?>(json['scientificName']),
      commonName: serializer.fromJson<String>(json['commonName']),
      categoryKey: serializer.fromJson<String>(json['categoryKey']),
      parentTaxonId: serializer.fromJson<String?>(json['parentTaxonId']),
      catalogStatus: serializer.fromJson<String>(json['catalogStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'origin': serializer.toJson<String>(origin),
      'workspaceId': serializer.toJson<String?>(workspaceId),
      'taxonomicRank': serializer.toJson<String>(taxonomicRank),
      'scientificName': serializer.toJson<String?>(scientificName),
      'commonName': serializer.toJson<String>(commonName),
      'categoryKey': serializer.toJson<String>(categoryKey),
      'parentTaxonId': serializer.toJson<String?>(parentTaxonId),
      'catalogStatus': serializer.toJson<String>(catalogStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SpeciesData copyWith({
    String? id,
    String? origin,
    Value<String?> workspaceId = const Value.absent(),
    String? taxonomicRank,
    Value<String?> scientificName = const Value.absent(),
    String? commonName,
    String? categoryKey,
    Value<String?> parentTaxonId = const Value.absent(),
    String? catalogStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => SpeciesData(
    id: id ?? this.id,
    origin: origin ?? this.origin,
    workspaceId: workspaceId.present ? workspaceId.value : this.workspaceId,
    taxonomicRank: taxonomicRank ?? this.taxonomicRank,
    scientificName: scientificName.present
        ? scientificName.value
        : this.scientificName,
    commonName: commonName ?? this.commonName,
    categoryKey: categoryKey ?? this.categoryKey,
    parentTaxonId: parentTaxonId.present
        ? parentTaxonId.value
        : this.parentTaxonId,
    catalogStatus: catalogStatus ?? this.catalogStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  SpeciesData copyWithCompanion(SpeciesCompanion data) {
    return SpeciesData(
      id: data.id.present ? data.id.value : this.id,
      origin: data.origin.present ? data.origin.value : this.origin,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      taxonomicRank: data.taxonomicRank.present
          ? data.taxonomicRank.value
          : this.taxonomicRank,
      scientificName: data.scientificName.present
          ? data.scientificName.value
          : this.scientificName,
      commonName: data.commonName.present
          ? data.commonName.value
          : this.commonName,
      categoryKey: data.categoryKey.present
          ? data.categoryKey.value
          : this.categoryKey,
      parentTaxonId: data.parentTaxonId.present
          ? data.parentTaxonId.value
          : this.parentTaxonId,
      catalogStatus: data.catalogStatus.present
          ? data.catalogStatus.value
          : this.catalogStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesData(')
          ..write('id: $id, ')
          ..write('origin: $origin, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('taxonomicRank: $taxonomicRank, ')
          ..write('scientificName: $scientificName, ')
          ..write('commonName: $commonName, ')
          ..write('categoryKey: $categoryKey, ')
          ..write('parentTaxonId: $parentTaxonId, ')
          ..write('catalogStatus: $catalogStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    origin,
    workspaceId,
    taxonomicRank,
    scientificName,
    commonName,
    categoryKey,
    parentTaxonId,
    catalogStatus,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesData &&
          other.id == this.id &&
          other.origin == this.origin &&
          other.workspaceId == this.workspaceId &&
          other.taxonomicRank == this.taxonomicRank &&
          other.scientificName == this.scientificName &&
          other.commonName == this.commonName &&
          other.categoryKey == this.categoryKey &&
          other.parentTaxonId == this.parentTaxonId &&
          other.catalogStatus == this.catalogStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SpeciesCompanion extends UpdateCompanion<SpeciesData> {
  final Value<String> id;
  final Value<String> origin;
  final Value<String?> workspaceId;
  final Value<String> taxonomicRank;
  final Value<String?> scientificName;
  final Value<String> commonName;
  final Value<String> categoryKey;
  final Value<String?> parentTaxonId;
  final Value<String> catalogStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const SpeciesCompanion({
    this.id = const Value.absent(),
    this.origin = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.taxonomicRank = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.commonName = const Value.absent(),
    this.categoryKey = const Value.absent(),
    this.parentTaxonId = const Value.absent(),
    this.catalogStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeciesCompanion.insert({
    required String id,
    required String origin,
    this.workspaceId = const Value.absent(),
    required String taxonomicRank,
    this.scientificName = const Value.absent(),
    required String commonName,
    required String categoryKey,
    this.parentTaxonId = const Value.absent(),
    required String catalogStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       origin = Value(origin),
       taxonomicRank = Value(taxonomicRank),
       commonName = Value(commonName),
       categoryKey = Value(categoryKey),
       catalogStatus = Value(catalogStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SpeciesData> custom({
    Expression<String>? id,
    Expression<String>? origin,
    Expression<String>? workspaceId,
    Expression<String>? taxonomicRank,
    Expression<String>? scientificName,
    Expression<String>? commonName,
    Expression<String>? categoryKey,
    Expression<String>? parentTaxonId,
    Expression<String>? catalogStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (origin != null) 'origin': origin,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (taxonomicRank != null) 'taxonomic_rank': taxonomicRank,
      if (scientificName != null) 'scientific_name': scientificName,
      if (commonName != null) 'common_name': commonName,
      if (categoryKey != null) 'category_key': categoryKey,
      if (parentTaxonId != null) 'parent_taxon_id': parentTaxonId,
      if (catalogStatus != null) 'catalog_status': catalogStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeciesCompanion copyWith({
    Value<String>? id,
    Value<String>? origin,
    Value<String?>? workspaceId,
    Value<String>? taxonomicRank,
    Value<String?>? scientificName,
    Value<String>? commonName,
    Value<String>? categoryKey,
    Value<String?>? parentTaxonId,
    Value<String>? catalogStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return SpeciesCompanion(
      id: id ?? this.id,
      origin: origin ?? this.origin,
      workspaceId: workspaceId ?? this.workspaceId,
      taxonomicRank: taxonomicRank ?? this.taxonomicRank,
      scientificName: scientificName ?? this.scientificName,
      commonName: commonName ?? this.commonName,
      categoryKey: categoryKey ?? this.categoryKey,
      parentTaxonId: parentTaxonId ?? this.parentTaxonId,
      catalogStatus: catalogStatus ?? this.catalogStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (taxonomicRank.present) {
      map['taxonomic_rank'] = Variable<String>(taxonomicRank.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (categoryKey.present) {
      map['category_key'] = Variable<String>(categoryKey.value);
    }
    if (parentTaxonId.present) {
      map['parent_taxon_id'] = Variable<String>(parentTaxonId.value);
    }
    if (catalogStatus.present) {
      map['catalog_status'] = Variable<String>(catalogStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesCompanion(')
          ..write('id: $id, ')
          ..write('origin: $origin, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('taxonomicRank: $taxonomicRank, ')
          ..write('scientificName: $scientificName, ')
          ..write('commonName: $commonName, ')
          ..write('categoryKey: $categoryKey, ')
          ..write('parentTaxonId: $parentTaxonId, ')
          ..write('catalogStatus: $catalogStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpeciesSourcesTable extends SpeciesSources
    with TableInfo<$SpeciesSourcesTable, SpeciesSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accessedAtMeta = const VerificationMeta(
    'accessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> accessedAt = GeneratedColumn<DateTime>(
    'accessed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseOrUsageNoteMeta =
      const VerificationMeta('licenseOrUsageNote');
  @override
  late final GeneratedColumn<String> licenseOrUsageNote =
      GeneratedColumn<String>(
        'license_or_usage_note',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _validationStatusMeta = const VerificationMeta(
    'validationStatus',
  );
  @override
  late final GeneratedColumn<String> validationStatus = GeneratedColumn<String>(
    'validation_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unreviewed'),
  );
  static const VerificationMeta _reviewedByMeta = const VerificationMeta(
    'reviewedBy',
  );
  @override
  late final GeneratedColumn<String> reviewedBy = GeneratedColumn<String>(
    'reviewed_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    speciesId,
    sourceName,
    sourceUrl,
    publisher,
    accessedAt,
    licenseOrUsageNote,
    validationStatus,
    reviewedBy,
    reviewedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('accessed_at')) {
      context.handle(
        _accessedAtMeta,
        accessedAt.isAcceptableOrUnknown(data['accessed_at']!, _accessedAtMeta),
      );
    }
    if (data.containsKey('license_or_usage_note')) {
      context.handle(
        _licenseOrUsageNoteMeta,
        licenseOrUsageNote.isAcceptableOrUnknown(
          data['license_or_usage_note']!,
          _licenseOrUsageNoteMeta,
        ),
      );
    }
    if (data.containsKey('validation_status')) {
      context.handle(
        _validationStatusMeta,
        validationStatus.isAcceptableOrUnknown(
          data['validation_status']!,
          _validationStatusMeta,
        ),
      );
    }
    if (data.containsKey('reviewed_by')) {
      context.handle(
        _reviewedByMeta,
        reviewedBy.isAcceptableOrUnknown(data['reviewed_by']!, _reviewedByMeta),
      );
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      )!,
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      accessedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accessed_at'],
      ),
      licenseOrUsageNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_or_usage_note'],
      ),
      validationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}validation_status'],
      )!,
      reviewedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reviewed_by'],
      ),
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SpeciesSourcesTable createAlias(String alias) {
    return $SpeciesSourcesTable(attachedDatabase, alias);
  }
}

class SpeciesSource extends DataClass implements Insertable<SpeciesSource> {
  final String id;
  final String speciesId;
  final String sourceName;
  final String? sourceUrl;
  final String? publisher;
  final DateTime? accessedAt;
  final String? licenseOrUsageNote;
  final String validationStatus;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final DateTime createdAt;
  const SpeciesSource({
    required this.id,
    required this.speciesId,
    required this.sourceName,
    this.sourceUrl,
    this.publisher,
    this.accessedAt,
    this.licenseOrUsageNote,
    required this.validationStatus,
    this.reviewedBy,
    this.reviewedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['species_id'] = Variable<String>(speciesId);
    map['source_name'] = Variable<String>(sourceName);
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || accessedAt != null) {
      map['accessed_at'] = Variable<DateTime>(accessedAt);
    }
    if (!nullToAbsent || licenseOrUsageNote != null) {
      map['license_or_usage_note'] = Variable<String>(licenseOrUsageNote);
    }
    map['validation_status'] = Variable<String>(validationStatus);
    if (!nullToAbsent || reviewedBy != null) {
      map['reviewed_by'] = Variable<String>(reviewedBy);
    }
    if (!nullToAbsent || reviewedAt != null) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SpeciesSourcesCompanion toCompanion(bool nullToAbsent) {
    return SpeciesSourcesCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      sourceName: Value(sourceName),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      accessedAt: accessedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(accessedAt),
      licenseOrUsageNote: licenseOrUsageNote == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseOrUsageNote),
      validationStatus: Value(validationStatus),
      reviewedBy: reviewedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewedBy),
      reviewedAt: reviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewedAt),
      createdAt: Value(createdAt),
    );
  }

  factory SpeciesSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesSource(
      id: serializer.fromJson<String>(json['id']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      accessedAt: serializer.fromJson<DateTime?>(json['accessedAt']),
      licenseOrUsageNote: serializer.fromJson<String?>(
        json['licenseOrUsageNote'],
      ),
      validationStatus: serializer.fromJson<String>(json['validationStatus']),
      reviewedBy: serializer.fromJson<String?>(json['reviewedBy']),
      reviewedAt: serializer.fromJson<DateTime?>(json['reviewedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'speciesId': serializer.toJson<String>(speciesId),
      'sourceName': serializer.toJson<String>(sourceName),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'publisher': serializer.toJson<String?>(publisher),
      'accessedAt': serializer.toJson<DateTime?>(accessedAt),
      'licenseOrUsageNote': serializer.toJson<String?>(licenseOrUsageNote),
      'validationStatus': serializer.toJson<String>(validationStatus),
      'reviewedBy': serializer.toJson<String?>(reviewedBy),
      'reviewedAt': serializer.toJson<DateTime?>(reviewedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SpeciesSource copyWith({
    String? id,
    String? speciesId,
    String? sourceName,
    Value<String?> sourceUrl = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    Value<DateTime?> accessedAt = const Value.absent(),
    Value<String?> licenseOrUsageNote = const Value.absent(),
    String? validationStatus,
    Value<String?> reviewedBy = const Value.absent(),
    Value<DateTime?> reviewedAt = const Value.absent(),
    DateTime? createdAt,
  }) => SpeciesSource(
    id: id ?? this.id,
    speciesId: speciesId ?? this.speciesId,
    sourceName: sourceName ?? this.sourceName,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    publisher: publisher.present ? publisher.value : this.publisher,
    accessedAt: accessedAt.present ? accessedAt.value : this.accessedAt,
    licenseOrUsageNote: licenseOrUsageNote.present
        ? licenseOrUsageNote.value
        : this.licenseOrUsageNote,
    validationStatus: validationStatus ?? this.validationStatus,
    reviewedBy: reviewedBy.present ? reviewedBy.value : this.reviewedBy,
    reviewedAt: reviewedAt.present ? reviewedAt.value : this.reviewedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  SpeciesSource copyWithCompanion(SpeciesSourcesCompanion data) {
    return SpeciesSource(
      id: data.id.present ? data.id.value : this.id,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      accessedAt: data.accessedAt.present
          ? data.accessedAt.value
          : this.accessedAt,
      licenseOrUsageNote: data.licenseOrUsageNote.present
          ? data.licenseOrUsageNote.value
          : this.licenseOrUsageNote,
      validationStatus: data.validationStatus.present
          ? data.validationStatus.value
          : this.validationStatus,
      reviewedBy: data.reviewedBy.present
          ? data.reviewedBy.value
          : this.reviewedBy,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesSource(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('publisher: $publisher, ')
          ..write('accessedAt: $accessedAt, ')
          ..write('licenseOrUsageNote: $licenseOrUsageNote, ')
          ..write('validationStatus: $validationStatus, ')
          ..write('reviewedBy: $reviewedBy, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    speciesId,
    sourceName,
    sourceUrl,
    publisher,
    accessedAt,
    licenseOrUsageNote,
    validationStatus,
    reviewedBy,
    reviewedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesSource &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.sourceName == this.sourceName &&
          other.sourceUrl == this.sourceUrl &&
          other.publisher == this.publisher &&
          other.accessedAt == this.accessedAt &&
          other.licenseOrUsageNote == this.licenseOrUsageNote &&
          other.validationStatus == this.validationStatus &&
          other.reviewedBy == this.reviewedBy &&
          other.reviewedAt == this.reviewedAt &&
          other.createdAt == this.createdAt);
}

class SpeciesSourcesCompanion extends UpdateCompanion<SpeciesSource> {
  final Value<String> id;
  final Value<String> speciesId;
  final Value<String> sourceName;
  final Value<String?> sourceUrl;
  final Value<String?> publisher;
  final Value<DateTime?> accessedAt;
  final Value<String?> licenseOrUsageNote;
  final Value<String> validationStatus;
  final Value<String?> reviewedBy;
  final Value<DateTime?> reviewedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SpeciesSourcesCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.publisher = const Value.absent(),
    this.accessedAt = const Value.absent(),
    this.licenseOrUsageNote = const Value.absent(),
    this.validationStatus = const Value.absent(),
    this.reviewedBy = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeciesSourcesCompanion.insert({
    required String id,
    required String speciesId,
    required String sourceName,
    this.sourceUrl = const Value.absent(),
    this.publisher = const Value.absent(),
    this.accessedAt = const Value.absent(),
    this.licenseOrUsageNote = const Value.absent(),
    this.validationStatus = const Value.absent(),
    this.reviewedBy = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       speciesId = Value(speciesId),
       sourceName = Value(sourceName),
       createdAt = Value(createdAt);
  static Insertable<SpeciesSource> custom({
    Expression<String>? id,
    Expression<String>? speciesId,
    Expression<String>? sourceName,
    Expression<String>? sourceUrl,
    Expression<String>? publisher,
    Expression<DateTime>? accessedAt,
    Expression<String>? licenseOrUsageNote,
    Expression<String>? validationStatus,
    Expression<String>? reviewedBy,
    Expression<DateTime>? reviewedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (sourceName != null) 'source_name': sourceName,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (publisher != null) 'publisher': publisher,
      if (accessedAt != null) 'accessed_at': accessedAt,
      if (licenseOrUsageNote != null)
        'license_or_usage_note': licenseOrUsageNote,
      if (validationStatus != null) 'validation_status': validationStatus,
      if (reviewedBy != null) 'reviewed_by': reviewedBy,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeciesSourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? speciesId,
    Value<String>? sourceName,
    Value<String?>? sourceUrl,
    Value<String?>? publisher,
    Value<DateTime?>? accessedAt,
    Value<String?>? licenseOrUsageNote,
    Value<String>? validationStatus,
    Value<String?>? reviewedBy,
    Value<DateTime?>? reviewedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SpeciesSourcesCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      publisher: publisher ?? this.publisher,
      accessedAt: accessedAt ?? this.accessedAt,
      licenseOrUsageNote: licenseOrUsageNote ?? this.licenseOrUsageNote,
      validationStatus: validationStatus ?? this.validationStatus,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (accessedAt.present) {
      map['accessed_at'] = Variable<DateTime>(accessedAt.value);
    }
    if (licenseOrUsageNote.present) {
      map['license_or_usage_note'] = Variable<String>(licenseOrUsageNote.value);
    }
    if (validationStatus.present) {
      map['validation_status'] = Variable<String>(validationStatus.value);
    }
    if (reviewedBy.present) {
      map['reviewed_by'] = Variable<String>(reviewedBy.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesSourcesCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('publisher: $publisher, ')
          ..write('accessedAt: $accessedAt, ')
          ..write('licenseOrUsageNote: $licenseOrUsageNote, ')
          ..write('validationStatus: $validationStatus, ')
          ..write('reviewedBy: $reviewedBy, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpeciesAttributeDefinitionsTable extends SpeciesAttributeDefinitions
    with
        TableInfo<
          $SpeciesAttributeDefinitionsTable,
          SpeciesAttributeDefinition
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesAttributeDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueTypeMeta = const VerificationMeta(
    'valueType',
  );
  @override
  late final GeneratedColumn<String> valueType = GeneratedColumn<String>(
    'value_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appliesToMeta = const VerificationMeta(
    'appliesTo',
  );
  @override
  late final GeneratedColumn<String> appliesTo = GeneratedColumn<String>(
    'applies_to',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCodeMeta = const VerificationMeta(
    'unitCode',
  );
  @override
  late final GeneratedColumn<String> unitCode = GeneratedColumn<String>(
    'unit_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionsJsonMeta = const VerificationMeta(
    'optionsJson',
  );
  @override
  late final GeneratedColumn<String> optionsJson = GeneratedColumn<String>(
    'options_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validationRulesJsonMeta =
      const VerificationMeta('validationRulesJson');
  @override
  late final GeneratedColumn<String> validationRulesJson =
      GeneratedColumn<String>(
        'validation_rules_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _definitionVersionMeta = const VerificationMeta(
    'definitionVersion',
  );
  @override
  late final GeneratedColumn<int> definitionVersion = GeneratedColumn<int>(
    'definition_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    speciesId,
    key,
    label,
    category,
    valueType,
    appliesTo,
    unitCode,
    optionsJson,
    validationRulesJson,
    isRequired,
    definitionVersion,
    displayOrder,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species_attribute_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesAttributeDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('value_type')) {
      context.handle(
        _valueTypeMeta,
        valueType.isAcceptableOrUnknown(data['value_type']!, _valueTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_valueTypeMeta);
    }
    if (data.containsKey('applies_to')) {
      context.handle(
        _appliesToMeta,
        appliesTo.isAcceptableOrUnknown(data['applies_to']!, _appliesToMeta),
      );
    } else if (isInserting) {
      context.missing(_appliesToMeta);
    }
    if (data.containsKey('unit_code')) {
      context.handle(
        _unitCodeMeta,
        unitCode.isAcceptableOrUnknown(data['unit_code']!, _unitCodeMeta),
      );
    }
    if (data.containsKey('options_json')) {
      context.handle(
        _optionsJsonMeta,
        optionsJson.isAcceptableOrUnknown(
          data['options_json']!,
          _optionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('validation_rules_json')) {
      context.handle(
        _validationRulesJsonMeta,
        validationRulesJson.isAcceptableOrUnknown(
          data['validation_rules_json']!,
          _validationRulesJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    if (data.containsKey('definition_version')) {
      context.handle(
        _definitionVersionMeta,
        definitionVersion.isAcceptableOrUnknown(
          data['definition_version']!,
          _definitionVersionMeta,
        ),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesAttributeDefinition map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesAttributeDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      valueType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_type'],
      )!,
      appliesTo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}applies_to'],
      )!,
      unitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_code'],
      ),
      optionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_json'],
      ),
      validationRulesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}validation_rules_json'],
      ),
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
      definitionVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}definition_version'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
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
  $SpeciesAttributeDefinitionsTable createAlias(String alias) {
    return $SpeciesAttributeDefinitionsTable(attachedDatabase, alias);
  }
}

class SpeciesAttributeDefinition extends DataClass
    implements Insertable<SpeciesAttributeDefinition> {
  final String id;
  final String speciesId;
  final String key;
  final String label;
  final String category;
  final String valueType;
  final String appliesTo;
  final String? unitCode;
  final String? optionsJson;
  final String? validationRulesJson;
  final bool isRequired;
  final int definitionVersion;
  final int displayOrder;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SpeciesAttributeDefinition({
    required this.id,
    required this.speciesId,
    required this.key,
    required this.label,
    required this.category,
    required this.valueType,
    required this.appliesTo,
    this.unitCode,
    this.optionsJson,
    this.validationRulesJson,
    required this.isRequired,
    required this.definitionVersion,
    required this.displayOrder,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['species_id'] = Variable<String>(speciesId);
    map['key'] = Variable<String>(key);
    map['label'] = Variable<String>(label);
    map['category'] = Variable<String>(category);
    map['value_type'] = Variable<String>(valueType);
    map['applies_to'] = Variable<String>(appliesTo);
    if (!nullToAbsent || unitCode != null) {
      map['unit_code'] = Variable<String>(unitCode);
    }
    if (!nullToAbsent || optionsJson != null) {
      map['options_json'] = Variable<String>(optionsJson);
    }
    if (!nullToAbsent || validationRulesJson != null) {
      map['validation_rules_json'] = Variable<String>(validationRulesJson);
    }
    map['is_required'] = Variable<bool>(isRequired);
    map['definition_version'] = Variable<int>(definitionVersion);
    map['display_order'] = Variable<int>(displayOrder);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SpeciesAttributeDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return SpeciesAttributeDefinitionsCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      key: Value(key),
      label: Value(label),
      category: Value(category),
      valueType: Value(valueType),
      appliesTo: Value(appliesTo),
      unitCode: unitCode == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCode),
      optionsJson: optionsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(optionsJson),
      validationRulesJson: validationRulesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(validationRulesJson),
      isRequired: Value(isRequired),
      definitionVersion: Value(definitionVersion),
      displayOrder: Value(displayOrder),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SpeciesAttributeDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesAttributeDefinition(
      id: serializer.fromJson<String>(json['id']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      key: serializer.fromJson<String>(json['key']),
      label: serializer.fromJson<String>(json['label']),
      category: serializer.fromJson<String>(json['category']),
      valueType: serializer.fromJson<String>(json['valueType']),
      appliesTo: serializer.fromJson<String>(json['appliesTo']),
      unitCode: serializer.fromJson<String?>(json['unitCode']),
      optionsJson: serializer.fromJson<String?>(json['optionsJson']),
      validationRulesJson: serializer.fromJson<String?>(
        json['validationRulesJson'],
      ),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      definitionVersion: serializer.fromJson<int>(json['definitionVersion']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'speciesId': serializer.toJson<String>(speciesId),
      'key': serializer.toJson<String>(key),
      'label': serializer.toJson<String>(label),
      'category': serializer.toJson<String>(category),
      'valueType': serializer.toJson<String>(valueType),
      'appliesTo': serializer.toJson<String>(appliesTo),
      'unitCode': serializer.toJson<String?>(unitCode),
      'optionsJson': serializer.toJson<String?>(optionsJson),
      'validationRulesJson': serializer.toJson<String?>(validationRulesJson),
      'isRequired': serializer.toJson<bool>(isRequired),
      'definitionVersion': serializer.toJson<int>(definitionVersion),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SpeciesAttributeDefinition copyWith({
    String? id,
    String? speciesId,
    String? key,
    String? label,
    String? category,
    String? valueType,
    String? appliesTo,
    Value<String?> unitCode = const Value.absent(),
    Value<String?> optionsJson = const Value.absent(),
    Value<String?> validationRulesJson = const Value.absent(),
    bool? isRequired,
    int? definitionVersion,
    int? displayOrder,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SpeciesAttributeDefinition(
    id: id ?? this.id,
    speciesId: speciesId ?? this.speciesId,
    key: key ?? this.key,
    label: label ?? this.label,
    category: category ?? this.category,
    valueType: valueType ?? this.valueType,
    appliesTo: appliesTo ?? this.appliesTo,
    unitCode: unitCode.present ? unitCode.value : this.unitCode,
    optionsJson: optionsJson.present ? optionsJson.value : this.optionsJson,
    validationRulesJson: validationRulesJson.present
        ? validationRulesJson.value
        : this.validationRulesJson,
    isRequired: isRequired ?? this.isRequired,
    definitionVersion: definitionVersion ?? this.definitionVersion,
    displayOrder: displayOrder ?? this.displayOrder,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SpeciesAttributeDefinition copyWithCompanion(
    SpeciesAttributeDefinitionsCompanion data,
  ) {
    return SpeciesAttributeDefinition(
      id: data.id.present ? data.id.value : this.id,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      key: data.key.present ? data.key.value : this.key,
      label: data.label.present ? data.label.value : this.label,
      category: data.category.present ? data.category.value : this.category,
      valueType: data.valueType.present ? data.valueType.value : this.valueType,
      appliesTo: data.appliesTo.present ? data.appliesTo.value : this.appliesTo,
      unitCode: data.unitCode.present ? data.unitCode.value : this.unitCode,
      optionsJson: data.optionsJson.present
          ? data.optionsJson.value
          : this.optionsJson,
      validationRulesJson: data.validationRulesJson.present
          ? data.validationRulesJson.value
          : this.validationRulesJson,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
      definitionVersion: data.definitionVersion.present
          ? data.definitionVersion.value
          : this.definitionVersion,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesAttributeDefinition(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('key: $key, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('valueType: $valueType, ')
          ..write('appliesTo: $appliesTo, ')
          ..write('unitCode: $unitCode, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('validationRulesJson: $validationRulesJson, ')
          ..write('isRequired: $isRequired, ')
          ..write('definitionVersion: $definitionVersion, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    speciesId,
    key,
    label,
    category,
    valueType,
    appliesTo,
    unitCode,
    optionsJson,
    validationRulesJson,
    isRequired,
    definitionVersion,
    displayOrder,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesAttributeDefinition &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.key == this.key &&
          other.label == this.label &&
          other.category == this.category &&
          other.valueType == this.valueType &&
          other.appliesTo == this.appliesTo &&
          other.unitCode == this.unitCode &&
          other.optionsJson == this.optionsJson &&
          other.validationRulesJson == this.validationRulesJson &&
          other.isRequired == this.isRequired &&
          other.definitionVersion == this.definitionVersion &&
          other.displayOrder == this.displayOrder &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SpeciesAttributeDefinitionsCompanion
    extends UpdateCompanion<SpeciesAttributeDefinition> {
  final Value<String> id;
  final Value<String> speciesId;
  final Value<String> key;
  final Value<String> label;
  final Value<String> category;
  final Value<String> valueType;
  final Value<String> appliesTo;
  final Value<String?> unitCode;
  final Value<String?> optionsJson;
  final Value<String?> validationRulesJson;
  final Value<bool> isRequired;
  final Value<int> definitionVersion;
  final Value<int> displayOrder;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SpeciesAttributeDefinitionsCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.key = const Value.absent(),
    this.label = const Value.absent(),
    this.category = const Value.absent(),
    this.valueType = const Value.absent(),
    this.appliesTo = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.validationRulesJson = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.definitionVersion = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeciesAttributeDefinitionsCompanion.insert({
    required String id,
    required String speciesId,
    required String key,
    required String label,
    required String category,
    required String valueType,
    required String appliesTo,
    this.unitCode = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.validationRulesJson = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.definitionVersion = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       speciesId = Value(speciesId),
       key = Value(key),
       label = Value(label),
       category = Value(category),
       valueType = Value(valueType),
       appliesTo = Value(appliesTo),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SpeciesAttributeDefinition> custom({
    Expression<String>? id,
    Expression<String>? speciesId,
    Expression<String>? key,
    Expression<String>? label,
    Expression<String>? category,
    Expression<String>? valueType,
    Expression<String>? appliesTo,
    Expression<String>? unitCode,
    Expression<String>? optionsJson,
    Expression<String>? validationRulesJson,
    Expression<bool>? isRequired,
    Expression<int>? definitionVersion,
    Expression<int>? displayOrder,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (key != null) 'key': key,
      if (label != null) 'label': label,
      if (category != null) 'category': category,
      if (valueType != null) 'value_type': valueType,
      if (appliesTo != null) 'applies_to': appliesTo,
      if (unitCode != null) 'unit_code': unitCode,
      if (optionsJson != null) 'options_json': optionsJson,
      if (validationRulesJson != null)
        'validation_rules_json': validationRulesJson,
      if (isRequired != null) 'is_required': isRequired,
      if (definitionVersion != null) 'definition_version': definitionVersion,
      if (displayOrder != null) 'display_order': displayOrder,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeciesAttributeDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? speciesId,
    Value<String>? key,
    Value<String>? label,
    Value<String>? category,
    Value<String>? valueType,
    Value<String>? appliesTo,
    Value<String?>? unitCode,
    Value<String?>? optionsJson,
    Value<String?>? validationRulesJson,
    Value<bool>? isRequired,
    Value<int>? definitionVersion,
    Value<int>? displayOrder,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SpeciesAttributeDefinitionsCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      key: key ?? this.key,
      label: label ?? this.label,
      category: category ?? this.category,
      valueType: valueType ?? this.valueType,
      appliesTo: appliesTo ?? this.appliesTo,
      unitCode: unitCode ?? this.unitCode,
      optionsJson: optionsJson ?? this.optionsJson,
      validationRulesJson: validationRulesJson ?? this.validationRulesJson,
      isRequired: isRequired ?? this.isRequired,
      definitionVersion: definitionVersion ?? this.definitionVersion,
      displayOrder: displayOrder ?? this.displayOrder,
      status: status ?? this.status,
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
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<String>(valueType.value);
    }
    if (appliesTo.present) {
      map['applies_to'] = Variable<String>(appliesTo.value);
    }
    if (unitCode.present) {
      map['unit_code'] = Variable<String>(unitCode.value);
    }
    if (optionsJson.present) {
      map['options_json'] = Variable<String>(optionsJson.value);
    }
    if (validationRulesJson.present) {
      map['validation_rules_json'] = Variable<String>(
        validationRulesJson.value,
      );
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (definitionVersion.present) {
      map['definition_version'] = Variable<int>(definitionVersion.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
    return (StringBuffer('SpeciesAttributeDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('key: $key, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('valueType: $valueType, ')
          ..write('appliesTo: $appliesTo, ')
          ..write('unitCode: $unitCode, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('validationRulesJson: $validationRulesJson, ')
          ..write('isRequired: $isRequired, ')
          ..write('definitionVersion: $definitionVersion, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnimalProfilesTable extends AnimalProfiles
    with TableInfo<$AnimalProfilesTable, AnimalProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _recordKindMeta = const VerificationMeta(
    'recordKind',
  );
  @override
  late final GeneratedColumn<String> recordKind = GeneratedColumn<String>(
    'record_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species (id)',
    ),
  );
  static const VerificationMeta _profileStatusMeta = const VerificationMeta(
    'profileStatus',
  );
  @override
  late final GeneratedColumn<String> profileStatus = GeneratedColumn<String>(
    'profile_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _identificationTypeMeta =
      const VerificationMeta('identificationType');
  @override
  late final GeneratedColumn<String> identificationType =
      GeneratedColumn<String>(
        'identification_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _identificationValueMeta =
      const VerificationMeta('identificationValue');
  @override
  late final GeneratedColumn<String> identificationValue =
      GeneratedColumn<String>(
        'identification_value',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    recordKind,
    displayName,
    speciesId,
    profileStatus,
    notes,
    identificationType,
    identificationValue,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animal_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimalProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('record_kind')) {
      context.handle(
        _recordKindMeta,
        recordKind.isAcceptableOrUnknown(data['record_kind']!, _recordKindMeta),
      );
    } else if (isInserting) {
      context.missing(_recordKindMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    }
    if (data.containsKey('profile_status')) {
      context.handle(
        _profileStatusMeta,
        profileStatus.isAcceptableOrUnknown(
          data['profile_status']!,
          _profileStatusMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('identification_type')) {
      context.handle(
        _identificationTypeMeta,
        identificationType.isAcceptableOrUnknown(
          data['identification_type']!,
          _identificationTypeMeta,
        ),
      );
    }
    if (data.containsKey('identification_value')) {
      context.handle(
        _identificationValueMeta,
        identificationValue.isAcceptableOrUnknown(
          data['identification_value']!,
          _identificationValueMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimalProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimalProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      recordKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_kind'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      ),
      profileStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      identificationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identification_type'],
      ),
      identificationValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identification_value'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $AnimalProfilesTable createAlias(String alias) {
    return $AnimalProfilesTable(attachedDatabase, alias);
  }
}

class AnimalProfile extends DataClass implements Insertable<AnimalProfile> {
  final String id;
  final String workspaceId;
  final String recordKind;
  final String displayName;
  final String? speciesId;
  final String profileStatus;
  final String? notes;
  final String? identificationType;
  final String? identificationValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const AnimalProfile({
    required this.id,
    required this.workspaceId,
    required this.recordKind,
    required this.displayName,
    this.speciesId,
    required this.profileStatus,
    this.notes,
    this.identificationType,
    this.identificationValue,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['record_kind'] = Variable<String>(recordKind);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || speciesId != null) {
      map['species_id'] = Variable<String>(speciesId);
    }
    map['profile_status'] = Variable<String>(profileStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || identificationType != null) {
      map['identification_type'] = Variable<String>(identificationType);
    }
    if (!nullToAbsent || identificationValue != null) {
      map['identification_value'] = Variable<String>(identificationValue);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  AnimalProfilesCompanion toCompanion(bool nullToAbsent) {
    return AnimalProfilesCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      recordKind: Value(recordKind),
      displayName: Value(displayName),
      speciesId: speciesId == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesId),
      profileStatus: Value(profileStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      identificationType: identificationType == null && nullToAbsent
          ? const Value.absent()
          : Value(identificationType),
      identificationValue: identificationValue == null && nullToAbsent
          ? const Value.absent()
          : Value(identificationValue),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory AnimalProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimalProfile(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      recordKind: serializer.fromJson<String>(json['recordKind']),
      displayName: serializer.fromJson<String>(json['displayName']),
      speciesId: serializer.fromJson<String?>(json['speciesId']),
      profileStatus: serializer.fromJson<String>(json['profileStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      identificationType: serializer.fromJson<String?>(
        json['identificationType'],
      ),
      identificationValue: serializer.fromJson<String?>(
        json['identificationValue'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'recordKind': serializer.toJson<String>(recordKind),
      'displayName': serializer.toJson<String>(displayName),
      'speciesId': serializer.toJson<String?>(speciesId),
      'profileStatus': serializer.toJson<String>(profileStatus),
      'notes': serializer.toJson<String?>(notes),
      'identificationType': serializer.toJson<String?>(identificationType),
      'identificationValue': serializer.toJson<String?>(identificationValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  AnimalProfile copyWith({
    String? id,
    String? workspaceId,
    String? recordKind,
    String? displayName,
    Value<String?> speciesId = const Value.absent(),
    String? profileStatus,
    Value<String?> notes = const Value.absent(),
    Value<String?> identificationType = const Value.absent(),
    Value<String?> identificationValue = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => AnimalProfile(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    recordKind: recordKind ?? this.recordKind,
    displayName: displayName ?? this.displayName,
    speciesId: speciesId.present ? speciesId.value : this.speciesId,
    profileStatus: profileStatus ?? this.profileStatus,
    notes: notes.present ? notes.value : this.notes,
    identificationType: identificationType.present
        ? identificationType.value
        : this.identificationType,
    identificationValue: identificationValue.present
        ? identificationValue.value
        : this.identificationValue,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  AnimalProfile copyWithCompanion(AnimalProfilesCompanion data) {
    return AnimalProfile(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      recordKind: data.recordKind.present
          ? data.recordKind.value
          : this.recordKind,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      profileStatus: data.profileStatus.present
          ? data.profileStatus.value
          : this.profileStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      identificationType: data.identificationType.present
          ? data.identificationType.value
          : this.identificationType,
      identificationValue: data.identificationValue.present
          ? data.identificationValue.value
          : this.identificationValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimalProfile(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('recordKind: $recordKind, ')
          ..write('displayName: $displayName, ')
          ..write('speciesId: $speciesId, ')
          ..write('profileStatus: $profileStatus, ')
          ..write('notes: $notes, ')
          ..write('identificationType: $identificationType, ')
          ..write('identificationValue: $identificationValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    recordKind,
    displayName,
    speciesId,
    profileStatus,
    notes,
    identificationType,
    identificationValue,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalProfile &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.recordKind == this.recordKind &&
          other.displayName == this.displayName &&
          other.speciesId == this.speciesId &&
          other.profileStatus == this.profileStatus &&
          other.notes == this.notes &&
          other.identificationType == this.identificationType &&
          other.identificationValue == this.identificationValue &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class AnimalProfilesCompanion extends UpdateCompanion<AnimalProfile> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> recordKind;
  final Value<String> displayName;
  final Value<String?> speciesId;
  final Value<String> profileStatus;
  final Value<String?> notes;
  final Value<String?> identificationType;
  final Value<String?> identificationValue;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const AnimalProfilesCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.recordKind = const Value.absent(),
    this.displayName = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.profileStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.identificationType = const Value.absent(),
    this.identificationValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimalProfilesCompanion.insert({
    required String id,
    required String workspaceId,
    required String recordKind,
    required String displayName,
    this.speciesId = const Value.absent(),
    this.profileStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.identificationType = const Value.absent(),
    this.identificationValue = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       recordKind = Value(recordKind),
       displayName = Value(displayName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AnimalProfile> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? recordKind,
    Expression<String>? displayName,
    Expression<String>? speciesId,
    Expression<String>? profileStatus,
    Expression<String>? notes,
    Expression<String>? identificationType,
    Expression<String>? identificationValue,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (recordKind != null) 'record_kind': recordKind,
      if (displayName != null) 'display_name': displayName,
      if (speciesId != null) 'species_id': speciesId,
      if (profileStatus != null) 'profile_status': profileStatus,
      if (notes != null) 'notes': notes,
      if (identificationType != null) 'identification_type': identificationType,
      if (identificationValue != null)
        'identification_value': identificationValue,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimalProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? recordKind,
    Value<String>? displayName,
    Value<String?>? speciesId,
    Value<String>? profileStatus,
    Value<String?>? notes,
    Value<String?>? identificationType,
    Value<String?>? identificationValue,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return AnimalProfilesCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      recordKind: recordKind ?? this.recordKind,
      displayName: displayName ?? this.displayName,
      speciesId: speciesId ?? this.speciesId,
      profileStatus: profileStatus ?? this.profileStatus,
      notes: notes ?? this.notes,
      identificationType: identificationType ?? this.identificationType,
      identificationValue: identificationValue ?? this.identificationValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (recordKind.present) {
      map['record_kind'] = Variable<String>(recordKind.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (profileStatus.present) {
      map['profile_status'] = Variable<String>(profileStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (identificationType.present) {
      map['identification_type'] = Variable<String>(identificationType.value);
    }
    if (identificationValue.present) {
      map['identification_value'] = Variable<String>(identificationValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalProfilesCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('recordKind: $recordKind, ')
          ..write('displayName: $displayName, ')
          ..write('speciesId: $speciesId, ')
          ..write('profileStatus: $profileStatus, ')
          ..write('notes: $notes, ')
          ..write('identificationType: $identificationType, ')
          ..write('identificationValue: $identificationValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpeciesAttributeValuesTable extends SpeciesAttributeValues
    with TableInfo<$SpeciesAttributeValuesTable, SpeciesAttributeValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesAttributeValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _animalProfileIdMeta = const VerificationMeta(
    'animalProfileId',
  );
  @override
  late final GeneratedColumn<String> animalProfileId = GeneratedColumn<String>(
    'animal_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _attributeDefinitionIdMeta =
      const VerificationMeta('attributeDefinitionId');
  @override
  late final GeneratedColumn<String> attributeDefinitionId =
      GeneratedColumn<String>(
        'attribute_definition_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES species_attribute_definitions (id)',
        ),
      );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCodeMeta = const VerificationMeta(
    'unitCode',
  );
  @override
  late final GeneratedColumn<String> unitCode = GeneratedColumn<String>(
    'unit_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observedAtMeta = const VerificationMeta(
    'observedAt',
  );
  @override
  late final GeneratedColumn<DateTime> observedAt = GeneratedColumn<DateTime>(
    'observed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueSourceMeta = const VerificationMeta(
    'valueSource',
  );
  @override
  late final GeneratedColumn<String> valueSource = GeneratedColumn<String>(
    'value_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('user'),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    animalProfileId,
    attributeDefinitionId,
    valueJson,
    unitCode,
    observedAt,
    valueSource,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species_attribute_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesAttributeValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('animal_profile_id')) {
      context.handle(
        _animalProfileIdMeta,
        animalProfileId.isAcceptableOrUnknown(
          data['animal_profile_id']!,
          _animalProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_animalProfileIdMeta);
    }
    if (data.containsKey('attribute_definition_id')) {
      context.handle(
        _attributeDefinitionIdMeta,
        attributeDefinitionId.isAcceptableOrUnknown(
          data['attribute_definition_id']!,
          _attributeDefinitionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attributeDefinitionIdMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('unit_code')) {
      context.handle(
        _unitCodeMeta,
        unitCode.isAcceptableOrUnknown(data['unit_code']!, _unitCodeMeta),
      );
    }
    if (data.containsKey('observed_at')) {
      context.handle(
        _observedAtMeta,
        observedAt.isAcceptableOrUnknown(data['observed_at']!, _observedAtMeta),
      );
    }
    if (data.containsKey('value_source')) {
      context.handle(
        _valueSourceMeta,
        valueSource.isAcceptableOrUnknown(
          data['value_source']!,
          _valueSourceMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesAttributeValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesAttributeValue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      animalProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_profile_id'],
      )!,
      attributeDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attribute_definition_id'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      unitCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_code'],
      ),
      observedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}observed_at'],
      ),
      valueSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SpeciesAttributeValuesTable createAlias(String alias) {
    return $SpeciesAttributeValuesTable(attachedDatabase, alias);
  }
}

class SpeciesAttributeValue extends DataClass
    implements Insertable<SpeciesAttributeValue> {
  final String id;
  final String workspaceId;
  final String animalProfileId;
  final String attributeDefinitionId;
  final String valueJson;
  final String? unitCode;
  final DateTime? observedAt;
  final String valueSource;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const SpeciesAttributeValue({
    required this.id,
    required this.workspaceId,
    required this.animalProfileId,
    required this.attributeDefinitionId,
    required this.valueJson,
    this.unitCode,
    this.observedAt,
    required this.valueSource,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['animal_profile_id'] = Variable<String>(animalProfileId);
    map['attribute_definition_id'] = Variable<String>(attributeDefinitionId);
    map['value_json'] = Variable<String>(valueJson);
    if (!nullToAbsent || unitCode != null) {
      map['unit_code'] = Variable<String>(unitCode);
    }
    if (!nullToAbsent || observedAt != null) {
      map['observed_at'] = Variable<DateTime>(observedAt);
    }
    map['value_source'] = Variable<String>(valueSource);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SpeciesAttributeValuesCompanion toCompanion(bool nullToAbsent) {
    return SpeciesAttributeValuesCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      animalProfileId: Value(animalProfileId),
      attributeDefinitionId: Value(attributeDefinitionId),
      valueJson: Value(valueJson),
      unitCode: unitCode == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCode),
      observedAt: observedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(observedAt),
      valueSource: Value(valueSource),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SpeciesAttributeValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesAttributeValue(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      animalProfileId: serializer.fromJson<String>(json['animalProfileId']),
      attributeDefinitionId: serializer.fromJson<String>(
        json['attributeDefinitionId'],
      ),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      unitCode: serializer.fromJson<String?>(json['unitCode']),
      observedAt: serializer.fromJson<DateTime?>(json['observedAt']),
      valueSource: serializer.fromJson<String>(json['valueSource']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'animalProfileId': serializer.toJson<String>(animalProfileId),
      'attributeDefinitionId': serializer.toJson<String>(attributeDefinitionId),
      'valueJson': serializer.toJson<String>(valueJson),
      'unitCode': serializer.toJson<String?>(unitCode),
      'observedAt': serializer.toJson<DateTime?>(observedAt),
      'valueSource': serializer.toJson<String>(valueSource),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SpeciesAttributeValue copyWith({
    String? id,
    String? workspaceId,
    String? animalProfileId,
    String? attributeDefinitionId,
    String? valueJson,
    Value<String?> unitCode = const Value.absent(),
    Value<DateTime?> observedAt = const Value.absent(),
    String? valueSource,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => SpeciesAttributeValue(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    animalProfileId: animalProfileId ?? this.animalProfileId,
    attributeDefinitionId: attributeDefinitionId ?? this.attributeDefinitionId,
    valueJson: valueJson ?? this.valueJson,
    unitCode: unitCode.present ? unitCode.value : this.unitCode,
    observedAt: observedAt.present ? observedAt.value : this.observedAt,
    valueSource: valueSource ?? this.valueSource,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  SpeciesAttributeValue copyWithCompanion(
    SpeciesAttributeValuesCompanion data,
  ) {
    return SpeciesAttributeValue(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      animalProfileId: data.animalProfileId.present
          ? data.animalProfileId.value
          : this.animalProfileId,
      attributeDefinitionId: data.attributeDefinitionId.present
          ? data.attributeDefinitionId.value
          : this.attributeDefinitionId,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      unitCode: data.unitCode.present ? data.unitCode.value : this.unitCode,
      observedAt: data.observedAt.present
          ? data.observedAt.value
          : this.observedAt,
      valueSource: data.valueSource.present
          ? data.valueSource.value
          : this.valueSource,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesAttributeValue(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('attributeDefinitionId: $attributeDefinitionId, ')
          ..write('valueJson: $valueJson, ')
          ..write('unitCode: $unitCode, ')
          ..write('observedAt: $observedAt, ')
          ..write('valueSource: $valueSource, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    animalProfileId,
    attributeDefinitionId,
    valueJson,
    unitCode,
    observedAt,
    valueSource,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesAttributeValue &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.animalProfileId == this.animalProfileId &&
          other.attributeDefinitionId == this.attributeDefinitionId &&
          other.valueJson == this.valueJson &&
          other.unitCode == this.unitCode &&
          other.observedAt == this.observedAt &&
          other.valueSource == this.valueSource &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SpeciesAttributeValuesCompanion
    extends UpdateCompanion<SpeciesAttributeValue> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> animalProfileId;
  final Value<String> attributeDefinitionId;
  final Value<String> valueJson;
  final Value<String?> unitCode;
  final Value<DateTime?> observedAt;
  final Value<String> valueSource;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const SpeciesAttributeValuesCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.animalProfileId = const Value.absent(),
    this.attributeDefinitionId = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.unitCode = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.valueSource = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeciesAttributeValuesCompanion.insert({
    required String id,
    required String workspaceId,
    required String animalProfileId,
    required String attributeDefinitionId,
    required String valueJson,
    this.unitCode = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.valueSource = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       animalProfileId = Value(animalProfileId),
       attributeDefinitionId = Value(attributeDefinitionId),
       valueJson = Value(valueJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SpeciesAttributeValue> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? animalProfileId,
    Expression<String>? attributeDefinitionId,
    Expression<String>? valueJson,
    Expression<String>? unitCode,
    Expression<DateTime>? observedAt,
    Expression<String>? valueSource,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (animalProfileId != null) 'animal_profile_id': animalProfileId,
      if (attributeDefinitionId != null)
        'attribute_definition_id': attributeDefinitionId,
      if (valueJson != null) 'value_json': valueJson,
      if (unitCode != null) 'unit_code': unitCode,
      if (observedAt != null) 'observed_at': observedAt,
      if (valueSource != null) 'value_source': valueSource,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeciesAttributeValuesCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? animalProfileId,
    Value<String>? attributeDefinitionId,
    Value<String>? valueJson,
    Value<String?>? unitCode,
    Value<DateTime?>? observedAt,
    Value<String>? valueSource,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return SpeciesAttributeValuesCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      animalProfileId: animalProfileId ?? this.animalProfileId,
      attributeDefinitionId:
          attributeDefinitionId ?? this.attributeDefinitionId,
      valueJson: valueJson ?? this.valueJson,
      unitCode: unitCode ?? this.unitCode,
      observedAt: observedAt ?? this.observedAt,
      valueSource: valueSource ?? this.valueSource,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (animalProfileId.present) {
      map['animal_profile_id'] = Variable<String>(animalProfileId.value);
    }
    if (attributeDefinitionId.present) {
      map['attribute_definition_id'] = Variable<String>(
        attributeDefinitionId.value,
      );
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (unitCode.present) {
      map['unit_code'] = Variable<String>(unitCode.value);
    }
    if (observedAt.present) {
      map['observed_at'] = Variable<DateTime>(observedAt.value);
    }
    if (valueSource.present) {
      map['value_source'] = Variable<String>(valueSource.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesAttributeValuesCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('attributeDefinitionId: $attributeDefinitionId, ')
          ..write('valueJson: $valueJson, ')
          ..write('unitCode: $unitCode, ')
          ..write('observedAt: $observedAt, ')
          ..write('valueSource: $valueSource, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareSchedulesTable extends CareSchedules
    with TableInfo<$CareSchedulesTable, CareSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _animalProfileIdMeta = const VerificationMeta(
    'animalProfileId',
  );
  @override
  late final GeneratedColumn<String> animalProfileId = GeneratedColumn<String>(
    'animal_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _careTypeMeta = const VerificationMeta(
    'careType',
  );
  @override
  late final GeneratedColumn<String> careType = GeneratedColumn<String>(
    'care_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceTypeMeta = const VerificationMeta(
    'recurrenceType',
  );
  @override
  late final GeneratedColumn<String> recurrenceType = GeneratedColumn<String>(
    'recurrence_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('once'),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueAtMeta = const VerificationMeta(
    'nextDueAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueAt = GeneratedColumn<DateTime>(
    'next_due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    animalProfileId,
    title,
    careType,
    instructions,
    recurrenceType,
    intervalDays,
    scheduledAt,
    nextDueAt,
    isActive,
    lastCompletedAt,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('animal_profile_id')) {
      context.handle(
        _animalProfileIdMeta,
        animalProfileId.isAcceptableOrUnknown(
          data['animal_profile_id']!,
          _animalProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_animalProfileIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('care_type')) {
      context.handle(
        _careTypeMeta,
        careType.isAcceptableOrUnknown(data['care_type']!, _careTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_careTypeMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_type')) {
      context.handle(
        _recurrenceTypeMeta,
        recurrenceType.isAcceptableOrUnknown(
          data['recurrence_type']!,
          _recurrenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('next_due_at')) {
      context.handle(
        _nextDueAtMeta,
        nextDueAt.isAcceptableOrUnknown(data['next_due_at']!, _nextDueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_nextDueAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      animalProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_profile_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      careType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}care_type'],
      )!,
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      recurrenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_type'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      nextDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $CareSchedulesTable createAlias(String alias) {
    return $CareSchedulesTable(attachedDatabase, alias);
  }
}

class CareSchedule extends DataClass implements Insertable<CareSchedule> {
  final String id;
  final String workspaceId;
  final String animalProfileId;
  final String title;
  final String careType;
  final String? instructions;
  final String recurrenceType;
  final int? intervalDays;
  final DateTime scheduledAt;
  final DateTime nextDueAt;
  final bool isActive;
  final DateTime? lastCompletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const CareSchedule({
    required this.id,
    required this.workspaceId,
    required this.animalProfileId,
    required this.title,
    required this.careType,
    this.instructions,
    required this.recurrenceType,
    this.intervalDays,
    required this.scheduledAt,
    required this.nextDueAt,
    required this.isActive,
    this.lastCompletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['animal_profile_id'] = Variable<String>(animalProfileId);
    map['title'] = Variable<String>(title);
    map['care_type'] = Variable<String>(careType);
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['recurrence_type'] = Variable<String>(recurrenceType);
    if (!nullToAbsent || intervalDays != null) {
      map['interval_days'] = Variable<int>(intervalDays);
    }
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['next_due_at'] = Variable<DateTime>(nextDueAt);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastCompletedAt != null) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  CareSchedulesCompanion toCompanion(bool nullToAbsent) {
    return CareSchedulesCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      animalProfileId: Value(animalProfileId),
      title: Value(title),
      careType: Value(careType),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      recurrenceType: Value(recurrenceType),
      intervalDays: intervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalDays),
      scheduledAt: Value(scheduledAt),
      nextDueAt: Value(nextDueAt),
      isActive: Value(isActive),
      lastCompletedAt: lastCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCompletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory CareSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareSchedule(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      animalProfileId: serializer.fromJson<String>(json['animalProfileId']),
      title: serializer.fromJson<String>(json['title']),
      careType: serializer.fromJson<String>(json['careType']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      recurrenceType: serializer.fromJson<String>(json['recurrenceType']),
      intervalDays: serializer.fromJson<int?>(json['intervalDays']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      nextDueAt: serializer.fromJson<DateTime>(json['nextDueAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastCompletedAt: serializer.fromJson<DateTime?>(json['lastCompletedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'animalProfileId': serializer.toJson<String>(animalProfileId),
      'title': serializer.toJson<String>(title),
      'careType': serializer.toJson<String>(careType),
      'instructions': serializer.toJson<String?>(instructions),
      'recurrenceType': serializer.toJson<String>(recurrenceType),
      'intervalDays': serializer.toJson<int?>(intervalDays),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'nextDueAt': serializer.toJson<DateTime>(nextDueAt),
      'isActive': serializer.toJson<bool>(isActive),
      'lastCompletedAt': serializer.toJson<DateTime?>(lastCompletedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  CareSchedule copyWith({
    String? id,
    String? workspaceId,
    String? animalProfileId,
    String? title,
    String? careType,
    Value<String?> instructions = const Value.absent(),
    String? recurrenceType,
    Value<int?> intervalDays = const Value.absent(),
    DateTime? scheduledAt,
    DateTime? nextDueAt,
    bool? isActive,
    Value<DateTime?> lastCompletedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => CareSchedule(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    animalProfileId: animalProfileId ?? this.animalProfileId,
    title: title ?? this.title,
    careType: careType ?? this.careType,
    instructions: instructions.present ? instructions.value : this.instructions,
    recurrenceType: recurrenceType ?? this.recurrenceType,
    intervalDays: intervalDays.present ? intervalDays.value : this.intervalDays,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    nextDueAt: nextDueAt ?? this.nextDueAt,
    isActive: isActive ?? this.isActive,
    lastCompletedAt: lastCompletedAt.present
        ? lastCompletedAt.value
        : this.lastCompletedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  CareSchedule copyWithCompanion(CareSchedulesCompanion data) {
    return CareSchedule(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      animalProfileId: data.animalProfileId.present
          ? data.animalProfileId.value
          : this.animalProfileId,
      title: data.title.present ? data.title.value : this.title,
      careType: data.careType.present ? data.careType.value : this.careType,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      nextDueAt: data.nextDueAt.present ? data.nextDueAt.value : this.nextDueAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastCompletedAt: data.lastCompletedAt.present
          ? data.lastCompletedAt.value
          : this.lastCompletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareSchedule(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('title: $title, ')
          ..write('careType: $careType, ')
          ..write('instructions: $instructions, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('nextDueAt: $nextDueAt, ')
          ..write('isActive: $isActive, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    animalProfileId,
    title,
    careType,
    instructions,
    recurrenceType,
    intervalDays,
    scheduledAt,
    nextDueAt,
    isActive,
    lastCompletedAt,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareSchedule &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.animalProfileId == this.animalProfileId &&
          other.title == this.title &&
          other.careType == this.careType &&
          other.instructions == this.instructions &&
          other.recurrenceType == this.recurrenceType &&
          other.intervalDays == this.intervalDays &&
          other.scheduledAt == this.scheduledAt &&
          other.nextDueAt == this.nextDueAt &&
          other.isActive == this.isActive &&
          other.lastCompletedAt == this.lastCompletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class CareSchedulesCompanion extends UpdateCompanion<CareSchedule> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> animalProfileId;
  final Value<String> title;
  final Value<String> careType;
  final Value<String?> instructions;
  final Value<String> recurrenceType;
  final Value<int?> intervalDays;
  final Value<DateTime> scheduledAt;
  final Value<DateTime> nextDueAt;
  final Value<bool> isActive;
  final Value<DateTime?> lastCompletedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const CareSchedulesCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.animalProfileId = const Value.absent(),
    this.title = const Value.absent(),
    this.careType = const Value.absent(),
    this.instructions = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.nextDueAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareSchedulesCompanion.insert({
    required String id,
    required String workspaceId,
    required String animalProfileId,
    required String title,
    required String careType,
    this.instructions = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.intervalDays = const Value.absent(),
    required DateTime scheduledAt,
    required DateTime nextDueAt,
    this.isActive = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       animalProfileId = Value(animalProfileId),
       title = Value(title),
       careType = Value(careType),
       scheduledAt = Value(scheduledAt),
       nextDueAt = Value(nextDueAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CareSchedule> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? animalProfileId,
    Expression<String>? title,
    Expression<String>? careType,
    Expression<String>? instructions,
    Expression<String>? recurrenceType,
    Expression<int>? intervalDays,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? nextDueAt,
    Expression<bool>? isActive,
    Expression<DateTime>? lastCompletedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (animalProfileId != null) 'animal_profile_id': animalProfileId,
      if (title != null) 'title': title,
      if (careType != null) 'care_type': careType,
      if (instructions != null) 'instructions': instructions,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (nextDueAt != null) 'next_due_at': nextDueAt,
      if (isActive != null) 'is_active': isActive,
      if (lastCompletedAt != null) 'last_completed_at': lastCompletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareSchedulesCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? animalProfileId,
    Value<String>? title,
    Value<String>? careType,
    Value<String?>? instructions,
    Value<String>? recurrenceType,
    Value<int?>? intervalDays,
    Value<DateTime>? scheduledAt,
    Value<DateTime>? nextDueAt,
    Value<bool>? isActive,
    Value<DateTime?>? lastCompletedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return CareSchedulesCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      animalProfileId: animalProfileId ?? this.animalProfileId,
      title: title ?? this.title,
      careType: careType ?? this.careType,
      instructions: instructions ?? this.instructions,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      intervalDays: intervalDays ?? this.intervalDays,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      nextDueAt: nextDueAt ?? this.nextDueAt,
      isActive: isActive ?? this.isActive,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (animalProfileId.present) {
      map['animal_profile_id'] = Variable<String>(animalProfileId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (careType.present) {
      map['care_type'] = Variable<String>(careType.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(recurrenceType.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (nextDueAt.present) {
      map['next_due_at'] = Variable<DateTime>(nextDueAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastCompletedAt.present) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('title: $title, ')
          ..write('careType: $careType, ')
          ..write('instructions: $instructions, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('nextDueAt: $nextDueAt, ')
          ..write('isActive: $isActive, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareRecordsTable extends CareRecords
    with TableInfo<$CareRecordsTable, CareRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _animalProfileIdMeta = const VerificationMeta(
    'animalProfileId',
  );
  @override
  late final GeneratedColumn<String> animalProfileId = GeneratedColumn<String>(
    'animal_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _scheduleIdMeta = const VerificationMeta(
    'scheduleId',
  );
  @override
  late final GeneratedColumn<String> scheduleId = GeneratedColumn<String>(
    'schedule_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES care_schedules (id)',
    ),
  );
  static const VerificationMeta _careTypeMeta = const VerificationMeta(
    'careType',
  );
  @override
  late final GeneratedColumn<String> careType = GeneratedColumn<String>(
    'care_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _performedAtMeta = const VerificationMeta(
    'performedAt',
  );
  @override
  late final GeneratedColumn<DateTime> performedAt = GeneratedColumn<DateTime>(
    'performed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledForMeta = const VerificationMeta(
    'scheduledFor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
    'scheduled_for',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityValueMeta = const VerificationMeta(
    'quantityValue',
  );
  @override
  late final GeneratedColumn<double> quantityValue = GeneratedColumn<double>(
    'quantity_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityUnitMeta = const VerificationMeta(
    'quantityUnit',
  );
  @override
  late final GeneratedColumn<String> quantityUnit = GeneratedColumn<String>(
    'quantity_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    animalProfileId,
    scheduleId,
    careType,
    title,
    performedAt,
    scheduledFor,
    quantityValue,
    quantityUnit,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('animal_profile_id')) {
      context.handle(
        _animalProfileIdMeta,
        animalProfileId.isAcceptableOrUnknown(
          data['animal_profile_id']!,
          _animalProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_animalProfileIdMeta);
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
        _scheduleIdMeta,
        scheduleId.isAcceptableOrUnknown(data['schedule_id']!, _scheduleIdMeta),
      );
    }
    if (data.containsKey('care_type')) {
      context.handle(
        _careTypeMeta,
        careType.isAcceptableOrUnknown(data['care_type']!, _careTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_careTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('performed_at')) {
      context.handle(
        _performedAtMeta,
        performedAt.isAcceptableOrUnknown(
          data['performed_at']!,
          _performedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_performedAtMeta);
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
        _scheduledForMeta,
        scheduledFor.isAcceptableOrUnknown(
          data['scheduled_for']!,
          _scheduledForMeta,
        ),
      );
    }
    if (data.containsKey('quantity_value')) {
      context.handle(
        _quantityValueMeta,
        quantityValue.isAcceptableOrUnknown(
          data['quantity_value']!,
          _quantityValueMeta,
        ),
      );
    }
    if (data.containsKey('quantity_unit')) {
      context.handle(
        _quantityUnitMeta,
        quantityUnit.isAcceptableOrUnknown(
          data['quantity_unit']!,
          _quantityUnitMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      animalProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_profile_id'],
      )!,
      scheduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_id'],
      ),
      careType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}care_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      performedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}performed_at'],
      )!,
      scheduledFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_for'],
      ),
      quantityValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_value'],
      ),
      quantityUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantity_unit'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CareRecordsTable createAlias(String alias) {
    return $CareRecordsTable(attachedDatabase, alias);
  }
}

class CareRecord extends DataClass implements Insertable<CareRecord> {
  final String id;
  final String workspaceId;
  final String animalProfileId;
  final String? scheduleId;
  final String careType;
  final String title;
  final DateTime performedAt;
  final DateTime? scheduledFor;
  final double? quantityValue;
  final String? quantityUnit;
  final String? notes;
  final DateTime createdAt;
  const CareRecord({
    required this.id,
    required this.workspaceId,
    required this.animalProfileId,
    this.scheduleId,
    required this.careType,
    required this.title,
    required this.performedAt,
    this.scheduledFor,
    this.quantityValue,
    this.quantityUnit,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['animal_profile_id'] = Variable<String>(animalProfileId);
    if (!nullToAbsent || scheduleId != null) {
      map['schedule_id'] = Variable<String>(scheduleId);
    }
    map['care_type'] = Variable<String>(careType);
    map['title'] = Variable<String>(title);
    map['performed_at'] = Variable<DateTime>(performedAt);
    if (!nullToAbsent || scheduledFor != null) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    }
    if (!nullToAbsent || quantityValue != null) {
      map['quantity_value'] = Variable<double>(quantityValue);
    }
    if (!nullToAbsent || quantityUnit != null) {
      map['quantity_unit'] = Variable<String>(quantityUnit);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CareRecordsCompanion toCompanion(bool nullToAbsent) {
    return CareRecordsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      animalProfileId: Value(animalProfileId),
      scheduleId: scheduleId == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleId),
      careType: Value(careType),
      title: Value(title),
      performedAt: Value(performedAt),
      scheduledFor: scheduledFor == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledFor),
      quantityValue: quantityValue == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityValue),
      quantityUnit: quantityUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityUnit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory CareRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareRecord(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      animalProfileId: serializer.fromJson<String>(json['animalProfileId']),
      scheduleId: serializer.fromJson<String?>(json['scheduleId']),
      careType: serializer.fromJson<String>(json['careType']),
      title: serializer.fromJson<String>(json['title']),
      performedAt: serializer.fromJson<DateTime>(json['performedAt']),
      scheduledFor: serializer.fromJson<DateTime?>(json['scheduledFor']),
      quantityValue: serializer.fromJson<double?>(json['quantityValue']),
      quantityUnit: serializer.fromJson<String?>(json['quantityUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'animalProfileId': serializer.toJson<String>(animalProfileId),
      'scheduleId': serializer.toJson<String?>(scheduleId),
      'careType': serializer.toJson<String>(careType),
      'title': serializer.toJson<String>(title),
      'performedAt': serializer.toJson<DateTime>(performedAt),
      'scheduledFor': serializer.toJson<DateTime?>(scheduledFor),
      'quantityValue': serializer.toJson<double?>(quantityValue),
      'quantityUnit': serializer.toJson<String?>(quantityUnit),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CareRecord copyWith({
    String? id,
    String? workspaceId,
    String? animalProfileId,
    Value<String?> scheduleId = const Value.absent(),
    String? careType,
    String? title,
    DateTime? performedAt,
    Value<DateTime?> scheduledFor = const Value.absent(),
    Value<double?> quantityValue = const Value.absent(),
    Value<String?> quantityUnit = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => CareRecord(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    animalProfileId: animalProfileId ?? this.animalProfileId,
    scheduleId: scheduleId.present ? scheduleId.value : this.scheduleId,
    careType: careType ?? this.careType,
    title: title ?? this.title,
    performedAt: performedAt ?? this.performedAt,
    scheduledFor: scheduledFor.present ? scheduledFor.value : this.scheduledFor,
    quantityValue: quantityValue.present
        ? quantityValue.value
        : this.quantityValue,
    quantityUnit: quantityUnit.present ? quantityUnit.value : this.quantityUnit,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  CareRecord copyWithCompanion(CareRecordsCompanion data) {
    return CareRecord(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      animalProfileId: data.animalProfileId.present
          ? data.animalProfileId.value
          : this.animalProfileId,
      scheduleId: data.scheduleId.present
          ? data.scheduleId.value
          : this.scheduleId,
      careType: data.careType.present ? data.careType.value : this.careType,
      title: data.title.present ? data.title.value : this.title,
      performedAt: data.performedAt.present
          ? data.performedAt.value
          : this.performedAt,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
      quantityValue: data.quantityValue.present
          ? data.quantityValue.value
          : this.quantityValue,
      quantityUnit: data.quantityUnit.present
          ? data.quantityUnit.value
          : this.quantityUnit,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareRecord(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('careType: $careType, ')
          ..write('title: $title, ')
          ..write('performedAt: $performedAt, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('quantityValue: $quantityValue, ')
          ..write('quantityUnit: $quantityUnit, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    animalProfileId,
    scheduleId,
    careType,
    title,
    performedAt,
    scheduledFor,
    quantityValue,
    quantityUnit,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareRecord &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.animalProfileId == this.animalProfileId &&
          other.scheduleId == this.scheduleId &&
          other.careType == this.careType &&
          other.title == this.title &&
          other.performedAt == this.performedAt &&
          other.scheduledFor == this.scheduledFor &&
          other.quantityValue == this.quantityValue &&
          other.quantityUnit == this.quantityUnit &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CareRecordsCompanion extends UpdateCompanion<CareRecord> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> animalProfileId;
  final Value<String?> scheduleId;
  final Value<String> careType;
  final Value<String> title;
  final Value<DateTime> performedAt;
  final Value<DateTime?> scheduledFor;
  final Value<double?> quantityValue;
  final Value<String?> quantityUnit;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CareRecordsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.animalProfileId = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.careType = const Value.absent(),
    this.title = const Value.absent(),
    this.performedAt = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.quantityValue = const Value.absent(),
    this.quantityUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareRecordsCompanion.insert({
    required String id,
    required String workspaceId,
    required String animalProfileId,
    this.scheduleId = const Value.absent(),
    required String careType,
    required String title,
    required DateTime performedAt,
    this.scheduledFor = const Value.absent(),
    this.quantityValue = const Value.absent(),
    this.quantityUnit = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       animalProfileId = Value(animalProfileId),
       careType = Value(careType),
       title = Value(title),
       performedAt = Value(performedAt),
       createdAt = Value(createdAt);
  static Insertable<CareRecord> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? animalProfileId,
    Expression<String>? scheduleId,
    Expression<String>? careType,
    Expression<String>? title,
    Expression<DateTime>? performedAt,
    Expression<DateTime>? scheduledFor,
    Expression<double>? quantityValue,
    Expression<String>? quantityUnit,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (animalProfileId != null) 'animal_profile_id': animalProfileId,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (careType != null) 'care_type': careType,
      if (title != null) 'title': title,
      if (performedAt != null) 'performed_at': performedAt,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (quantityValue != null) 'quantity_value': quantityValue,
      if (quantityUnit != null) 'quantity_unit': quantityUnit,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? animalProfileId,
    Value<String?>? scheduleId,
    Value<String>? careType,
    Value<String>? title,
    Value<DateTime>? performedAt,
    Value<DateTime?>? scheduledFor,
    Value<double?>? quantityValue,
    Value<String?>? quantityUnit,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CareRecordsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      animalProfileId: animalProfileId ?? this.animalProfileId,
      scheduleId: scheduleId ?? this.scheduleId,
      careType: careType ?? this.careType,
      title: title ?? this.title,
      performedAt: performedAt ?? this.performedAt,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      quantityValue: quantityValue ?? this.quantityValue,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (animalProfileId.present) {
      map['animal_profile_id'] = Variable<String>(animalProfileId.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<String>(scheduleId.value);
    }
    if (careType.present) {
      map['care_type'] = Variable<String>(careType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (performedAt.present) {
      map['performed_at'] = Variable<DateTime>(performedAt.value);
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (quantityValue.present) {
      map['quantity_value'] = Variable<double>(quantityValue.value);
    }
    if (quantityUnit.present) {
      map['quantity_unit'] = Variable<String>(quantityUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareRecordsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('careType: $careType, ')
          ..write('title: $title, ')
          ..write('performedAt: $performedAt, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('quantityValue: $quantityValue, ')
          ..write('quantityUnit: $quantityUnit, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IndividualDetailsTable extends IndividualDetails
    with TableInfo<$IndividualDetailsTable, IndividualDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IndividualDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _animalProfileIdMeta = const VerificationMeta(
    'animalProfileId',
  );
  @override
  late final GeneratedColumn<String> animalProfileId = GeneratedColumn<String>(
    'animal_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _sexCodeMeta = const VerificationMeta(
    'sexCode',
  );
  @override
  late final GeneratedColumn<String> sexCode = GeneratedColumn<String>(
    'sex_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDatePrecisionMeta =
      const VerificationMeta('birthDatePrecision');
  @override
  late final GeneratedColumn<String> birthDatePrecision =
      GeneratedColumn<String>(
        'birth_date_precision',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _acquiredAtMeta = const VerificationMeta(
    'acquiredAt',
  );
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
    'acquired_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lifeStageCodeMeta = const VerificationMeta(
    'lifeStageCode',
  );
  @override
  late final GeneratedColumn<String> lifeStageCode = GeneratedColumn<String>(
    'life_stage_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lifeStageSourceMeta = const VerificationMeta(
    'lifeStageSource',
  );
  @override
  late final GeneratedColumn<String> lifeStageSource = GeneratedColumn<String>(
    'life_stage_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    animalProfileId,
    sexCode,
    birthDate,
    birthDatePrecision,
    acquiredAt,
    lifeStageCode,
    lifeStageSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'individual_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<IndividualDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('animal_profile_id')) {
      context.handle(
        _animalProfileIdMeta,
        animalProfileId.isAcceptableOrUnknown(
          data['animal_profile_id']!,
          _animalProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_animalProfileIdMeta);
    }
    if (data.containsKey('sex_code')) {
      context.handle(
        _sexCodeMeta,
        sexCode.isAcceptableOrUnknown(data['sex_code']!, _sexCodeMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('birth_date_precision')) {
      context.handle(
        _birthDatePrecisionMeta,
        birthDatePrecision.isAcceptableOrUnknown(
          data['birth_date_precision']!,
          _birthDatePrecisionMeta,
        ),
      );
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
        _acquiredAtMeta,
        acquiredAt.isAcceptableOrUnknown(data['acquired_at']!, _acquiredAtMeta),
      );
    }
    if (data.containsKey('life_stage_code')) {
      context.handle(
        _lifeStageCodeMeta,
        lifeStageCode.isAcceptableOrUnknown(
          data['life_stage_code']!,
          _lifeStageCodeMeta,
        ),
      );
    }
    if (data.containsKey('life_stage_source')) {
      context.handle(
        _lifeStageSourceMeta,
        lifeStageSource.isAcceptableOrUnknown(
          data['life_stage_source']!,
          _lifeStageSourceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {animalProfileId};
  @override
  IndividualDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IndividualDetail(
      animalProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_profile_id'],
      )!,
      sexCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex_code'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      birthDatePrecision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_date_precision'],
      ),
      acquiredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquired_at'],
      ),
      lifeStageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}life_stage_code'],
      ),
      lifeStageSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}life_stage_source'],
      ),
    );
  }

  @override
  $IndividualDetailsTable createAlias(String alias) {
    return $IndividualDetailsTable(attachedDatabase, alias);
  }
}

class IndividualDetail extends DataClass
    implements Insertable<IndividualDetail> {
  final String animalProfileId;
  final String? sexCode;
  final DateTime? birthDate;
  final String? birthDatePrecision;
  final DateTime? acquiredAt;
  final String? lifeStageCode;
  final String? lifeStageSource;
  const IndividualDetail({
    required this.animalProfileId,
    this.sexCode,
    this.birthDate,
    this.birthDatePrecision,
    this.acquiredAt,
    this.lifeStageCode,
    this.lifeStageSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['animal_profile_id'] = Variable<String>(animalProfileId);
    if (!nullToAbsent || sexCode != null) {
      map['sex_code'] = Variable<String>(sexCode);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || birthDatePrecision != null) {
      map['birth_date_precision'] = Variable<String>(birthDatePrecision);
    }
    if (!nullToAbsent || acquiredAt != null) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt);
    }
    if (!nullToAbsent || lifeStageCode != null) {
      map['life_stage_code'] = Variable<String>(lifeStageCode);
    }
    if (!nullToAbsent || lifeStageSource != null) {
      map['life_stage_source'] = Variable<String>(lifeStageSource);
    }
    return map;
  }

  IndividualDetailsCompanion toCompanion(bool nullToAbsent) {
    return IndividualDetailsCompanion(
      animalProfileId: Value(animalProfileId),
      sexCode: sexCode == null && nullToAbsent
          ? const Value.absent()
          : Value(sexCode),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      birthDatePrecision: birthDatePrecision == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDatePrecision),
      acquiredAt: acquiredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acquiredAt),
      lifeStageCode: lifeStageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeStageCode),
      lifeStageSource: lifeStageSource == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeStageSource),
    );
  }

  factory IndividualDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IndividualDetail(
      animalProfileId: serializer.fromJson<String>(json['animalProfileId']),
      sexCode: serializer.fromJson<String?>(json['sexCode']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      birthDatePrecision: serializer.fromJson<String?>(
        json['birthDatePrecision'],
      ),
      acquiredAt: serializer.fromJson<DateTime?>(json['acquiredAt']),
      lifeStageCode: serializer.fromJson<String?>(json['lifeStageCode']),
      lifeStageSource: serializer.fromJson<String?>(json['lifeStageSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'animalProfileId': serializer.toJson<String>(animalProfileId),
      'sexCode': serializer.toJson<String?>(sexCode),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'birthDatePrecision': serializer.toJson<String?>(birthDatePrecision),
      'acquiredAt': serializer.toJson<DateTime?>(acquiredAt),
      'lifeStageCode': serializer.toJson<String?>(lifeStageCode),
      'lifeStageSource': serializer.toJson<String?>(lifeStageSource),
    };
  }

  IndividualDetail copyWith({
    String? animalProfileId,
    Value<String?> sexCode = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    Value<String?> birthDatePrecision = const Value.absent(),
    Value<DateTime?> acquiredAt = const Value.absent(),
    Value<String?> lifeStageCode = const Value.absent(),
    Value<String?> lifeStageSource = const Value.absent(),
  }) => IndividualDetail(
    animalProfileId: animalProfileId ?? this.animalProfileId,
    sexCode: sexCode.present ? sexCode.value : this.sexCode,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    birthDatePrecision: birthDatePrecision.present
        ? birthDatePrecision.value
        : this.birthDatePrecision,
    acquiredAt: acquiredAt.present ? acquiredAt.value : this.acquiredAt,
    lifeStageCode: lifeStageCode.present
        ? lifeStageCode.value
        : this.lifeStageCode,
    lifeStageSource: lifeStageSource.present
        ? lifeStageSource.value
        : this.lifeStageSource,
  );
  IndividualDetail copyWithCompanion(IndividualDetailsCompanion data) {
    return IndividualDetail(
      animalProfileId: data.animalProfileId.present
          ? data.animalProfileId.value
          : this.animalProfileId,
      sexCode: data.sexCode.present ? data.sexCode.value : this.sexCode,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      birthDatePrecision: data.birthDatePrecision.present
          ? data.birthDatePrecision.value
          : this.birthDatePrecision,
      acquiredAt: data.acquiredAt.present
          ? data.acquiredAt.value
          : this.acquiredAt,
      lifeStageCode: data.lifeStageCode.present
          ? data.lifeStageCode.value
          : this.lifeStageCode,
      lifeStageSource: data.lifeStageSource.present
          ? data.lifeStageSource.value
          : this.lifeStageSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IndividualDetail(')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('sexCode: $sexCode, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthDatePrecision: $birthDatePrecision, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('lifeStageCode: $lifeStageCode, ')
          ..write('lifeStageSource: $lifeStageSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    animalProfileId,
    sexCode,
    birthDate,
    birthDatePrecision,
    acquiredAt,
    lifeStageCode,
    lifeStageSource,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndividualDetail &&
          other.animalProfileId == this.animalProfileId &&
          other.sexCode == this.sexCode &&
          other.birthDate == this.birthDate &&
          other.birthDatePrecision == this.birthDatePrecision &&
          other.acquiredAt == this.acquiredAt &&
          other.lifeStageCode == this.lifeStageCode &&
          other.lifeStageSource == this.lifeStageSource);
}

class IndividualDetailsCompanion extends UpdateCompanion<IndividualDetail> {
  final Value<String> animalProfileId;
  final Value<String?> sexCode;
  final Value<DateTime?> birthDate;
  final Value<String?> birthDatePrecision;
  final Value<DateTime?> acquiredAt;
  final Value<String?> lifeStageCode;
  final Value<String?> lifeStageSource;
  final Value<int> rowid;
  const IndividualDetailsCompanion({
    this.animalProfileId = const Value.absent(),
    this.sexCode = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthDatePrecision = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.lifeStageCode = const Value.absent(),
    this.lifeStageSource = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IndividualDetailsCompanion.insert({
    required String animalProfileId,
    this.sexCode = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthDatePrecision = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.lifeStageCode = const Value.absent(),
    this.lifeStageSource = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : animalProfileId = Value(animalProfileId);
  static Insertable<IndividualDetail> custom({
    Expression<String>? animalProfileId,
    Expression<String>? sexCode,
    Expression<DateTime>? birthDate,
    Expression<String>? birthDatePrecision,
    Expression<DateTime>? acquiredAt,
    Expression<String>? lifeStageCode,
    Expression<String>? lifeStageSource,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (animalProfileId != null) 'animal_profile_id': animalProfileId,
      if (sexCode != null) 'sex_code': sexCode,
      if (birthDate != null) 'birth_date': birthDate,
      if (birthDatePrecision != null)
        'birth_date_precision': birthDatePrecision,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
      if (lifeStageCode != null) 'life_stage_code': lifeStageCode,
      if (lifeStageSource != null) 'life_stage_source': lifeStageSource,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IndividualDetailsCompanion copyWith({
    Value<String>? animalProfileId,
    Value<String?>? sexCode,
    Value<DateTime?>? birthDate,
    Value<String?>? birthDatePrecision,
    Value<DateTime?>? acquiredAt,
    Value<String?>? lifeStageCode,
    Value<String?>? lifeStageSource,
    Value<int>? rowid,
  }) {
    return IndividualDetailsCompanion(
      animalProfileId: animalProfileId ?? this.animalProfileId,
      sexCode: sexCode ?? this.sexCode,
      birthDate: birthDate ?? this.birthDate,
      birthDatePrecision: birthDatePrecision ?? this.birthDatePrecision,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      lifeStageCode: lifeStageCode ?? this.lifeStageCode,
      lifeStageSource: lifeStageSource ?? this.lifeStageSource,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (animalProfileId.present) {
      map['animal_profile_id'] = Variable<String>(animalProfileId.value);
    }
    if (sexCode.present) {
      map['sex_code'] = Variable<String>(sexCode.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (birthDatePrecision.present) {
      map['birth_date_precision'] = Variable<String>(birthDatePrecision.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    if (lifeStageCode.present) {
      map['life_stage_code'] = Variable<String>(lifeStageCode.value);
    }
    if (lifeStageSource.present) {
      map['life_stage_source'] = Variable<String>(lifeStageSource.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IndividualDetailsCompanion(')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('sexCode: $sexCode, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthDatePrecision: $birthDatePrecision, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('lifeStageCode: $lifeStageCode, ')
          ..write('lifeStageSource: $lifeStageSource, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupDetailsTable extends GroupDetails
    with TableInfo<$GroupDetailsTable, GroupDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _animalProfileIdMeta = const VerificationMeta(
    'animalProfileId',
  );
  @override
  late final GeneratedColumn<String> animalProfileId = GeneratedColumn<String>(
    'animal_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _groupPurposeMeta = const VerificationMeta(
    'groupPurpose',
  );
  @override
  late final GeneratedColumn<String> groupPurpose = GeneratedColumn<String>(
    'group_purpose',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memberTrackingModeMeta =
      const VerificationMeta('memberTrackingMode');
  @override
  late final GeneratedColumn<String> memberTrackingMode =
      GeneratedColumn<String>(
        'member_tracking_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reportedCountMeta = const VerificationMeta(
    'reportedCount',
  );
  @override
  late final GeneratedColumn<int> reportedCount = GeneratedColumn<int>(
    'reported_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countObservedAtMeta = const VerificationMeta(
    'countObservedAt',
  );
  @override
  late final GeneratedColumn<DateTime> countObservedAt =
      GeneratedColumn<DateTime>(
        'count_observed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _countNoteMeta = const VerificationMeta(
    'countNote',
  );
  @override
  late final GeneratedColumn<String> countNote = GeneratedColumn<String>(
    'count_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    animalProfileId,
    groupPurpose,
    memberTrackingMode,
    reportedCount,
    countObservedAt,
    countNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('animal_profile_id')) {
      context.handle(
        _animalProfileIdMeta,
        animalProfileId.isAcceptableOrUnknown(
          data['animal_profile_id']!,
          _animalProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_animalProfileIdMeta);
    }
    if (data.containsKey('group_purpose')) {
      context.handle(
        _groupPurposeMeta,
        groupPurpose.isAcceptableOrUnknown(
          data['group_purpose']!,
          _groupPurposeMeta,
        ),
      );
    }
    if (data.containsKey('member_tracking_mode')) {
      context.handle(
        _memberTrackingModeMeta,
        memberTrackingMode.isAcceptableOrUnknown(
          data['member_tracking_mode']!,
          _memberTrackingModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_memberTrackingModeMeta);
    }
    if (data.containsKey('reported_count')) {
      context.handle(
        _reportedCountMeta,
        reportedCount.isAcceptableOrUnknown(
          data['reported_count']!,
          _reportedCountMeta,
        ),
      );
    }
    if (data.containsKey('count_observed_at')) {
      context.handle(
        _countObservedAtMeta,
        countObservedAt.isAcceptableOrUnknown(
          data['count_observed_at']!,
          _countObservedAtMeta,
        ),
      );
    }
    if (data.containsKey('count_note')) {
      context.handle(
        _countNoteMeta,
        countNote.isAcceptableOrUnknown(data['count_note']!, _countNoteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {animalProfileId};
  @override
  GroupDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupDetail(
      animalProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_profile_id'],
      )!,
      groupPurpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_purpose'],
      ),
      memberTrackingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_tracking_mode'],
      )!,
      reportedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reported_count'],
      ),
      countObservedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}count_observed_at'],
      ),
      countNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}count_note'],
      ),
    );
  }

  @override
  $GroupDetailsTable createAlias(String alias) {
    return $GroupDetailsTable(attachedDatabase, alias);
  }
}

class GroupDetail extends DataClass implements Insertable<GroupDetail> {
  final String animalProfileId;
  final String? groupPurpose;
  final String memberTrackingMode;
  final int? reportedCount;
  final DateTime? countObservedAt;
  final String? countNote;
  const GroupDetail({
    required this.animalProfileId,
    this.groupPurpose,
    required this.memberTrackingMode,
    this.reportedCount,
    this.countObservedAt,
    this.countNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['animal_profile_id'] = Variable<String>(animalProfileId);
    if (!nullToAbsent || groupPurpose != null) {
      map['group_purpose'] = Variable<String>(groupPurpose);
    }
    map['member_tracking_mode'] = Variable<String>(memberTrackingMode);
    if (!nullToAbsent || reportedCount != null) {
      map['reported_count'] = Variable<int>(reportedCount);
    }
    if (!nullToAbsent || countObservedAt != null) {
      map['count_observed_at'] = Variable<DateTime>(countObservedAt);
    }
    if (!nullToAbsent || countNote != null) {
      map['count_note'] = Variable<String>(countNote);
    }
    return map;
  }

  GroupDetailsCompanion toCompanion(bool nullToAbsent) {
    return GroupDetailsCompanion(
      animalProfileId: Value(animalProfileId),
      groupPurpose: groupPurpose == null && nullToAbsent
          ? const Value.absent()
          : Value(groupPurpose),
      memberTrackingMode: Value(memberTrackingMode),
      reportedCount: reportedCount == null && nullToAbsent
          ? const Value.absent()
          : Value(reportedCount),
      countObservedAt: countObservedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(countObservedAt),
      countNote: countNote == null && nullToAbsent
          ? const Value.absent()
          : Value(countNote),
    );
  }

  factory GroupDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupDetail(
      animalProfileId: serializer.fromJson<String>(json['animalProfileId']),
      groupPurpose: serializer.fromJson<String?>(json['groupPurpose']),
      memberTrackingMode: serializer.fromJson<String>(
        json['memberTrackingMode'],
      ),
      reportedCount: serializer.fromJson<int?>(json['reportedCount']),
      countObservedAt: serializer.fromJson<DateTime?>(json['countObservedAt']),
      countNote: serializer.fromJson<String?>(json['countNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'animalProfileId': serializer.toJson<String>(animalProfileId),
      'groupPurpose': serializer.toJson<String?>(groupPurpose),
      'memberTrackingMode': serializer.toJson<String>(memberTrackingMode),
      'reportedCount': serializer.toJson<int?>(reportedCount),
      'countObservedAt': serializer.toJson<DateTime?>(countObservedAt),
      'countNote': serializer.toJson<String?>(countNote),
    };
  }

  GroupDetail copyWith({
    String? animalProfileId,
    Value<String?> groupPurpose = const Value.absent(),
    String? memberTrackingMode,
    Value<int?> reportedCount = const Value.absent(),
    Value<DateTime?> countObservedAt = const Value.absent(),
    Value<String?> countNote = const Value.absent(),
  }) => GroupDetail(
    animalProfileId: animalProfileId ?? this.animalProfileId,
    groupPurpose: groupPurpose.present ? groupPurpose.value : this.groupPurpose,
    memberTrackingMode: memberTrackingMode ?? this.memberTrackingMode,
    reportedCount: reportedCount.present
        ? reportedCount.value
        : this.reportedCount,
    countObservedAt: countObservedAt.present
        ? countObservedAt.value
        : this.countObservedAt,
    countNote: countNote.present ? countNote.value : this.countNote,
  );
  GroupDetail copyWithCompanion(GroupDetailsCompanion data) {
    return GroupDetail(
      animalProfileId: data.animalProfileId.present
          ? data.animalProfileId.value
          : this.animalProfileId,
      groupPurpose: data.groupPurpose.present
          ? data.groupPurpose.value
          : this.groupPurpose,
      memberTrackingMode: data.memberTrackingMode.present
          ? data.memberTrackingMode.value
          : this.memberTrackingMode,
      reportedCount: data.reportedCount.present
          ? data.reportedCount.value
          : this.reportedCount,
      countObservedAt: data.countObservedAt.present
          ? data.countObservedAt.value
          : this.countObservedAt,
      countNote: data.countNote.present ? data.countNote.value : this.countNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupDetail(')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('groupPurpose: $groupPurpose, ')
          ..write('memberTrackingMode: $memberTrackingMode, ')
          ..write('reportedCount: $reportedCount, ')
          ..write('countObservedAt: $countObservedAt, ')
          ..write('countNote: $countNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    animalProfileId,
    groupPurpose,
    memberTrackingMode,
    reportedCount,
    countObservedAt,
    countNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupDetail &&
          other.animalProfileId == this.animalProfileId &&
          other.groupPurpose == this.groupPurpose &&
          other.memberTrackingMode == this.memberTrackingMode &&
          other.reportedCount == this.reportedCount &&
          other.countObservedAt == this.countObservedAt &&
          other.countNote == this.countNote);
}

class GroupDetailsCompanion extends UpdateCompanion<GroupDetail> {
  final Value<String> animalProfileId;
  final Value<String?> groupPurpose;
  final Value<String> memberTrackingMode;
  final Value<int?> reportedCount;
  final Value<DateTime?> countObservedAt;
  final Value<String?> countNote;
  final Value<int> rowid;
  const GroupDetailsCompanion({
    this.animalProfileId = const Value.absent(),
    this.groupPurpose = const Value.absent(),
    this.memberTrackingMode = const Value.absent(),
    this.reportedCount = const Value.absent(),
    this.countObservedAt = const Value.absent(),
    this.countNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupDetailsCompanion.insert({
    required String animalProfileId,
    this.groupPurpose = const Value.absent(),
    required String memberTrackingMode,
    this.reportedCount = const Value.absent(),
    this.countObservedAt = const Value.absent(),
    this.countNote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : animalProfileId = Value(animalProfileId),
       memberTrackingMode = Value(memberTrackingMode);
  static Insertable<GroupDetail> custom({
    Expression<String>? animalProfileId,
    Expression<String>? groupPurpose,
    Expression<String>? memberTrackingMode,
    Expression<int>? reportedCount,
    Expression<DateTime>? countObservedAt,
    Expression<String>? countNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (animalProfileId != null) 'animal_profile_id': animalProfileId,
      if (groupPurpose != null) 'group_purpose': groupPurpose,
      if (memberTrackingMode != null)
        'member_tracking_mode': memberTrackingMode,
      if (reportedCount != null) 'reported_count': reportedCount,
      if (countObservedAt != null) 'count_observed_at': countObservedAt,
      if (countNote != null) 'count_note': countNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupDetailsCompanion copyWith({
    Value<String>? animalProfileId,
    Value<String?>? groupPurpose,
    Value<String>? memberTrackingMode,
    Value<int?>? reportedCount,
    Value<DateTime?>? countObservedAt,
    Value<String?>? countNote,
    Value<int>? rowid,
  }) {
    return GroupDetailsCompanion(
      animalProfileId: animalProfileId ?? this.animalProfileId,
      groupPurpose: groupPurpose ?? this.groupPurpose,
      memberTrackingMode: memberTrackingMode ?? this.memberTrackingMode,
      reportedCount: reportedCount ?? this.reportedCount,
      countObservedAt: countObservedAt ?? this.countObservedAt,
      countNote: countNote ?? this.countNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (animalProfileId.present) {
      map['animal_profile_id'] = Variable<String>(animalProfileId.value);
    }
    if (groupPurpose.present) {
      map['group_purpose'] = Variable<String>(groupPurpose.value);
    }
    if (memberTrackingMode.present) {
      map['member_tracking_mode'] = Variable<String>(memberTrackingMode.value);
    }
    if (reportedCount.present) {
      map['reported_count'] = Variable<int>(reportedCount.value);
    }
    if (countObservedAt.present) {
      map['count_observed_at'] = Variable<DateTime>(countObservedAt.value);
    }
    if (countNote.present) {
      map['count_note'] = Variable<String>(countNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupDetailsCompanion(')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('groupPurpose: $groupPurpose, ')
          ..write('memberTrackingMode: $memberTrackingMode, ')
          ..write('reportedCount: $reportedCount, ')
          ..write('countObservedAt: $countObservedAt, ')
          ..write('countNote: $countNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupMembershipsTable extends GroupMemberships
    with TableInfo<$GroupMembershipsTable, GroupMembership> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupMembershipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _groupProfileIdMeta = const VerificationMeta(
    'groupProfileId',
  );
  @override
  late final GeneratedColumn<String> groupProfileId = GeneratedColumn<String>(
    'group_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _individualProfileIdMeta =
      const VerificationMeta('individualProfileId');
  @override
  late final GeneratedColumn<String> individualProfileId =
      GeneratedColumn<String>(
        'individual_profile_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES animal_profiles (id)',
        ),
      );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _membershipNoteMeta = const VerificationMeta(
    'membershipNote',
  );
  @override
  late final GeneratedColumn<String> membershipNote = GeneratedColumn<String>(
    'membership_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    groupProfileId,
    individualProfileId,
    validFrom,
    validTo,
    membershipNote,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_memberships';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupMembership> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('group_profile_id')) {
      context.handle(
        _groupProfileIdMeta,
        groupProfileId.isAcceptableOrUnknown(
          data['group_profile_id']!,
          _groupProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_groupProfileIdMeta);
    }
    if (data.containsKey('individual_profile_id')) {
      context.handle(
        _individualProfileIdMeta,
        individualProfileId.isAcceptableOrUnknown(
          data['individual_profile_id']!,
          _individualProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_individualProfileIdMeta);
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    } else if (isInserting) {
      context.missing(_validFromMeta);
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    if (data.containsKey('membership_note')) {
      context.handle(
        _membershipNoteMeta,
        membershipNote.isAcceptableOrUnknown(
          data['membership_note']!,
          _membershipNoteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupMembership map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupMembership(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      groupProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_profile_id'],
      )!,
      individualProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}individual_profile_id'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      )!,
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
      membershipNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}membership_note'],
      ),
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
  $GroupMembershipsTable createAlias(String alias) {
    return $GroupMembershipsTable(attachedDatabase, alias);
  }
}

class GroupMembership extends DataClass implements Insertable<GroupMembership> {
  final String id;
  final String workspaceId;
  final String groupProfileId;
  final String individualProfileId;
  final DateTime validFrom;
  final DateTime? validTo;
  final String? membershipNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GroupMembership({
    required this.id,
    required this.workspaceId,
    required this.groupProfileId,
    required this.individualProfileId,
    required this.validFrom,
    this.validTo,
    this.membershipNote,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['group_profile_id'] = Variable<String>(groupProfileId);
    map['individual_profile_id'] = Variable<String>(individualProfileId);
    map['valid_from'] = Variable<DateTime>(validFrom);
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    if (!nullToAbsent || membershipNote != null) {
      map['membership_note'] = Variable<String>(membershipNote);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GroupMembershipsCompanion toCompanion(bool nullToAbsent) {
    return GroupMembershipsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      groupProfileId: Value(groupProfileId),
      individualProfileId: Value(individualProfileId),
      validFrom: Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
      membershipNote: membershipNote == null && nullToAbsent
          ? const Value.absent()
          : Value(membershipNote),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GroupMembership.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupMembership(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      groupProfileId: serializer.fromJson<String>(json['groupProfileId']),
      individualProfileId: serializer.fromJson<String>(
        json['individualProfileId'],
      ),
      validFrom: serializer.fromJson<DateTime>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
      membershipNote: serializer.fromJson<String?>(json['membershipNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'groupProfileId': serializer.toJson<String>(groupProfileId),
      'individualProfileId': serializer.toJson<String>(individualProfileId),
      'validFrom': serializer.toJson<DateTime>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'membershipNote': serializer.toJson<String?>(membershipNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GroupMembership copyWith({
    String? id,
    String? workspaceId,
    String? groupProfileId,
    String? individualProfileId,
    DateTime? validFrom,
    Value<DateTime?> validTo = const Value.absent(),
    Value<String?> membershipNote = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GroupMembership(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    groupProfileId: groupProfileId ?? this.groupProfileId,
    individualProfileId: individualProfileId ?? this.individualProfileId,
    validFrom: validFrom ?? this.validFrom,
    validTo: validTo.present ? validTo.value : this.validTo,
    membershipNote: membershipNote.present
        ? membershipNote.value
        : this.membershipNote,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GroupMembership copyWithCompanion(GroupMembershipsCompanion data) {
    return GroupMembership(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      groupProfileId: data.groupProfileId.present
          ? data.groupProfileId.value
          : this.groupProfileId,
      individualProfileId: data.individualProfileId.present
          ? data.individualProfileId.value
          : this.individualProfileId,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      membershipNote: data.membershipNote.present
          ? data.membershipNote.value
          : this.membershipNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupMembership(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('groupProfileId: $groupProfileId, ')
          ..write('individualProfileId: $individualProfileId, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('membershipNote: $membershipNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    groupProfileId,
    individualProfileId,
    validFrom,
    validTo,
    membershipNote,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupMembership &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.groupProfileId == this.groupProfileId &&
          other.individualProfileId == this.individualProfileId &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo &&
          other.membershipNote == this.membershipNote &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GroupMembershipsCompanion extends UpdateCompanion<GroupMembership> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> groupProfileId;
  final Value<String> individualProfileId;
  final Value<DateTime> validFrom;
  final Value<DateTime?> validTo;
  final Value<String?> membershipNote;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GroupMembershipsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.groupProfileId = const Value.absent(),
    this.individualProfileId = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.membershipNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupMembershipsCompanion.insert({
    required String id,
    required String workspaceId,
    required String groupProfileId,
    required String individualProfileId,
    required DateTime validFrom,
    this.validTo = const Value.absent(),
    this.membershipNote = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       groupProfileId = Value(groupProfileId),
       individualProfileId = Value(individualProfileId),
       validFrom = Value(validFrom),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GroupMembership> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? groupProfileId,
    Expression<String>? individualProfileId,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
    Expression<String>? membershipNote,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (groupProfileId != null) 'group_profile_id': groupProfileId,
      if (individualProfileId != null)
        'individual_profile_id': individualProfileId,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
      if (membershipNote != null) 'membership_note': membershipNote,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupMembershipsCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? groupProfileId,
    Value<String>? individualProfileId,
    Value<DateTime>? validFrom,
    Value<DateTime?>? validTo,
    Value<String?>? membershipNote,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GroupMembershipsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      groupProfileId: groupProfileId ?? this.groupProfileId,
      individualProfileId: individualProfileId ?? this.individualProfileId,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      membershipNote: membershipNote ?? this.membershipNote,
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
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (groupProfileId.present) {
      map['group_profile_id'] = Variable<String>(groupProfileId.value);
    }
    if (individualProfileId.present) {
      map['individual_profile_id'] = Variable<String>(
        individualProfileId.value,
      );
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (membershipNote.present) {
      map['membership_note'] = Variable<String>(membershipNote.value);
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
    return (StringBuffer('GroupMembershipsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('groupProfileId: $groupProfileId, ')
          ..write('individualProfileId: $individualProfileId, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('membershipNote: $membershipNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitatsTable extends Habitats with TableInfo<$HabitatsTable, Habitat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _parentHabitatIdMeta = const VerificationMeta(
    'parentHabitatId',
  );
  @override
  late final GeneratedColumn<String> parentHabitatId = GeneratedColumn<String>(
    'parent_habitat_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habitats (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitatTypeMeta = const VerificationMeta(
    'habitatType',
  );
  @override
  late final GeneratedColumn<String> habitatType = GeneratedColumn<String>(
    'habitat_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityValueMeta = const VerificationMeta(
    'capacityValue',
  );
  @override
  late final GeneratedColumn<double> capacityValue = GeneratedColumn<double>(
    'capacity_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityUnitMeta = const VerificationMeta(
    'capacityUnit',
  );
  @override
  late final GeneratedColumn<String> capacityUnit = GeneratedColumn<String>(
    'capacity_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    parentHabitatId,
    name,
    habitatType,
    status,
    description,
    capacityValue,
    capacityUnit,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habitats';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habitat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('parent_habitat_id')) {
      context.handle(
        _parentHabitatIdMeta,
        parentHabitatId.isAcceptableOrUnknown(
          data['parent_habitat_id']!,
          _parentHabitatIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('habitat_type')) {
      context.handle(
        _habitatTypeMeta,
        habitatType.isAcceptableOrUnknown(
          data['habitat_type']!,
          _habitatTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_habitatTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('capacity_value')) {
      context.handle(
        _capacityValueMeta,
        capacityValue.isAcceptableOrUnknown(
          data['capacity_value']!,
          _capacityValueMeta,
        ),
      );
    }
    if (data.containsKey('capacity_unit')) {
      context.handle(
        _capacityUnitMeta,
        capacityUnit.isAcceptableOrUnknown(
          data['capacity_unit']!,
          _capacityUnitMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habitat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habitat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      parentHabitatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_habitat_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      habitatType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habitat_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      capacityValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}capacity_value'],
      ),
      capacityUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capacity_unit'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $HabitatsTable createAlias(String alias) {
    return $HabitatsTable(attachedDatabase, alias);
  }
}

class Habitat extends DataClass implements Insertable<Habitat> {
  final String id;
  final String workspaceId;
  final String? parentHabitatId;
  final String name;
  final String habitatType;
  final String status;
  final String? description;
  final double? capacityValue;
  final String? capacityUnit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Habitat({
    required this.id,
    required this.workspaceId,
    this.parentHabitatId,
    required this.name,
    required this.habitatType,
    required this.status,
    this.description,
    this.capacityValue,
    this.capacityUnit,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    if (!nullToAbsent || parentHabitatId != null) {
      map['parent_habitat_id'] = Variable<String>(parentHabitatId);
    }
    map['name'] = Variable<String>(name);
    map['habitat_type'] = Variable<String>(habitatType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || capacityValue != null) {
      map['capacity_value'] = Variable<double>(capacityValue);
    }
    if (!nullToAbsent || capacityUnit != null) {
      map['capacity_unit'] = Variable<String>(capacityUnit);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  HabitatsCompanion toCompanion(bool nullToAbsent) {
    return HabitatsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      parentHabitatId: parentHabitatId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentHabitatId),
      name: Value(name),
      habitatType: Value(habitatType),
      status: Value(status),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      capacityValue: capacityValue == null && nullToAbsent
          ? const Value.absent()
          : Value(capacityValue),
      capacityUnit: capacityUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(capacityUnit),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Habitat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habitat(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      parentHabitatId: serializer.fromJson<String?>(json['parentHabitatId']),
      name: serializer.fromJson<String>(json['name']),
      habitatType: serializer.fromJson<String>(json['habitatType']),
      status: serializer.fromJson<String>(json['status']),
      description: serializer.fromJson<String?>(json['description']),
      capacityValue: serializer.fromJson<double?>(json['capacityValue']),
      capacityUnit: serializer.fromJson<String?>(json['capacityUnit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'parentHabitatId': serializer.toJson<String?>(parentHabitatId),
      'name': serializer.toJson<String>(name),
      'habitatType': serializer.toJson<String>(habitatType),
      'status': serializer.toJson<String>(status),
      'description': serializer.toJson<String?>(description),
      'capacityValue': serializer.toJson<double?>(capacityValue),
      'capacityUnit': serializer.toJson<String?>(capacityUnit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Habitat copyWith({
    String? id,
    String? workspaceId,
    Value<String?> parentHabitatId = const Value.absent(),
    String? name,
    String? habitatType,
    String? status,
    Value<String?> description = const Value.absent(),
    Value<double?> capacityValue = const Value.absent(),
    Value<String?> capacityUnit = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Habitat(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    parentHabitatId: parentHabitatId.present
        ? parentHabitatId.value
        : this.parentHabitatId,
    name: name ?? this.name,
    habitatType: habitatType ?? this.habitatType,
    status: status ?? this.status,
    description: description.present ? description.value : this.description,
    capacityValue: capacityValue.present
        ? capacityValue.value
        : this.capacityValue,
    capacityUnit: capacityUnit.present ? capacityUnit.value : this.capacityUnit,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Habitat copyWithCompanion(HabitatsCompanion data) {
    return Habitat(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      parentHabitatId: data.parentHabitatId.present
          ? data.parentHabitatId.value
          : this.parentHabitatId,
      name: data.name.present ? data.name.value : this.name,
      habitatType: data.habitatType.present
          ? data.habitatType.value
          : this.habitatType,
      status: data.status.present ? data.status.value : this.status,
      description: data.description.present
          ? data.description.value
          : this.description,
      capacityValue: data.capacityValue.present
          ? data.capacityValue.value
          : this.capacityValue,
      capacityUnit: data.capacityUnit.present
          ? data.capacityUnit.value
          : this.capacityUnit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habitat(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('parentHabitatId: $parentHabitatId, ')
          ..write('name: $name, ')
          ..write('habitatType: $habitatType, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('capacityValue: $capacityValue, ')
          ..write('capacityUnit: $capacityUnit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    parentHabitatId,
    name,
    habitatType,
    status,
    description,
    capacityValue,
    capacityUnit,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habitat &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.parentHabitatId == this.parentHabitatId &&
          other.name == this.name &&
          other.habitatType == this.habitatType &&
          other.status == this.status &&
          other.description == this.description &&
          other.capacityValue == this.capacityValue &&
          other.capacityUnit == this.capacityUnit &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class HabitatsCompanion extends UpdateCompanion<Habitat> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String?> parentHabitatId;
  final Value<String> name;
  final Value<String> habitatType;
  final Value<String> status;
  final Value<String?> description;
  final Value<double?> capacityValue;
  final Value<String?> capacityUnit;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const HabitatsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.parentHabitatId = const Value.absent(),
    this.name = const Value.absent(),
    this.habitatType = const Value.absent(),
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.capacityValue = const Value.absent(),
    this.capacityUnit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitatsCompanion.insert({
    required String id,
    required String workspaceId,
    this.parentHabitatId = const Value.absent(),
    required String name,
    required String habitatType,
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.capacityValue = const Value.absent(),
    this.capacityUnit = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       name = Value(name),
       habitatType = Value(habitatType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Habitat> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? parentHabitatId,
    Expression<String>? name,
    Expression<String>? habitatType,
    Expression<String>? status,
    Expression<String>? description,
    Expression<double>? capacityValue,
    Expression<String>? capacityUnit,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (parentHabitatId != null) 'parent_habitat_id': parentHabitatId,
      if (name != null) 'name': name,
      if (habitatType != null) 'habitat_type': habitatType,
      if (status != null) 'status': status,
      if (description != null) 'description': description,
      if (capacityValue != null) 'capacity_value': capacityValue,
      if (capacityUnit != null) 'capacity_unit': capacityUnit,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitatsCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String?>? parentHabitatId,
    Value<String>? name,
    Value<String>? habitatType,
    Value<String>? status,
    Value<String?>? description,
    Value<double?>? capacityValue,
    Value<String?>? capacityUnit,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return HabitatsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      parentHabitatId: parentHabitatId ?? this.parentHabitatId,
      name: name ?? this.name,
      habitatType: habitatType ?? this.habitatType,
      status: status ?? this.status,
      description: description ?? this.description,
      capacityValue: capacityValue ?? this.capacityValue,
      capacityUnit: capacityUnit ?? this.capacityUnit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (parentHabitatId.present) {
      map['parent_habitat_id'] = Variable<String>(parentHabitatId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (habitatType.present) {
      map['habitat_type'] = Variable<String>(habitatType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (capacityValue.present) {
      map['capacity_value'] = Variable<double>(capacityValue.value);
    }
    if (capacityUnit.present) {
      map['capacity_unit'] = Variable<String>(capacityUnit.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitatsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('parentHabitatId: $parentHabitatId, ')
          ..write('name: $name, ')
          ..write('habitatType: $habitatType, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('capacityValue: $capacityValue, ')
          ..write('capacityUnit: $capacityUnit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnimalHabitatAssignmentsTable extends AnimalHabitatAssignments
    with TableInfo<$AnimalHabitatAssignmentsTable, AnimalHabitatAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalHabitatAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _animalProfileIdMeta = const VerificationMeta(
    'animalProfileId',
  );
  @override
  late final GeneratedColumn<String> animalProfileId = GeneratedColumn<String>(
    'animal_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal_profiles (id)',
    ),
  );
  static const VerificationMeta _habitatIdMeta = const VerificationMeta(
    'habitatId',
  );
  @override
  late final GeneratedColumn<String> habitatId = GeneratedColumn<String>(
    'habitat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habitats (id)',
    ),
  );
  static const VerificationMeta _assignmentRoleMeta = const VerificationMeta(
    'assignmentRole',
  );
  @override
  late final GeneratedColumn<String> assignmentRole = GeneratedColumn<String>(
    'assignment_role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('primary'),
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    animalProfileId,
    habitatId,
    assignmentRole,
    validFrom,
    validTo,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animal_habitat_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimalHabitatAssignment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('animal_profile_id')) {
      context.handle(
        _animalProfileIdMeta,
        animalProfileId.isAcceptableOrUnknown(
          data['animal_profile_id']!,
          _animalProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_animalProfileIdMeta);
    }
    if (data.containsKey('habitat_id')) {
      context.handle(
        _habitatIdMeta,
        habitatId.isAcceptableOrUnknown(data['habitat_id']!, _habitatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitatIdMeta);
    }
    if (data.containsKey('assignment_role')) {
      context.handle(
        _assignmentRoleMeta,
        assignmentRole.isAcceptableOrUnknown(
          data['assignment_role']!,
          _assignmentRoleMeta,
        ),
      );
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    } else if (isInserting) {
      context.missing(_validFromMeta);
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimalHabitatAssignment map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimalHabitatAssignment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      animalProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_profile_id'],
      )!,
      habitatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habitat_id'],
      )!,
      assignmentRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assignment_role'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      )!,
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AnimalHabitatAssignmentsTable createAlias(String alias) {
    return $AnimalHabitatAssignmentsTable(attachedDatabase, alias);
  }
}

class AnimalHabitatAssignment extends DataClass
    implements Insertable<AnimalHabitatAssignment> {
  final String id;
  final String workspaceId;
  final String animalProfileId;
  final String habitatId;
  final String assignmentRole;
  final DateTime validFrom;
  final DateTime? validTo;
  final String? note;
  final DateTime createdAt;
  const AnimalHabitatAssignment({
    required this.id,
    required this.workspaceId,
    required this.animalProfileId,
    required this.habitatId,
    required this.assignmentRole,
    required this.validFrom,
    this.validTo,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['animal_profile_id'] = Variable<String>(animalProfileId);
    map['habitat_id'] = Variable<String>(habitatId);
    map['assignment_role'] = Variable<String>(assignmentRole);
    map['valid_from'] = Variable<DateTime>(validFrom);
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AnimalHabitatAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return AnimalHabitatAssignmentsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      animalProfileId: Value(animalProfileId),
      habitatId: Value(habitatId),
      assignmentRole: Value(assignmentRole),
      validFrom: Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory AnimalHabitatAssignment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimalHabitatAssignment(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      animalProfileId: serializer.fromJson<String>(json['animalProfileId']),
      habitatId: serializer.fromJson<String>(json['habitatId']),
      assignmentRole: serializer.fromJson<String>(json['assignmentRole']),
      validFrom: serializer.fromJson<DateTime>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'animalProfileId': serializer.toJson<String>(animalProfileId),
      'habitatId': serializer.toJson<String>(habitatId),
      'assignmentRole': serializer.toJson<String>(assignmentRole),
      'validFrom': serializer.toJson<DateTime>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AnimalHabitatAssignment copyWith({
    String? id,
    String? workspaceId,
    String? animalProfileId,
    String? habitatId,
    String? assignmentRole,
    DateTime? validFrom,
    Value<DateTime?> validTo = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => AnimalHabitatAssignment(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    animalProfileId: animalProfileId ?? this.animalProfileId,
    habitatId: habitatId ?? this.habitatId,
    assignmentRole: assignmentRole ?? this.assignmentRole,
    validFrom: validFrom ?? this.validFrom,
    validTo: validTo.present ? validTo.value : this.validTo,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  AnimalHabitatAssignment copyWithCompanion(
    AnimalHabitatAssignmentsCompanion data,
  ) {
    return AnimalHabitatAssignment(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      animalProfileId: data.animalProfileId.present
          ? data.animalProfileId.value
          : this.animalProfileId,
      habitatId: data.habitatId.present ? data.habitatId.value : this.habitatId,
      assignmentRole: data.assignmentRole.present
          ? data.assignmentRole.value
          : this.assignmentRole,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimalHabitatAssignment(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('habitatId: $habitatId, ')
          ..write('assignmentRole: $assignmentRole, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    animalProfileId,
    habitatId,
    assignmentRole,
    validFrom,
    validTo,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalHabitatAssignment &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.animalProfileId == this.animalProfileId &&
          other.habitatId == this.habitatId &&
          other.assignmentRole == this.assignmentRole &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class AnimalHabitatAssignmentsCompanion
    extends UpdateCompanion<AnimalHabitatAssignment> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> animalProfileId;
  final Value<String> habitatId;
  final Value<String> assignmentRole;
  final Value<DateTime> validFrom;
  final Value<DateTime?> validTo;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AnimalHabitatAssignmentsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.animalProfileId = const Value.absent(),
    this.habitatId = const Value.absent(),
    this.assignmentRole = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimalHabitatAssignmentsCompanion.insert({
    required String id,
    required String workspaceId,
    required String animalProfileId,
    required String habitatId,
    this.assignmentRole = const Value.absent(),
    required DateTime validFrom,
    this.validTo = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       animalProfileId = Value(animalProfileId),
       habitatId = Value(habitatId),
       validFrom = Value(validFrom),
       createdAt = Value(createdAt);
  static Insertable<AnimalHabitatAssignment> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? animalProfileId,
    Expression<String>? habitatId,
    Expression<String>? assignmentRole,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (animalProfileId != null) 'animal_profile_id': animalProfileId,
      if (habitatId != null) 'habitat_id': habitatId,
      if (assignmentRole != null) 'assignment_role': assignmentRole,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimalHabitatAssignmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? animalProfileId,
    Value<String>? habitatId,
    Value<String>? assignmentRole,
    Value<DateTime>? validFrom,
    Value<DateTime?>? validTo,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AnimalHabitatAssignmentsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      animalProfileId: animalProfileId ?? this.animalProfileId,
      habitatId: habitatId ?? this.habitatId,
      assignmentRole: assignmentRole ?? this.assignmentRole,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (animalProfileId.present) {
      map['animal_profile_id'] = Variable<String>(animalProfileId.value);
    }
    if (habitatId.present) {
      map['habitat_id'] = Variable<String>(habitatId.value);
    }
    if (assignmentRole.present) {
      map['assignment_role'] = Variable<String>(assignmentRole.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalHabitatAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('animalProfileId: $animalProfileId, ')
          ..write('habitatId: $habitatId, ')
          ..write('assignmentRole: $assignmentRole, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _operationIdMeta = const VerificationMeta(
    'operationId',
  );
  @override
  late final GeneratedColumn<String> operationId = GeneratedColumn<String>(
    'operation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _entityKindMeta = const VerificationMeta(
    'entityKind',
  );
  @override
  late final GeneratedColumn<String> entityKind = GeneratedColumn<String>(
    'entity_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationKindMeta = const VerificationMeta(
    'operationKind',
  );
  @override
  late final GeneratedColumn<String> operationKind = GeneratedColumn<String>(
    'operation_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseServerVersionMeta = const VerificationMeta(
    'baseServerVersion',
  );
  @override
  late final GeneratedColumn<int> baseServerVersion = GeneratedColumn<int>(
    'base_server_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadVersionMeta = const VerificationMeta(
    'payloadVersion',
  );
  @override
  late final GeneratedColumn<int> payloadVersion = GeneratedColumn<int>(
    'payload_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _lastErrorCodeMeta = const VerificationMeta(
    'lastErrorCode',
  );
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
    'last_error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    operationId,
    workspaceId,
    entityKind,
    entityId,
    operationKind,
    baseServerVersion,
    payloadVersion,
    payloadJson,
    createdAt,
    attemptCount,
    nextAttemptAt,
    status,
    lastErrorCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('operation_id')) {
      context.handle(
        _operationIdMeta,
        operationId.isAcceptableOrUnknown(
          data['operation_id']!,
          _operationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationIdMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('entity_kind')) {
      context.handle(
        _entityKindMeta,
        entityKind.isAcceptableOrUnknown(data['entity_kind']!, _entityKindMeta),
      );
    } else if (isInserting) {
      context.missing(_entityKindMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation_kind')) {
      context.handle(
        _operationKindMeta,
        operationKind.isAcceptableOrUnknown(
          data['operation_kind']!,
          _operationKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationKindMeta);
    }
    if (data.containsKey('base_server_version')) {
      context.handle(
        _baseServerVersionMeta,
        baseServerVersion.isAcceptableOrUnknown(
          data['base_server_version']!,
          _baseServerVersionMeta,
        ),
      );
    }
    if (data.containsKey('payload_version')) {
      context.handle(
        _payloadVersionMeta,
        payloadVersion.isAcceptableOrUnknown(
          data['payload_version']!,
          _payloadVersionMeta,
        ),
      );
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
        _lastErrorCodeMeta,
        lastErrorCode.isAcceptableOrUnknown(
          data['last_error_code']!,
          _lastErrorCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {operationId};
  @override
  SyncOutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxData(
      operationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      entityKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_kind'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operationKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_kind'],
      )!,
      baseServerVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_server_version'],
      ),
      payloadVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payload_version'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastErrorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_code'],
      ),
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxData extends DataClass implements Insertable<SyncOutboxData> {
  final String operationId;
  final String workspaceId;
  final String entityKind;
  final String entityId;
  final String operationKind;
  final int? baseServerVersion;
  final int payloadVersion;
  final String payloadJson;
  final DateTime createdAt;
  final int attemptCount;
  final DateTime? nextAttemptAt;
  final String status;
  final String? lastErrorCode;
  const SyncOutboxData({
    required this.operationId,
    required this.workspaceId,
    required this.entityKind,
    required this.entityId,
    required this.operationKind,
    this.baseServerVersion,
    required this.payloadVersion,
    required this.payloadJson,
    required this.createdAt,
    required this.attemptCount,
    this.nextAttemptAt,
    required this.status,
    this.lastErrorCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['operation_id'] = Variable<String>(operationId);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['entity_kind'] = Variable<String>(entityKind);
    map['entity_id'] = Variable<String>(entityId);
    map['operation_kind'] = Variable<String>(operationKind);
    if (!nullToAbsent || baseServerVersion != null) {
      map['base_server_version'] = Variable<int>(baseServerVersion);
    }
    map['payload_version'] = Variable<int>(payloadVersion);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      operationId: Value(operationId),
      workspaceId: Value(workspaceId),
      entityKind: Value(entityKind),
      entityId: Value(entityId),
      operationKind: Value(operationKind),
      baseServerVersion: baseServerVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(baseServerVersion),
      payloadVersion: Value(payloadVersion),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      attemptCount: Value(attemptCount),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      status: Value(status),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
    );
  }

  factory SyncOutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxData(
      operationId: serializer.fromJson<String>(json['operationId']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      entityKind: serializer.fromJson<String>(json['entityKind']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operationKind: serializer.fromJson<String>(json['operationKind']),
      baseServerVersion: serializer.fromJson<int?>(json['baseServerVersion']),
      payloadVersion: serializer.fromJson<int>(json['payloadVersion']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      status: serializer.fromJson<String>(json['status']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'operationId': serializer.toJson<String>(operationId),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'entityKind': serializer.toJson<String>(entityKind),
      'entityId': serializer.toJson<String>(entityId),
      'operationKind': serializer.toJson<String>(operationKind),
      'baseServerVersion': serializer.toJson<int?>(baseServerVersion),
      'payloadVersion': serializer.toJson<int>(payloadVersion),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'status': serializer.toJson<String>(status),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
    };
  }

  SyncOutboxData copyWith({
    String? operationId,
    String? workspaceId,
    String? entityKind,
    String? entityId,
    String? operationKind,
    Value<int?> baseServerVersion = const Value.absent(),
    int? payloadVersion,
    String? payloadJson,
    DateTime? createdAt,
    int? attemptCount,
    Value<DateTime?> nextAttemptAt = const Value.absent(),
    String? status,
    Value<String?> lastErrorCode = const Value.absent(),
  }) => SyncOutboxData(
    operationId: operationId ?? this.operationId,
    workspaceId: workspaceId ?? this.workspaceId,
    entityKind: entityKind ?? this.entityKind,
    entityId: entityId ?? this.entityId,
    operationKind: operationKind ?? this.operationKind,
    baseServerVersion: baseServerVersion.present
        ? baseServerVersion.value
        : this.baseServerVersion,
    payloadVersion: payloadVersion ?? this.payloadVersion,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    attemptCount: attemptCount ?? this.attemptCount,
    nextAttemptAt: nextAttemptAt.present
        ? nextAttemptAt.value
        : this.nextAttemptAt,
    status: status ?? this.status,
    lastErrorCode: lastErrorCode.present
        ? lastErrorCode.value
        : this.lastErrorCode,
  );
  SyncOutboxData copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxData(
      operationId: data.operationId.present
          ? data.operationId.value
          : this.operationId,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      entityKind: data.entityKind.present
          ? data.entityKind.value
          : this.entityKind,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operationKind: data.operationKind.present
          ? data.operationKind.value
          : this.operationKind,
      baseServerVersion: data.baseServerVersion.present
          ? data.baseServerVersion.value
          : this.baseServerVersion,
      payloadVersion: data.payloadVersion.present
          ? data.payloadVersion.value
          : this.payloadVersion,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      status: data.status.present ? data.status.value : this.status,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxData(')
          ..write('operationId: $operationId, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('entityKind: $entityKind, ')
          ..write('entityId: $entityId, ')
          ..write('operationKind: $operationKind, ')
          ..write('baseServerVersion: $baseServerVersion, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('status: $status, ')
          ..write('lastErrorCode: $lastErrorCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    operationId,
    workspaceId,
    entityKind,
    entityId,
    operationKind,
    baseServerVersion,
    payloadVersion,
    payloadJson,
    createdAt,
    attemptCount,
    nextAttemptAt,
    status,
    lastErrorCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxData &&
          other.operationId == this.operationId &&
          other.workspaceId == this.workspaceId &&
          other.entityKind == this.entityKind &&
          other.entityId == this.entityId &&
          other.operationKind == this.operationKind &&
          other.baseServerVersion == this.baseServerVersion &&
          other.payloadVersion == this.payloadVersion &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.attemptCount == this.attemptCount &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.status == this.status &&
          other.lastErrorCode == this.lastErrorCode);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxData> {
  final Value<String> operationId;
  final Value<String> workspaceId;
  final Value<String> entityKind;
  final Value<String> entityId;
  final Value<String> operationKind;
  final Value<int?> baseServerVersion;
  final Value<int> payloadVersion;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> attemptCount;
  final Value<DateTime?> nextAttemptAt;
  final Value<String> status;
  final Value<String?> lastErrorCode;
  final Value<int> rowid;
  const SyncOutboxCompanion({
    this.operationId = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.entityKind = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operationKind = const Value.absent(),
    this.baseServerVersion = const Value.absent(),
    this.payloadVersion = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    required String operationId,
    required String workspaceId,
    required String entityKind,
    required String entityId,
    required String operationKind,
    this.baseServerVersion = const Value.absent(),
    this.payloadVersion = const Value.absent(),
    required String payloadJson,
    required DateTime createdAt,
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : operationId = Value(operationId),
       workspaceId = Value(workspaceId),
       entityKind = Value(entityKind),
       entityId = Value(entityId),
       operationKind = Value(operationKind),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<SyncOutboxData> custom({
    Expression<String>? operationId,
    Expression<String>? workspaceId,
    Expression<String>? entityKind,
    Expression<String>? entityId,
    Expression<String>? operationKind,
    Expression<int>? baseServerVersion,
    Expression<int>? payloadVersion,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? attemptCount,
    Expression<DateTime>? nextAttemptAt,
    Expression<String>? status,
    Expression<String>? lastErrorCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (operationId != null) 'operation_id': operationId,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (entityKind != null) 'entity_kind': entityKind,
      if (entityId != null) 'entity_id': entityId,
      if (operationKind != null) 'operation_kind': operationKind,
      if (baseServerVersion != null) 'base_server_version': baseServerVersion,
      if (payloadVersion != null) 'payload_version': payloadVersion,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (status != null) 'status': status,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<String>? operationId,
    Value<String>? workspaceId,
    Value<String>? entityKind,
    Value<String>? entityId,
    Value<String>? operationKind,
    Value<int?>? baseServerVersion,
    Value<int>? payloadVersion,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
    Value<int>? attemptCount,
    Value<DateTime?>? nextAttemptAt,
    Value<String>? status,
    Value<String?>? lastErrorCode,
    Value<int>? rowid,
  }) {
    return SyncOutboxCompanion(
      operationId: operationId ?? this.operationId,
      workspaceId: workspaceId ?? this.workspaceId,
      entityKind: entityKind ?? this.entityKind,
      entityId: entityId ?? this.entityId,
      operationKind: operationKind ?? this.operationKind,
      baseServerVersion: baseServerVersion ?? this.baseServerVersion,
      payloadVersion: payloadVersion ?? this.payloadVersion,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      attemptCount: attemptCount ?? this.attemptCount,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      status: status ?? this.status,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (operationId.present) {
      map['operation_id'] = Variable<String>(operationId.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (entityKind.present) {
      map['entity_kind'] = Variable<String>(entityKind.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operationKind.present) {
      map['operation_kind'] = Variable<String>(operationKind.value);
    }
    if (baseServerVersion.present) {
      map['base_server_version'] = Variable<int>(baseServerVersion.value);
    }
    if (payloadVersion.present) {
      map['payload_version'] = Variable<int>(payloadVersion.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('operationId: $operationId, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('entityKind: $entityKind, ')
          ..write('entityId: $entityId, ')
          ..write('operationKind: $operationKind, ')
          ..write('baseServerVersion: $baseServerVersion, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('status: $status, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $WorkspacesTable workspaces = $WorkspacesTable(this);
  late final $WorkspaceMembershipsTable workspaceMemberships =
      $WorkspaceMembershipsTable(this);
  late final $SpeciesTable species = $SpeciesTable(this);
  late final $SpeciesSourcesTable speciesSources = $SpeciesSourcesTable(this);
  late final $SpeciesAttributeDefinitionsTable speciesAttributeDefinitions =
      $SpeciesAttributeDefinitionsTable(this);
  late final $AnimalProfilesTable animalProfiles = $AnimalProfilesTable(this);
  late final $SpeciesAttributeValuesTable speciesAttributeValues =
      $SpeciesAttributeValuesTable(this);
  late final $CareSchedulesTable careSchedules = $CareSchedulesTable(this);
  late final $CareRecordsTable careRecords = $CareRecordsTable(this);
  late final $IndividualDetailsTable individualDetails =
      $IndividualDetailsTable(this);
  late final $GroupDetailsTable groupDetails = $GroupDetailsTable(this);
  late final $GroupMembershipsTable groupMemberships = $GroupMembershipsTable(
    this,
  );
  late final $HabitatsTable habitats = $HabitatsTable(this);
  late final $AnimalHabitatAssignmentsTable animalHabitatAssignments =
      $AnimalHabitatAssignmentsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appUsers,
    workspaces,
    workspaceMemberships,
    species,
    speciesSources,
    speciesAttributeDefinitions,
    animalProfiles,
    speciesAttributeValues,
    careSchedules,
    careRecords,
    individualDetails,
    groupDetails,
    groupMemberships,
    habitats,
    animalHabitatAssignments,
    syncOutbox,
  ];
}

typedef $$AppUsersTableCreateCompanionBuilder =
    AppUsersCompanion Function({
      required String id,
      required String displayName,
      Value<String?> email,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppUsersTableUpdateCompanionBuilder =
    AppUsersCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<String?> email,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AppUsersTableReferences
    extends BaseReferences<_$AppDatabase, $AppUsersTable, AppUser> {
  $$AppUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkspacesTable, List<Workspace>>
  _workspacesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workspaces,
    aliasName: 'app_users__id__workspaces__created_by_user_id',
  );

  $$WorkspacesTableProcessedTableManager get workspacesRefs {
    final manager = $$WorkspacesTableTableManager($_db, $_db.workspaces).filter(
      (f) => f.createdByUserId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_workspacesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WorkspaceMembershipsTable,
    List<WorkspaceMembership>
  >
  _workspaceMembershipsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workspaceMemberships,
        aliasName: 'app_users__id__workspace_memberships__user_id',
      );

  $$WorkspaceMembershipsTableProcessedTableManager
  get workspaceMembershipsRefs {
    final manager = $$WorkspaceMembershipsTableTableManager(
      $_db,
      $_db.workspaceMemberships,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workspaceMembershipsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
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

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
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

  Expression<bool> workspacesRefs(
    Expression<bool> Function($$WorkspacesTableFilterComposer f) f,
  ) {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.createdByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workspaceMembershipsRefs(
    Expression<bool> Function($$WorkspaceMembershipsTableFilterComposer f) f,
  ) {
    final $$WorkspaceMembershipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workspaceMemberships,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspaceMembershipsTableFilterComposer(
            $db: $db,
            $table: $db.workspaceMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
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

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
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

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> workspacesRefs<T extends Object>(
    Expression<T> Function($$WorkspacesTableAnnotationComposer a) f,
  ) {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.createdByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workspaceMembershipsRefs<T extends Object>(
    Expression<T> Function($$WorkspaceMembershipsTableAnnotationComposer a) f,
  ) {
    final $$WorkspaceMembershipsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workspaceMemberships,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkspaceMembershipsTableAnnotationComposer(
                $db: $db,
                $table: $db.workspaceMemberships,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AppUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppUsersTable,
          AppUser,
          $$AppUsersTableFilterComposer,
          $$AppUsersTableOrderingComposer,
          $$AppUsersTableAnnotationComposer,
          $$AppUsersTableCreateCompanionBuilder,
          $$AppUsersTableUpdateCompanionBuilder,
          (AppUser, $$AppUsersTableReferences),
          AppUser,
          PrefetchHooks Function({
            bool workspacesRefs,
            bool workspaceMembershipsRefs,
          })
        > {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppUsersCompanion(
                id: id,
                displayName: displayName,
                email: email,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                Value<String?> email = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppUsersCompanion.insert(
                id: id,
                displayName: displayName,
                email: email,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppUsersTable, AppUser>(table),
                  $$AppUsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({workspacesRefs = false, workspaceMembershipsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workspacesRefs) db.workspaces,
                    if (workspaceMembershipsRefs) db.workspaceMemberships,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workspacesRefs)
                        await $_getPrefetchedDataByColumns<
                          AppUser,
                          $AppUsersTable,
                          Workspace,
                          $WorkspacesTable
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._workspacesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).workspacesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'created_by_user_id',
                          typedResults: items,
                        ),
                      if (workspaceMembershipsRefs)
                        await $_getPrefetchedDataByColumns<
                          AppUser,
                          $AppUsersTable,
                          WorkspaceMembership,
                          $WorkspaceMembershipsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._workspaceMembershipsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).workspaceMembershipsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AppUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppUsersTable,
      AppUser,
      $$AppUsersTableFilterComposer,
      $$AppUsersTableOrderingComposer,
      $$AppUsersTableAnnotationComposer,
      $$AppUsersTableCreateCompanionBuilder,
      $$AppUsersTableUpdateCompanionBuilder,
      (AppUser, $$AppUsersTableReferences),
      AppUser,
      PrefetchHooks Function({
        bool workspacesRefs,
        bool workspaceMembershipsRefs,
      })
    >;
typedef $$WorkspacesTableCreateCompanionBuilder =
    WorkspacesCompanion Function({
      required String id,
      required String workspaceType,
      required String name,
      required String createdByUserId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$WorkspacesTableUpdateCompanionBuilder =
    WorkspacesCompanion Function({
      Value<String> id,
      Value<String> workspaceType,
      Value<String> name,
      Value<String> createdByUserId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$WorkspacesTableReferences
    extends BaseReferences<_$AppDatabase, $WorkspacesTable, Workspace> {
  $$WorkspacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AppUsersTable _createdByUserIdTable(_$AppDatabase db) =>
      db.appUsers.createAlias('workspaces__created_by_user_id__app_users__id');

  $$AppUsersTableProcessedTableManager get createdByUserId {
    final $_column = $_itemColumn<String>('created_by_user_id')!;

    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $WorkspaceMembershipsTable,
    List<WorkspaceMembership>
  >
  _workspaceMembershipsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workspaceMemberships,
        aliasName: 'workspaces__id__workspace_memberships__workspace_id',
      );

  $$WorkspaceMembershipsTableProcessedTableManager
  get workspaceMembershipsRefs {
    final manager = $$WorkspaceMembershipsTableTableManager(
      $_db,
      $_db.workspaceMemberships,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workspaceMembershipsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SpeciesTable, List<SpeciesData>>
  _speciesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.species,
    aliasName: 'workspaces__id__species__workspace_id',
  );

  $$SpeciesTableProcessedTableManager get speciesRefs {
    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_speciesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnimalProfilesTable, List<AnimalProfile>>
  _animalProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.animalProfiles,
    aliasName: 'workspaces__id__animal_profiles__workspace_id',
  );

  $$AnimalProfilesTableProcessedTableManager get animalProfilesRefs {
    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_animalProfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SpeciesAttributeValuesTable,
    List<SpeciesAttributeValue>
  >
  _speciesAttributeValuesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speciesAttributeValues,
        aliasName: 'workspaces__id__species_attribute_values__workspace_id',
      );

  $$SpeciesAttributeValuesTableProcessedTableManager
  get speciesAttributeValuesRefs {
    final manager = $$SpeciesAttributeValuesTableTableManager(
      $_db,
      $_db.speciesAttributeValues,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _speciesAttributeValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareSchedulesTable, List<CareSchedule>>
  _careSchedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careSchedules,
    aliasName: 'workspaces__id__care_schedules__workspace_id',
  );

  $$CareSchedulesTableProcessedTableManager get careSchedulesRefs {
    final manager = $$CareSchedulesTableTableManager(
      $_db,
      $_db.careSchedules,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careSchedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareRecordsTable, List<CareRecord>>
  _careRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRecords,
    aliasName: 'workspaces__id__care_records__workspace_id',
  );

  $$CareRecordsTableProcessedTableManager get careRecordsRefs {
    final manager = $$CareRecordsTableTableManager(
      $_db,
      $_db.careRecords,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupMembershipsTable, List<GroupMembership>>
  _groupMembershipsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.groupMemberships,
    aliasName: 'workspaces__id__group_memberships__workspace_id',
  );

  $$GroupMembershipsTableProcessedTableManager get groupMembershipsRefs {
    final manager = $$GroupMembershipsTableTableManager(
      $_db,
      $_db.groupMemberships,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _groupMembershipsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitatsTable, List<Habitat>> _habitatsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.habitats,
    aliasName: 'workspaces__id__habitats__workspace_id',
  );

  $$HabitatsTableProcessedTableManager get habitatsRefs {
    final manager = $$HabitatsTableTableManager(
      $_db,
      $_db.habitats,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitatsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $AnimalHabitatAssignmentsTable,
    List<AnimalHabitatAssignment>
  >
  _animalHabitatAssignmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.animalHabitatAssignments,
        aliasName: 'workspaces__id__animal_habitat_assignments__workspace_id',
      );

  $$AnimalHabitatAssignmentsTableProcessedTableManager
  get animalHabitatAssignmentsRefs {
    final manager = $$AnimalHabitatAssignmentsTableTableManager(
      $_db,
      $_db.animalHabitatAssignments,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _animalHabitatAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncOutboxTable, List<SyncOutboxData>>
  _syncOutboxRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncOutbox,
    aliasName: 'workspaces__id__sync_outbox__workspace_id',
  );

  $$SyncOutboxTableProcessedTableManager get syncOutboxRefs {
    final manager = $$SyncOutboxTableTableManager(
      $_db,
      $_db.syncOutbox,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncOutboxRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkspacesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableFilterComposer({
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

  ColumnFilters<String> get workspaceType => $composableBuilder(
    column: $table.workspaceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AppUsersTableFilterComposer get createdByUserId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> workspaceMembershipsRefs(
    Expression<bool> Function($$WorkspaceMembershipsTableFilterComposer f) f,
  ) {
    final $$WorkspaceMembershipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workspaceMemberships,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspaceMembershipsTableFilterComposer(
            $db: $db,
            $table: $db.workspaceMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> speciesRefs(
    Expression<bool> Function($$SpeciesTableFilterComposer f) f,
  ) {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> animalProfilesRefs(
    Expression<bool> Function($$AnimalProfilesTableFilterComposer f) f,
  ) {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> speciesAttributeValuesRefs(
    Expression<bool> Function($$SpeciesAttributeValuesTableFilterComposer f) f,
  ) {
    final $$SpeciesAttributeValuesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeValues,
          getReferencedColumn: (t) => t.workspaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeValuesTableFilterComposer(
                $db: $db,
                $table: $db.speciesAttributeValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> careSchedulesRefs(
    Expression<bool> Function($$CareSchedulesTableFilterComposer f) f,
  ) {
    final $$CareSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careRecordsRefs(
    Expression<bool> Function($$CareRecordsTableFilterComposer f) f,
  ) {
    final $$CareRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRecords,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRecordsTableFilterComposer(
            $db: $db,
            $table: $db.careRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupMembershipsRefs(
    Expression<bool> Function($$GroupMembershipsTableFilterComposer f) f,
  ) {
    final $$GroupMembershipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupMemberships,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupMembershipsTableFilterComposer(
            $db: $db,
            $table: $db.groupMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitatsRefs(
    Expression<bool> Function($$HabitatsTableFilterComposer f) f,
  ) {
    final $$HabitatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableFilterComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> animalHabitatAssignmentsRefs(
    Expression<bool> Function($$AnimalHabitatAssignmentsTableFilterComposer f)
    f,
  ) {
    final $$AnimalHabitatAssignmentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.animalHabitatAssignments,
          getReferencedColumn: (t) => t.workspaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnimalHabitatAssignmentsTableFilterComposer(
                $db: $db,
                $table: $db.animalHabitatAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> syncOutboxRefs(
    Expression<bool> Function($$SyncOutboxTableFilterComposer f) f,
  ) {
    final $$SyncOutboxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncOutbox,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncOutboxTableFilterComposer(
            $db: $db,
            $table: $db.syncOutbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkspacesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableOrderingComposer({
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

  ColumnOrderings<String> get workspaceType => $composableBuilder(
    column: $table.workspaceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AppUsersTableOrderingComposer get createdByUserId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkspacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceType => $composableBuilder(
    column: $table.workspaceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$AppUsersTableAnnotationComposer get createdByUserId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> workspaceMembershipsRefs<T extends Object>(
    Expression<T> Function($$WorkspaceMembershipsTableAnnotationComposer a) f,
  ) {
    final $$WorkspaceMembershipsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workspaceMemberships,
          getReferencedColumn: (t) => t.workspaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkspaceMembershipsTableAnnotationComposer(
                $db: $db,
                $table: $db.workspaceMemberships,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> speciesRefs<T extends Object>(
    Expression<T> Function($$SpeciesTableAnnotationComposer a) f,
  ) {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> animalProfilesRefs<T extends Object>(
    Expression<T> Function($$AnimalProfilesTableAnnotationComposer a) f,
  ) {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> speciesAttributeValuesRefs<T extends Object>(
    Expression<T> Function($$SpeciesAttributeValuesTableAnnotationComposer a) f,
  ) {
    final $$SpeciesAttributeValuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeValues,
          getReferencedColumn: (t) => t.workspaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeValuesTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesAttributeValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> careSchedulesRefs<T extends Object>(
    Expression<T> Function($$CareSchedulesTableAnnotationComposer a) f,
  ) {
    final $$CareSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careRecordsRefs<T extends Object>(
    Expression<T> Function($$CareRecordsTableAnnotationComposer a) f,
  ) {
    final $$CareRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRecords,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.careRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> groupMembershipsRefs<T extends Object>(
    Expression<T> Function($$GroupMembershipsTableAnnotationComposer a) f,
  ) {
    final $$GroupMembershipsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupMemberships,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupMembershipsTableAnnotationComposer(
            $db: $db,
            $table: $db.groupMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitatsRefs<T extends Object>(
    Expression<T> Function($$HabitatsTableAnnotationComposer a) f,
  ) {
    final $$HabitatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> animalHabitatAssignmentsRefs<T extends Object>(
    Expression<T> Function($$AnimalHabitatAssignmentsTableAnnotationComposer a)
    f,
  ) {
    final $$AnimalHabitatAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.animalHabitatAssignments,
          getReferencedColumn: (t) => t.workspaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnimalHabitatAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.animalHabitatAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> syncOutboxRefs<T extends Object>(
    Expression<T> Function($$SyncOutboxTableAnnotationComposer a) f,
  ) {
    final $$SyncOutboxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncOutbox,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncOutboxTableAnnotationComposer(
            $db: $db,
            $table: $db.syncOutbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkspacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkspacesTable,
          Workspace,
          $$WorkspacesTableFilterComposer,
          $$WorkspacesTableOrderingComposer,
          $$WorkspacesTableAnnotationComposer,
          $$WorkspacesTableCreateCompanionBuilder,
          $$WorkspacesTableUpdateCompanionBuilder,
          (Workspace, $$WorkspacesTableReferences),
          Workspace,
          PrefetchHooks Function({
            bool createdByUserId,
            bool workspaceMembershipsRefs,
            bool speciesRefs,
            bool animalProfilesRefs,
            bool speciesAttributeValuesRefs,
            bool careSchedulesRefs,
            bool careRecordsRefs,
            bool groupMembershipsRefs,
            bool habitatsRefs,
            bool animalHabitatAssignmentsRefs,
            bool syncOutboxRefs,
          })
        > {
  $$WorkspacesTableTableManager(_$AppDatabase db, $WorkspacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkspacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkspacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkspacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceType = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> createdByUserId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspacesCompanion(
                id: id,
                workspaceType: workspaceType,
                name: name,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceType,
                required String name,
                required String createdByUserId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspacesCompanion.insert(
                id: id,
                workspaceType: workspaceType,
                name: name,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkspacesTable, Workspace>(table),
                  $$WorkspacesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                createdByUserId = false,
                workspaceMembershipsRefs = false,
                speciesRefs = false,
                animalProfilesRefs = false,
                speciesAttributeValuesRefs = false,
                careSchedulesRefs = false,
                careRecordsRefs = false,
                groupMembershipsRefs = false,
                habitatsRefs = false,
                animalHabitatAssignmentsRefs = false,
                syncOutboxRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workspaceMembershipsRefs) db.workspaceMemberships,
                    if (speciesRefs) db.species,
                    if (animalProfilesRefs) db.animalProfiles,
                    if (speciesAttributeValuesRefs) db.speciesAttributeValues,
                    if (careSchedulesRefs) db.careSchedules,
                    if (careRecordsRefs) db.careRecords,
                    if (groupMembershipsRefs) db.groupMemberships,
                    if (habitatsRefs) db.habitats,
                    if (animalHabitatAssignmentsRefs)
                      db.animalHabitatAssignments,
                    if (syncOutboxRefs) db.syncOutbox,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (createdByUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdByUserId,
                                    referencedTable: $$WorkspacesTableReferences
                                        ._createdByUserIdTable(db),
                                    referencedColumn:
                                        $$WorkspacesTableReferences
                                            ._createdByUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workspaceMembershipsRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          WorkspaceMembership,
                          $WorkspaceMembershipsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._workspaceMembershipsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).workspaceMembershipsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (speciesRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          SpeciesData,
                          $SpeciesTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._speciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (animalProfilesRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          AnimalProfile,
                          $AnimalProfilesTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._animalProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).animalProfilesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (speciesAttributeValuesRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          SpeciesAttributeValue,
                          $SpeciesAttributeValuesTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._speciesAttributeValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesAttributeValuesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (careSchedulesRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          CareSchedule,
                          $CareSchedulesTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._careSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).careSchedulesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (careRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          CareRecord,
                          $CareRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._careRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).careRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (groupMembershipsRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          GroupMembership,
                          $GroupMembershipsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._groupMembershipsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).groupMembershipsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (habitatsRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          Habitat,
                          $HabitatsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._habitatsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).habitatsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (animalHabitatAssignmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          AnimalHabitatAssignment,
                          $AnimalHabitatAssignmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._animalHabitatAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).animalHabitatAssignmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                      if (syncOutboxRefs)
                        await $_getPrefetchedDataByColumns<
                          Workspace,
                          $WorkspacesTable,
                          SyncOutboxData,
                          $SyncOutboxTable
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._syncOutboxRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncOutboxRefs,
                          currentColumn: 'id',
                          referencedColumn: 'workspace_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkspacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkspacesTable,
      Workspace,
      $$WorkspacesTableFilterComposer,
      $$WorkspacesTableOrderingComposer,
      $$WorkspacesTableAnnotationComposer,
      $$WorkspacesTableCreateCompanionBuilder,
      $$WorkspacesTableUpdateCompanionBuilder,
      (Workspace, $$WorkspacesTableReferences),
      Workspace,
      PrefetchHooks Function({
        bool createdByUserId,
        bool workspaceMembershipsRefs,
        bool speciesRefs,
        bool animalProfilesRefs,
        bool speciesAttributeValuesRefs,
        bool careSchedulesRefs,
        bool careRecordsRefs,
        bool groupMembershipsRefs,
        bool habitatsRefs,
        bool animalHabitatAssignmentsRefs,
        bool syncOutboxRefs,
      })
    >;
typedef $$WorkspaceMembershipsTableCreateCompanionBuilder =
    WorkspaceMembershipsCompanion Function({
      required String id,
      required String workspaceId,
      required String userId,
      required String role,
      required String membershipStatus,
      Value<DateTime?> joinedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WorkspaceMembershipsTableUpdateCompanionBuilder =
    WorkspaceMembershipsCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> userId,
      Value<String> role,
      Value<String> membershipStatus,
      Value<DateTime?> joinedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WorkspaceMembershipsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkspaceMembershipsTable,
          WorkspaceMembership
        > {
  $$WorkspaceMembershipsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('workspace_memberships__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppUsersTable _userIdTable(_$AppDatabase db) =>
      db.appUsers.createAlias('workspace_memberships__user_id__app_users__id');

  $$AppUsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkspaceMembershipsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspaceMembershipsTable> {
  $$WorkspaceMembershipsTableFilterComposer({
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

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get membershipStatus => $composableBuilder(
    column: $table.membershipStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
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

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableFilterComposer get userId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkspaceMembershipsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspaceMembershipsTable> {
  $$WorkspaceMembershipsTableOrderingComposer({
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

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get membershipStatus => $composableBuilder(
    column: $table.membershipStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
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

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableOrderingComposer get userId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkspaceMembershipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspaceMembershipsTable> {
  $$WorkspaceMembershipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get membershipStatus => $composableBuilder(
    column: $table.membershipStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableAnnotationComposer get userId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkspaceMembershipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkspaceMembershipsTable,
          WorkspaceMembership,
          $$WorkspaceMembershipsTableFilterComposer,
          $$WorkspaceMembershipsTableOrderingComposer,
          $$WorkspaceMembershipsTableAnnotationComposer,
          $$WorkspaceMembershipsTableCreateCompanionBuilder,
          $$WorkspaceMembershipsTableUpdateCompanionBuilder,
          (WorkspaceMembership, $$WorkspaceMembershipsTableReferences),
          WorkspaceMembership,
          PrefetchHooks Function({bool workspaceId, bool userId})
        > {
  $$WorkspaceMembershipsTableTableManager(
    _$AppDatabase db,
    $WorkspaceMembershipsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkspaceMembershipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkspaceMembershipsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkspaceMembershipsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> membershipStatus = const Value.absent(),
                Value<DateTime?> joinedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspaceMembershipsCompanion(
                id: id,
                workspaceId: workspaceId,
                userId: userId,
                role: role,
                membershipStatus: membershipStatus,
                joinedAt: joinedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String userId,
                required String role,
                required String membershipStatus,
                Value<DateTime?> joinedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkspaceMembershipsCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                userId: userId,
                role: role,
                membershipStatus: membershipStatus,
                joinedAt: joinedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkspaceMembershipsTable, WorkspaceMembership>(
                    table,
                  ),
                  $$WorkspaceMembershipsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workspaceId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (workspaceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workspaceId,
                                referencedTable:
                                    $$WorkspaceMembershipsTableReferences
                                        ._workspaceIdTable(db),
                                referencedColumn:
                                    $$WorkspaceMembershipsTableReferences
                                        ._workspaceIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$WorkspaceMembershipsTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$WorkspaceMembershipsTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkspaceMembershipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkspaceMembershipsTable,
      WorkspaceMembership,
      $$WorkspaceMembershipsTableFilterComposer,
      $$WorkspaceMembershipsTableOrderingComposer,
      $$WorkspaceMembershipsTableAnnotationComposer,
      $$WorkspaceMembershipsTableCreateCompanionBuilder,
      $$WorkspaceMembershipsTableUpdateCompanionBuilder,
      (WorkspaceMembership, $$WorkspaceMembershipsTableReferences),
      WorkspaceMembership,
      PrefetchHooks Function({bool workspaceId, bool userId})
    >;
typedef $$SpeciesTableCreateCompanionBuilder =
    SpeciesCompanion Function({
      required String id,
      required String origin,
      Value<String?> workspaceId,
      required String taxonomicRank,
      Value<String?> scientificName,
      required String commonName,
      required String categoryKey,
      Value<String?> parentTaxonId,
      required String catalogStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$SpeciesTableUpdateCompanionBuilder =
    SpeciesCompanion Function({
      Value<String> id,
      Value<String> origin,
      Value<String?> workspaceId,
      Value<String> taxonomicRank,
      Value<String?> scientificName,
      Value<String> commonName,
      Value<String> categoryKey,
      Value<String?> parentTaxonId,
      Value<String> catalogStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$SpeciesTableReferences
    extends BaseReferences<_$AppDatabase, $SpeciesTable, SpeciesData> {
  $$SpeciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) =>
      db.workspaces.createAlias('species__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager? get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id');
    if ($_column == null) return null;
    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SpeciesTable _parentTaxonIdTable(_$AppDatabase db) =>
      db.species.createAlias('species__parent_taxon_id__species__id');

  $$SpeciesTableProcessedTableManager? get parentTaxonId {
    final $_column = $_itemColumn<String>('parent_taxon_id');
    if ($_column == null) return null;
    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTaxonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SpeciesSourcesTable, List<SpeciesSource>>
  _speciesSourcesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.speciesSources,
    aliasName: 'species__id__species_sources__species_id',
  );

  $$SpeciesSourcesTableProcessedTableManager get speciesSourcesRefs {
    final manager = $$SpeciesSourcesTableTableManager(
      $_db,
      $_db.speciesSources,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_speciesSourcesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SpeciesAttributeDefinitionsTable,
    List<SpeciesAttributeDefinition>
  >
  _speciesAttributeDefinitionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speciesAttributeDefinitions,
        aliasName: 'species__id__species_attribute_definitions__species_id',
      );

  $$SpeciesAttributeDefinitionsTableProcessedTableManager
  get speciesAttributeDefinitionsRefs {
    final manager = $$SpeciesAttributeDefinitionsTableTableManager(
      $_db,
      $_db.speciesAttributeDefinitions,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _speciesAttributeDefinitionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnimalProfilesTable, List<AnimalProfile>>
  _animalProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.animalProfiles,
    aliasName: 'species__id__animal_profiles__species_id',
  );

  $$AnimalProfilesTableProcessedTableManager get animalProfilesRefs {
    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_animalProfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpeciesTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesTable> {
  $$SpeciesTableFilterComposer({
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

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxonomicRank => $composableBuilder(
    column: $table.taxonomicRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catalogStatus => $composableBuilder(
    column: $table.catalogStatus,
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

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableFilterComposer get parentTaxonId {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentTaxonId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> speciesSourcesRefs(
    Expression<bool> Function($$SpeciesSourcesTableFilterComposer f) f,
  ) {
    final $$SpeciesSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.speciesSources,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesSourcesTableFilterComposer(
            $db: $db,
            $table: $db.speciesSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> speciesAttributeDefinitionsRefs(
    Expression<bool> Function(
      $$SpeciesAttributeDefinitionsTableFilterComposer f,
    )
    f,
  ) {
    final $$SpeciesAttributeDefinitionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeDefinitions,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeDefinitionsTableFilterComposer(
                $db: $db,
                $table: $db.speciesAttributeDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> animalProfilesRefs(
    Expression<bool> Function($$AnimalProfilesTableFilterComposer f) f,
  ) {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesTable> {
  $$SpeciesTableOrderingComposer({
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

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxonomicRank => $composableBuilder(
    column: $table.taxonomicRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catalogStatus => $composableBuilder(
    column: $table.catalogStatus,
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

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableOrderingComposer get parentTaxonId {
    final $$SpeciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentTaxonId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableOrderingComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesTable> {
  $$SpeciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get taxonomicRank => $composableBuilder(
    column: $table.taxonomicRank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get catalogStatus => $composableBuilder(
    column: $table.catalogStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableAnnotationComposer get parentTaxonId {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentTaxonId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> speciesSourcesRefs<T extends Object>(
    Expression<T> Function($$SpeciesSourcesTableAnnotationComposer a) f,
  ) {
    final $$SpeciesSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.speciesSources,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> speciesAttributeDefinitionsRefs<T extends Object>(
    Expression<T> Function(
      $$SpeciesAttributeDefinitionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$SpeciesAttributeDefinitionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeDefinitions,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeDefinitionsTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesAttributeDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> animalProfilesRefs<T extends Object>(
    Expression<T> Function($$AnimalProfilesTableAnnotationComposer a) f,
  ) {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesTable,
          SpeciesData,
          $$SpeciesTableFilterComposer,
          $$SpeciesTableOrderingComposer,
          $$SpeciesTableAnnotationComposer,
          $$SpeciesTableCreateCompanionBuilder,
          $$SpeciesTableUpdateCompanionBuilder,
          (SpeciesData, $$SpeciesTableReferences),
          SpeciesData,
          PrefetchHooks Function({
            bool workspaceId,
            bool parentTaxonId,
            bool speciesSourcesRefs,
            bool speciesAttributeDefinitionsRefs,
            bool animalProfilesRefs,
          })
        > {
  $$SpeciesTableTableManager(_$AppDatabase db, $SpeciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpeciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpeciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String?> workspaceId = const Value.absent(),
                Value<String> taxonomicRank = const Value.absent(),
                Value<String?> scientificName = const Value.absent(),
                Value<String> commonName = const Value.absent(),
                Value<String> categoryKey = const Value.absent(),
                Value<String?> parentTaxonId = const Value.absent(),
                Value<String> catalogStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesCompanion(
                id: id,
                origin: origin,
                workspaceId: workspaceId,
                taxonomicRank: taxonomicRank,
                scientificName: scientificName,
                commonName: commonName,
                categoryKey: categoryKey,
                parentTaxonId: parentTaxonId,
                catalogStatus: catalogStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String origin,
                Value<String?> workspaceId = const Value.absent(),
                required String taxonomicRank,
                Value<String?> scientificName = const Value.absent(),
                required String commonName,
                required String categoryKey,
                Value<String?> parentTaxonId = const Value.absent(),
                required String catalogStatus,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesCompanion.insert(
                id: id,
                origin: origin,
                workspaceId: workspaceId,
                taxonomicRank: taxonomicRank,
                scientificName: scientificName,
                commonName: commonName,
                categoryKey: categoryKey,
                parentTaxonId: parentTaxonId,
                catalogStatus: catalogStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpeciesTable, SpeciesData>(table),
                  $$SpeciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                parentTaxonId = false,
                speciesSourcesRefs = false,
                speciesAttributeDefinitionsRefs = false,
                animalProfilesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (speciesSourcesRefs) db.speciesSources,
                    if (speciesAttributeDefinitionsRefs)
                      db.speciesAttributeDefinitions,
                    if (animalProfilesRefs) db.animalProfiles,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable: $$SpeciesTableReferences
                                        ._workspaceIdTable(db),
                                    referencedColumn: $$SpeciesTableReferences
                                        ._workspaceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (parentTaxonId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentTaxonId,
                                    referencedTable: $$SpeciesTableReferences
                                        ._parentTaxonIdTable(db),
                                    referencedColumn: $$SpeciesTableReferences
                                        ._parentTaxonIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (speciesSourcesRefs)
                        await $_getPrefetchedDataByColumns<
                          SpeciesData,
                          $SpeciesTable,
                          SpeciesSource,
                          $SpeciesSourcesTable
                        >(
                          currentTable: table,
                          referencedTable: $$SpeciesTableReferences
                              ._speciesSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesSourcesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
                          typedResults: items,
                        ),
                      if (speciesAttributeDefinitionsRefs)
                        await $_getPrefetchedDataByColumns<
                          SpeciesData,
                          $SpeciesTable,
                          SpeciesAttributeDefinition,
                          $SpeciesAttributeDefinitionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SpeciesTableReferences
                              ._speciesAttributeDefinitionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesAttributeDefinitionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
                          typedResults: items,
                        ),
                      if (animalProfilesRefs)
                        await $_getPrefetchedDataByColumns<
                          SpeciesData,
                          $SpeciesTable,
                          AnimalProfile,
                          $AnimalProfilesTable
                        >(
                          currentTable: table,
                          referencedTable: $$SpeciesTableReferences
                              ._animalProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesTableReferences(
                                db,
                                table,
                                p0,
                              ).animalProfilesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'species_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SpeciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesTable,
      SpeciesData,
      $$SpeciesTableFilterComposer,
      $$SpeciesTableOrderingComposer,
      $$SpeciesTableAnnotationComposer,
      $$SpeciesTableCreateCompanionBuilder,
      $$SpeciesTableUpdateCompanionBuilder,
      (SpeciesData, $$SpeciesTableReferences),
      SpeciesData,
      PrefetchHooks Function({
        bool workspaceId,
        bool parentTaxonId,
        bool speciesSourcesRefs,
        bool speciesAttributeDefinitionsRefs,
        bool animalProfilesRefs,
      })
    >;
typedef $$SpeciesSourcesTableCreateCompanionBuilder =
    SpeciesSourcesCompanion Function({
      required String id,
      required String speciesId,
      required String sourceName,
      Value<String?> sourceUrl,
      Value<String?> publisher,
      Value<DateTime?> accessedAt,
      Value<String?> licenseOrUsageNote,
      Value<String> validationStatus,
      Value<String?> reviewedBy,
      Value<DateTime?> reviewedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SpeciesSourcesTableUpdateCompanionBuilder =
    SpeciesSourcesCompanion Function({
      Value<String> id,
      Value<String> speciesId,
      Value<String> sourceName,
      Value<String?> sourceUrl,
      Value<String?> publisher,
      Value<DateTime?> accessedAt,
      Value<String?> licenseOrUsageNote,
      Value<String> validationStatus,
      Value<String?> reviewedBy,
      Value<DateTime?> reviewedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SpeciesSourcesTableReferences
    extends BaseReferences<_$AppDatabase, $SpeciesSourcesTable, SpeciesSource> {
  $$SpeciesSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpeciesTable _speciesIdTable(_$AppDatabase db) =>
      db.species.createAlias('species_sources__species_id__species__id');

  $$SpeciesTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<String>('species_id')!;

    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpeciesSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesSourcesTable> {
  $$SpeciesSourcesTableFilterComposer({
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

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseOrUsageNote => $composableBuilder(
    column: $table.licenseOrUsageNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validationStatus => $composableBuilder(
    column: $table.validationStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewedBy => $composableBuilder(
    column: $table.reviewedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SpeciesTableFilterComposer get speciesId {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesSourcesTable> {
  $$SpeciesSourcesTableOrderingComposer({
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

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseOrUsageNote => $composableBuilder(
    column: $table.licenseOrUsageNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validationStatus => $composableBuilder(
    column: $table.validationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewedBy => $composableBuilder(
    column: $table.reviewedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpeciesTableOrderingComposer get speciesId {
    final $$SpeciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableOrderingComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesSourcesTable> {
  $$SpeciesSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenseOrUsageNote => $composableBuilder(
    column: $table.licenseOrUsageNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get validationStatus => $composableBuilder(
    column: $table.validationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewedBy => $composableBuilder(
    column: $table.reviewedBy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SpeciesTableAnnotationComposer get speciesId {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesSourcesTable,
          SpeciesSource,
          $$SpeciesSourcesTableFilterComposer,
          $$SpeciesSourcesTableOrderingComposer,
          $$SpeciesSourcesTableAnnotationComposer,
          $$SpeciesSourcesTableCreateCompanionBuilder,
          $$SpeciesSourcesTableUpdateCompanionBuilder,
          (SpeciesSource, $$SpeciesSourcesTableReferences),
          SpeciesSource,
          PrefetchHooks Function({bool speciesId})
        > {
  $$SpeciesSourcesTableTableManager(
    _$AppDatabase db,
    $SpeciesSourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpeciesSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpeciesSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<String> sourceName = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<DateTime?> accessedAt = const Value.absent(),
                Value<String?> licenseOrUsageNote = const Value.absent(),
                Value<String> validationStatus = const Value.absent(),
                Value<String?> reviewedBy = const Value.absent(),
                Value<DateTime?> reviewedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesSourcesCompanion(
                id: id,
                speciesId: speciesId,
                sourceName: sourceName,
                sourceUrl: sourceUrl,
                publisher: publisher,
                accessedAt: accessedAt,
                licenseOrUsageNote: licenseOrUsageNote,
                validationStatus: validationStatus,
                reviewedBy: reviewedBy,
                reviewedAt: reviewedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String speciesId,
                required String sourceName,
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<DateTime?> accessedAt = const Value.absent(),
                Value<String?> licenseOrUsageNote = const Value.absent(),
                Value<String> validationStatus = const Value.absent(),
                Value<String?> reviewedBy = const Value.absent(),
                Value<DateTime?> reviewedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SpeciesSourcesCompanion.insert(
                id: id,
                speciesId: speciesId,
                sourceName: sourceName,
                sourceUrl: sourceUrl,
                publisher: publisher,
                accessedAt: accessedAt,
                licenseOrUsageNote: licenseOrUsageNote,
                validationStatus: validationStatus,
                reviewedBy: reviewedBy,
                reviewedAt: reviewedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpeciesSourcesTable, SpeciesSource>(table),
                  $$SpeciesSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({speciesId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (speciesId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.speciesId,
                                referencedTable: $$SpeciesSourcesTableReferences
                                    ._speciesIdTable(db),
                                referencedColumn:
                                    $$SpeciesSourcesTableReferences
                                        ._speciesIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SpeciesSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesSourcesTable,
      SpeciesSource,
      $$SpeciesSourcesTableFilterComposer,
      $$SpeciesSourcesTableOrderingComposer,
      $$SpeciesSourcesTableAnnotationComposer,
      $$SpeciesSourcesTableCreateCompanionBuilder,
      $$SpeciesSourcesTableUpdateCompanionBuilder,
      (SpeciesSource, $$SpeciesSourcesTableReferences),
      SpeciesSource,
      PrefetchHooks Function({bool speciesId})
    >;
typedef $$SpeciesAttributeDefinitionsTableCreateCompanionBuilder =
    SpeciesAttributeDefinitionsCompanion Function({
      required String id,
      required String speciesId,
      required String key,
      required String label,
      required String category,
      required String valueType,
      required String appliesTo,
      Value<String?> unitCode,
      Value<String?> optionsJson,
      Value<String?> validationRulesJson,
      Value<bool> isRequired,
      Value<int> definitionVersion,
      Value<int> displayOrder,
      Value<String> status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SpeciesAttributeDefinitionsTableUpdateCompanionBuilder =
    SpeciesAttributeDefinitionsCompanion Function({
      Value<String> id,
      Value<String> speciesId,
      Value<String> key,
      Value<String> label,
      Value<String> category,
      Value<String> valueType,
      Value<String> appliesTo,
      Value<String?> unitCode,
      Value<String?> optionsJson,
      Value<String?> validationRulesJson,
      Value<bool> isRequired,
      Value<int> definitionVersion,
      Value<int> displayOrder,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SpeciesAttributeDefinitionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpeciesAttributeDefinitionsTable,
          SpeciesAttributeDefinition
        > {
  $$SpeciesAttributeDefinitionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpeciesTable _speciesIdTable(_$AppDatabase db) => db.species
      .createAlias('species_attribute_definitions__species_id__species__id');

  $$SpeciesTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<String>('species_id')!;

    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SpeciesAttributeValuesTable,
    List<SpeciesAttributeValue>
  >
  _speciesAttributeValuesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.speciesAttributeValues,
    aliasName:
        'species_attribute_definitions__id__species_attribute_values__attribute_definition_id',
  );

  $$SpeciesAttributeValuesTableProcessedTableManager
  get speciesAttributeValuesRefs {
    final manager =
        $$SpeciesAttributeValuesTableTableManager(
          $_db,
          $_db.speciesAttributeValues,
        ).filter(
          (f) =>
              f.attributeDefinitionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _speciesAttributeValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpeciesAttributeDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesAttributeDefinitionsTable> {
  $$SpeciesAttributeDefinitionsTableFilterComposer({
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

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appliesTo => $composableBuilder(
    column: $table.appliesTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitCode => $composableBuilder(
    column: $table.unitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validationRulesJson => $composableBuilder(
    column: $table.validationRulesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get definitionVersion => $composableBuilder(
    column: $table.definitionVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
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

  $$SpeciesTableFilterComposer get speciesId {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> speciesAttributeValuesRefs(
    Expression<bool> Function($$SpeciesAttributeValuesTableFilterComposer f) f,
  ) {
    final $$SpeciesAttributeValuesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeValues,
          getReferencedColumn: (t) => t.attributeDefinitionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeValuesTableFilterComposer(
                $db: $db,
                $table: $db.speciesAttributeValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpeciesAttributeDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesAttributeDefinitionsTable> {
  $$SpeciesAttributeDefinitionsTableOrderingComposer({
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

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appliesTo => $composableBuilder(
    column: $table.appliesTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitCode => $composableBuilder(
    column: $table.unitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validationRulesJson => $composableBuilder(
    column: $table.validationRulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get definitionVersion => $composableBuilder(
    column: $table.definitionVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
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

  $$SpeciesTableOrderingComposer get speciesId {
    final $$SpeciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableOrderingComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesAttributeDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesAttributeDefinitionsTable> {
  $$SpeciesAttributeDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get valueType =>
      $composableBuilder(column: $table.valueType, builder: (column) => column);

  GeneratedColumn<String> get appliesTo =>
      $composableBuilder(column: $table.appliesTo, builder: (column) => column);

  GeneratedColumn<String> get unitCode =>
      $composableBuilder(column: $table.unitCode, builder: (column) => column);

  GeneratedColumn<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get validationRulesJson => $composableBuilder(
    column: $table.validationRulesJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  GeneratedColumn<int> get definitionVersion => $composableBuilder(
    column: $table.definitionVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SpeciesTableAnnotationComposer get speciesId {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> speciesAttributeValuesRefs<T extends Object>(
    Expression<T> Function($$SpeciesAttributeValuesTableAnnotationComposer a) f,
  ) {
    final $$SpeciesAttributeValuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeValues,
          getReferencedColumn: (t) => t.attributeDefinitionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeValuesTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesAttributeValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpeciesAttributeDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesAttributeDefinitionsTable,
          SpeciesAttributeDefinition,
          $$SpeciesAttributeDefinitionsTableFilterComposer,
          $$SpeciesAttributeDefinitionsTableOrderingComposer,
          $$SpeciesAttributeDefinitionsTableAnnotationComposer,
          $$SpeciesAttributeDefinitionsTableCreateCompanionBuilder,
          $$SpeciesAttributeDefinitionsTableUpdateCompanionBuilder,
          (
            SpeciesAttributeDefinition,
            $$SpeciesAttributeDefinitionsTableReferences,
          ),
          SpeciesAttributeDefinition,
          PrefetchHooks Function({
            bool speciesId,
            bool speciesAttributeValuesRefs,
          })
        > {
  $$SpeciesAttributeDefinitionsTableTableManager(
    _$AppDatabase db,
    $SpeciesAttributeDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesAttributeDefinitionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpeciesAttributeDefinitionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpeciesAttributeDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> valueType = const Value.absent(),
                Value<String> appliesTo = const Value.absent(),
                Value<String?> unitCode = const Value.absent(),
                Value<String?> optionsJson = const Value.absent(),
                Value<String?> validationRulesJson = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<int> definitionVersion = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesAttributeDefinitionsCompanion(
                id: id,
                speciesId: speciesId,
                key: key,
                label: label,
                category: category,
                valueType: valueType,
                appliesTo: appliesTo,
                unitCode: unitCode,
                optionsJson: optionsJson,
                validationRulesJson: validationRulesJson,
                isRequired: isRequired,
                definitionVersion: definitionVersion,
                displayOrder: displayOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String speciesId,
                required String key,
                required String label,
                required String category,
                required String valueType,
                required String appliesTo,
                Value<String?> unitCode = const Value.absent(),
                Value<String?> optionsJson = const Value.absent(),
                Value<String?> validationRulesJson = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<int> definitionVersion = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SpeciesAttributeDefinitionsCompanion.insert(
                id: id,
                speciesId: speciesId,
                key: key,
                label: label,
                category: category,
                valueType: valueType,
                appliesTo: appliesTo,
                unitCode: unitCode,
                optionsJson: optionsJson,
                validationRulesJson: validationRulesJson,
                isRequired: isRequired,
                definitionVersion: definitionVersion,
                displayOrder: displayOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $SpeciesAttributeDefinitionsTable,
                    SpeciesAttributeDefinition
                  >(table),
                  $$SpeciesAttributeDefinitionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({speciesId = false, speciesAttributeValuesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (speciesAttributeValuesRefs) db.speciesAttributeValues,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (speciesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.speciesId,
                                    referencedTable:
                                        $$SpeciesAttributeDefinitionsTableReferences
                                            ._speciesIdTable(db),
                                    referencedColumn:
                                        $$SpeciesAttributeDefinitionsTableReferences
                                            ._speciesIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (speciesAttributeValuesRefs)
                        await $_getPrefetchedDataByColumns<
                          SpeciesAttributeDefinition,
                          $SpeciesAttributeDefinitionsTable,
                          SpeciesAttributeValue,
                          $SpeciesAttributeValuesTable
                        >(
                          currentTable: table,
                          referencedTable:
                              $$SpeciesAttributeDefinitionsTableReferences
                                  ._speciesAttributeValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesAttributeDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesAttributeValuesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'attribute_definition_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SpeciesAttributeDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesAttributeDefinitionsTable,
      SpeciesAttributeDefinition,
      $$SpeciesAttributeDefinitionsTableFilterComposer,
      $$SpeciesAttributeDefinitionsTableOrderingComposer,
      $$SpeciesAttributeDefinitionsTableAnnotationComposer,
      $$SpeciesAttributeDefinitionsTableCreateCompanionBuilder,
      $$SpeciesAttributeDefinitionsTableUpdateCompanionBuilder,
      (
        SpeciesAttributeDefinition,
        $$SpeciesAttributeDefinitionsTableReferences,
      ),
      SpeciesAttributeDefinition,
      PrefetchHooks Function({bool speciesId, bool speciesAttributeValuesRefs})
    >;
typedef $$AnimalProfilesTableCreateCompanionBuilder =
    AnimalProfilesCompanion Function({
      required String id,
      required String workspaceId,
      required String recordKind,
      required String displayName,
      Value<String?> speciesId,
      Value<String> profileStatus,
      Value<String?> notes,
      Value<String?> identificationType,
      Value<String?> identificationValue,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$AnimalProfilesTableUpdateCompanionBuilder =
    AnimalProfilesCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> recordKind,
      Value<String> displayName,
      Value<String?> speciesId,
      Value<String> profileStatus,
      Value<String?> notes,
      Value<String?> identificationType,
      Value<String?> identificationValue,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$AnimalProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $AnimalProfilesTable, AnimalProfile> {
  $$AnimalProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('animal_profiles__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SpeciesTable _speciesIdTable(_$AppDatabase db) =>
      db.species.createAlias('animal_profiles__species_id__species__id');

  $$SpeciesTableProcessedTableManager? get speciesId {
    final $_column = $_itemColumn<String>('species_id');
    if ($_column == null) return null;
    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SpeciesAttributeValuesTable,
    List<SpeciesAttributeValue>
  >
  _speciesAttributeValuesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speciesAttributeValues,
        aliasName:
            'animal_profiles__id__species_attribute_values__animal_profile_id',
      );

  $$SpeciesAttributeValuesTableProcessedTableManager
  get speciesAttributeValuesRefs {
    final manager =
        $$SpeciesAttributeValuesTableTableManager(
          $_db,
          $_db.speciesAttributeValues,
        ).filter(
          (f) => f.animalProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _speciesAttributeValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareSchedulesTable, List<CareSchedule>>
  _careSchedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careSchedules,
    aliasName: 'animal_profiles__id__care_schedules__animal_profile_id',
  );

  $$CareSchedulesTableProcessedTableManager get careSchedulesRefs {
    final manager = $$CareSchedulesTableTableManager($_db, $_db.careSchedules)
        .filter(
          (f) => f.animalProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_careSchedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareRecordsTable, List<CareRecord>>
  _careRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRecords,
    aliasName: 'animal_profiles__id__care_records__animal_profile_id',
  );

  $$CareRecordsTableProcessedTableManager get careRecordsRefs {
    final manager = $$CareRecordsTableTableManager($_db, $_db.careRecords)
        .filter(
          (f) => f.animalProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_careRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$IndividualDetailsTable, List<IndividualDetail>>
  _individualDetailsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.individualDetails,
        aliasName: 'animal_profiles__id__individual_details__animal_profile_id',
      );

  $$IndividualDetailsTableProcessedTableManager get individualDetailsRefs {
    final manager =
        $$IndividualDetailsTableTableManager(
          $_db,
          $_db.individualDetails,
        ).filter(
          (f) => f.animalProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _individualDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupDetailsTable, List<GroupDetail>>
  _groupDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.groupDetails,
    aliasName: 'animal_profiles__id__group_details__animal_profile_id',
  );

  $$GroupDetailsTableProcessedTableManager get groupDetailsRefs {
    final manager = $$GroupDetailsTableTableManager($_db, $_db.groupDetails)
        .filter(
          (f) => f.animalProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_groupDetailsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupMembershipsTable, List<GroupMembership>>
  _membershipsAsGroupTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.groupMemberships,
    aliasName: 'animal_profiles__id__group_memberships__group_profile_id',
  );

  $$GroupMembershipsTableProcessedTableManager get membershipsAsGroup {
    final manager = $$GroupMembershipsTableTableManager(
      $_db,
      $_db.groupMemberships,
    ).filter((f) => f.groupProfileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_membershipsAsGroupTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupMembershipsTable, List<GroupMembership>>
  _membershipsAsIndividualTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.groupMemberships,
        aliasName:
            'animal_profiles__id__group_memberships__individual_profile_id',
      );

  $$GroupMembershipsTableProcessedTableManager get membershipsAsIndividual {
    final manager =
        $$GroupMembershipsTableTableManager($_db, $_db.groupMemberships).filter(
          (f) =>
              f.individualProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _membershipsAsIndividualTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $AnimalHabitatAssignmentsTable,
    List<AnimalHabitatAssignment>
  >
  _animalHabitatAssignmentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.animalHabitatAssignments,
    aliasName:
        'animal_profiles__id__animal_habitat_assignments__animal_profile_id',
  );

  $$AnimalHabitatAssignmentsTableProcessedTableManager
  get animalHabitatAssignmentsRefs {
    final manager =
        $$AnimalHabitatAssignmentsTableTableManager(
          $_db,
          $_db.animalHabitatAssignments,
        ).filter(
          (f) => f.animalProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _animalHabitatAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AnimalProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalProfilesTable> {
  $$AnimalProfilesTableFilterComposer({
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

  ColumnFilters<String> get recordKind => $composableBuilder(
    column: $table.recordKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileStatus => $composableBuilder(
    column: $table.profileStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identificationType => $composableBuilder(
    column: $table.identificationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identificationValue => $composableBuilder(
    column: $table.identificationValue,
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

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableFilterComposer get speciesId {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> speciesAttributeValuesRefs(
    Expression<bool> Function($$SpeciesAttributeValuesTableFilterComposer f) f,
  ) {
    final $$SpeciesAttributeValuesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeValues,
          getReferencedColumn: (t) => t.animalProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeValuesTableFilterComposer(
                $db: $db,
                $table: $db.speciesAttributeValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> careSchedulesRefs(
    Expression<bool> Function($$CareSchedulesTableFilterComposer f) f,
  ) {
    final $$CareSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careRecordsRefs(
    Expression<bool> Function($$CareRecordsTableFilterComposer f) f,
  ) {
    final $$CareRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRecords,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRecordsTableFilterComposer(
            $db: $db,
            $table: $db.careRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> individualDetailsRefs(
    Expression<bool> Function($$IndividualDetailsTableFilterComposer f) f,
  ) {
    final $$IndividualDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.individualDetails,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualDetailsTableFilterComposer(
            $db: $db,
            $table: $db.individualDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupDetailsRefs(
    Expression<bool> Function($$GroupDetailsTableFilterComposer f) f,
  ) {
    final $$GroupDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupDetails,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupDetailsTableFilterComposer(
            $db: $db,
            $table: $db.groupDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> membershipsAsGroup(
    Expression<bool> Function($$GroupMembershipsTableFilterComposer f) f,
  ) {
    final $$GroupMembershipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupMemberships,
      getReferencedColumn: (t) => t.groupProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupMembershipsTableFilterComposer(
            $db: $db,
            $table: $db.groupMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> membershipsAsIndividual(
    Expression<bool> Function($$GroupMembershipsTableFilterComposer f) f,
  ) {
    final $$GroupMembershipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupMemberships,
      getReferencedColumn: (t) => t.individualProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupMembershipsTableFilterComposer(
            $db: $db,
            $table: $db.groupMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> animalHabitatAssignmentsRefs(
    Expression<bool> Function($$AnimalHabitatAssignmentsTableFilterComposer f)
    f,
  ) {
    final $$AnimalHabitatAssignmentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.animalHabitatAssignments,
          getReferencedColumn: (t) => t.animalProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnimalHabitatAssignmentsTableFilterComposer(
                $db: $db,
                $table: $db.animalHabitatAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AnimalProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalProfilesTable> {
  $$AnimalProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get recordKind => $composableBuilder(
    column: $table.recordKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileStatus => $composableBuilder(
    column: $table.profileStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identificationType => $composableBuilder(
    column: $table.identificationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identificationValue => $composableBuilder(
    column: $table.identificationValue,
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

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableOrderingComposer get speciesId {
    final $$SpeciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableOrderingComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimalProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalProfilesTable> {
  $$AnimalProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordKind => $composableBuilder(
    column: $table.recordKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profileStatus => $composableBuilder(
    column: $table.profileStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get identificationType => $composableBuilder(
    column: $table.identificationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get identificationValue => $composableBuilder(
    column: $table.identificationValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableAnnotationComposer get speciesId {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> speciesAttributeValuesRefs<T extends Object>(
    Expression<T> Function($$SpeciesAttributeValuesTableAnnotationComposer a) f,
  ) {
    final $$SpeciesAttributeValuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speciesAttributeValues,
          getReferencedColumn: (t) => t.animalProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeValuesTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesAttributeValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> careSchedulesRefs<T extends Object>(
    Expression<T> Function($$CareSchedulesTableAnnotationComposer a) f,
  ) {
    final $$CareSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careRecordsRefs<T extends Object>(
    Expression<T> Function($$CareRecordsTableAnnotationComposer a) f,
  ) {
    final $$CareRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRecords,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.careRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> individualDetailsRefs<T extends Object>(
    Expression<T> Function($$IndividualDetailsTableAnnotationComposer a) f,
  ) {
    final $$IndividualDetailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.individualDetails,
          getReferencedColumn: (t) => t.animalProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IndividualDetailsTableAnnotationComposer(
                $db: $db,
                $table: $db.individualDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> groupDetailsRefs<T extends Object>(
    Expression<T> Function($$GroupDetailsTableAnnotationComposer a) f,
  ) {
    final $$GroupDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupDetails,
      getReferencedColumn: (t) => t.animalProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.groupDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> membershipsAsGroup<T extends Object>(
    Expression<T> Function($$GroupMembershipsTableAnnotationComposer a) f,
  ) {
    final $$GroupMembershipsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupMemberships,
      getReferencedColumn: (t) => t.groupProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupMembershipsTableAnnotationComposer(
            $db: $db,
            $table: $db.groupMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> membershipsAsIndividual<T extends Object>(
    Expression<T> Function($$GroupMembershipsTableAnnotationComposer a) f,
  ) {
    final $$GroupMembershipsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupMemberships,
      getReferencedColumn: (t) => t.individualProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupMembershipsTableAnnotationComposer(
            $db: $db,
            $table: $db.groupMemberships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> animalHabitatAssignmentsRefs<T extends Object>(
    Expression<T> Function($$AnimalHabitatAssignmentsTableAnnotationComposer a)
    f,
  ) {
    final $$AnimalHabitatAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.animalHabitatAssignments,
          getReferencedColumn: (t) => t.animalProfileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnimalHabitatAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.animalHabitatAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AnimalProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimalProfilesTable,
          AnimalProfile,
          $$AnimalProfilesTableFilterComposer,
          $$AnimalProfilesTableOrderingComposer,
          $$AnimalProfilesTableAnnotationComposer,
          $$AnimalProfilesTableCreateCompanionBuilder,
          $$AnimalProfilesTableUpdateCompanionBuilder,
          (AnimalProfile, $$AnimalProfilesTableReferences),
          AnimalProfile,
          PrefetchHooks Function({
            bool workspaceId,
            bool speciesId,
            bool speciesAttributeValuesRefs,
            bool careSchedulesRefs,
            bool careRecordsRefs,
            bool individualDetailsRefs,
            bool groupDetailsRefs,
            bool membershipsAsGroup,
            bool membershipsAsIndividual,
            bool animalHabitatAssignmentsRefs,
          })
        > {
  $$AnimalProfilesTableTableManager(
    _$AppDatabase db,
    $AnimalProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimalProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimalProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> recordKind = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> speciesId = const Value.absent(),
                Value<String> profileStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> identificationType = const Value.absent(),
                Value<String?> identificationValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalProfilesCompanion(
                id: id,
                workspaceId: workspaceId,
                recordKind: recordKind,
                displayName: displayName,
                speciesId: speciesId,
                profileStatus: profileStatus,
                notes: notes,
                identificationType: identificationType,
                identificationValue: identificationValue,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String recordKind,
                required String displayName,
                Value<String?> speciesId = const Value.absent(),
                Value<String> profileStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> identificationType = const Value.absent(),
                Value<String?> identificationValue = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalProfilesCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                recordKind: recordKind,
                displayName: displayName,
                speciesId: speciesId,
                profileStatus: profileStatus,
                notes: notes,
                identificationType: identificationType,
                identificationValue: identificationValue,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AnimalProfilesTable, AnimalProfile>(table),
                  $$AnimalProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                speciesId = false,
                speciesAttributeValuesRefs = false,
                careSchedulesRefs = false,
                careRecordsRefs = false,
                individualDetailsRefs = false,
                groupDetailsRefs = false,
                membershipsAsGroup = false,
                membershipsAsIndividual = false,
                animalHabitatAssignmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (speciesAttributeValuesRefs) db.speciesAttributeValues,
                    if (careSchedulesRefs) db.careSchedules,
                    if (careRecordsRefs) db.careRecords,
                    if (individualDetailsRefs) db.individualDetails,
                    if (groupDetailsRefs) db.groupDetails,
                    if (membershipsAsGroup) db.groupMemberships,
                    if (membershipsAsIndividual) db.groupMemberships,
                    if (animalHabitatAssignmentsRefs)
                      db.animalHabitatAssignments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$AnimalProfilesTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$AnimalProfilesTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (speciesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.speciesId,
                                    referencedTable:
                                        $$AnimalProfilesTableReferences
                                            ._speciesIdTable(db),
                                    referencedColumn:
                                        $$AnimalProfilesTableReferences
                                            ._speciesIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (speciesAttributeValuesRefs)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          SpeciesAttributeValue,
                          $SpeciesAttributeValuesTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._speciesAttributeValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesAttributeValuesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'animal_profile_id',
                          typedResults: items,
                        ),
                      if (careSchedulesRefs)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          CareSchedule,
                          $CareSchedulesTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._careSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).careSchedulesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'animal_profile_id',
                          typedResults: items,
                        ),
                      if (careRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          CareRecord,
                          $CareRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._careRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).careRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'animal_profile_id',
                          typedResults: items,
                        ),
                      if (individualDetailsRefs)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          IndividualDetail,
                          $IndividualDetailsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._individualDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).individualDetailsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'animal_profile_id',
                          typedResults: items,
                        ),
                      if (groupDetailsRefs)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          GroupDetail,
                          $GroupDetailsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._groupDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).groupDetailsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'animal_profile_id',
                          typedResults: items,
                        ),
                      if (membershipsAsGroup)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          GroupMembership,
                          $GroupMembershipsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._membershipsAsGroupTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).membershipsAsGroup,
                          currentColumn: 'id',
                          referencedColumn: 'group_profile_id',
                          typedResults: items,
                        ),
                      if (membershipsAsIndividual)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          GroupMembership,
                          $GroupMembershipsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._membershipsAsIndividualTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).membershipsAsIndividual,
                          currentColumn: 'id',
                          referencedColumn: 'individual_profile_id',
                          typedResults: items,
                        ),
                      if (animalHabitatAssignmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          AnimalProfile,
                          $AnimalProfilesTable,
                          AnimalHabitatAssignment,
                          $AnimalHabitatAssignmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalProfilesTableReferences
                              ._animalHabitatAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).animalHabitatAssignmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'animal_profile_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AnimalProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimalProfilesTable,
      AnimalProfile,
      $$AnimalProfilesTableFilterComposer,
      $$AnimalProfilesTableOrderingComposer,
      $$AnimalProfilesTableAnnotationComposer,
      $$AnimalProfilesTableCreateCompanionBuilder,
      $$AnimalProfilesTableUpdateCompanionBuilder,
      (AnimalProfile, $$AnimalProfilesTableReferences),
      AnimalProfile,
      PrefetchHooks Function({
        bool workspaceId,
        bool speciesId,
        bool speciesAttributeValuesRefs,
        bool careSchedulesRefs,
        bool careRecordsRefs,
        bool individualDetailsRefs,
        bool groupDetailsRefs,
        bool membershipsAsGroup,
        bool membershipsAsIndividual,
        bool animalHabitatAssignmentsRefs,
      })
    >;
typedef $$SpeciesAttributeValuesTableCreateCompanionBuilder =
    SpeciesAttributeValuesCompanion Function({
      required String id,
      required String workspaceId,
      required String animalProfileId,
      required String attributeDefinitionId,
      required String valueJson,
      Value<String?> unitCode,
      Value<DateTime?> observedAt,
      Value<String> valueSource,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$SpeciesAttributeValuesTableUpdateCompanionBuilder =
    SpeciesAttributeValuesCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> animalProfileId,
      Value<String> attributeDefinitionId,
      Value<String> valueJson,
      Value<String?> unitCode,
      Value<DateTime?> observedAt,
      Value<String> valueSource,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$SpeciesAttributeValuesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpeciesAttributeValuesTable,
          SpeciesAttributeValue
        > {
  $$SpeciesAttributeValuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('species_attribute_values__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnimalProfilesTable _animalProfileIdTable(_$AppDatabase db) =>
      db.animalProfiles.createAlias(
        'species_attribute_values__animal_profile_id__animal_profiles__id',
      );

  $$AnimalProfilesTableProcessedTableManager get animalProfileId {
    final $_column = $_itemColumn<String>('animal_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SpeciesAttributeDefinitionsTable _attributeDefinitionIdTable(
    _$AppDatabase db,
  ) => db.speciesAttributeDefinitions.createAlias(
    'species_attribute_values__attribute_definition_id__species_attribute_definitions__id',
  );

  $$SpeciesAttributeDefinitionsTableProcessedTableManager
  get attributeDefinitionId {
    final $_column = $_itemColumn<String>('attribute_definition_id')!;

    final manager = $$SpeciesAttributeDefinitionsTableTableManager(
      $_db,
      $_db.speciesAttributeDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _attributeDefinitionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpeciesAttributeValuesTableFilterComposer
    extends Composer<_$AppDatabase, $SpeciesAttributeValuesTable> {
  $$SpeciesAttributeValuesTableFilterComposer({
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

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitCode => $composableBuilder(
    column: $table.unitCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueSource => $composableBuilder(
    column: $table.valueSource,
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

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableFilterComposer get animalProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesAttributeDefinitionsTableFilterComposer get attributeDefinitionId {
    final $$SpeciesAttributeDefinitionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.attributeDefinitionId,
          referencedTable: $db.speciesAttributeDefinitions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeDefinitionsTableFilterComposer(
                $db: $db,
                $table: $db.speciesAttributeDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SpeciesAttributeValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeciesAttributeValuesTable> {
  $$SpeciesAttributeValuesTableOrderingComposer({
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

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitCode => $composableBuilder(
    column: $table.unitCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueSource => $composableBuilder(
    column: $table.valueSource,
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

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableOrderingComposer get animalProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesAttributeDefinitionsTableOrderingComposer get attributeDefinitionId {
    final $$SpeciesAttributeDefinitionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.attributeDefinitionId,
          referencedTable: $db.speciesAttributeDefinitions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeDefinitionsTableOrderingComposer(
                $db: $db,
                $table: $db.speciesAttributeDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SpeciesAttributeValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeciesAttributeValuesTable> {
  $$SpeciesAttributeValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<String> get unitCode =>
      $composableBuilder(column: $table.unitCode, builder: (column) => column);

  GeneratedColumn<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get valueSource => $composableBuilder(
    column: $table.valueSource,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableAnnotationComposer get animalProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesAttributeDefinitionsTableAnnotationComposer
  get attributeDefinitionId {
    final $$SpeciesAttributeDefinitionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.attributeDefinitionId,
          referencedTable: $db.speciesAttributeDefinitions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeciesAttributeDefinitionsTableAnnotationComposer(
                $db: $db,
                $table: $db.speciesAttributeDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SpeciesAttributeValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeciesAttributeValuesTable,
          SpeciesAttributeValue,
          $$SpeciesAttributeValuesTableFilterComposer,
          $$SpeciesAttributeValuesTableOrderingComposer,
          $$SpeciesAttributeValuesTableAnnotationComposer,
          $$SpeciesAttributeValuesTableCreateCompanionBuilder,
          $$SpeciesAttributeValuesTableUpdateCompanionBuilder,
          (SpeciesAttributeValue, $$SpeciesAttributeValuesTableReferences),
          SpeciesAttributeValue,
          PrefetchHooks Function({
            bool workspaceId,
            bool animalProfileId,
            bool attributeDefinitionId,
          })
        > {
  $$SpeciesAttributeValuesTableTableManager(
    _$AppDatabase db,
    $SpeciesAttributeValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesAttributeValuesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpeciesAttributeValuesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpeciesAttributeValuesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> animalProfileId = const Value.absent(),
                Value<String> attributeDefinitionId = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<String?> unitCode = const Value.absent(),
                Value<DateTime?> observedAt = const Value.absent(),
                Value<String> valueSource = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesAttributeValuesCompanion(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                attributeDefinitionId: attributeDefinitionId,
                valueJson: valueJson,
                unitCode: unitCode,
                observedAt: observedAt,
                valueSource: valueSource,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String animalProfileId,
                required String attributeDefinitionId,
                required String valueJson,
                Value<String?> unitCode = const Value.absent(),
                Value<DateTime?> observedAt = const Value.absent(),
                Value<String> valueSource = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeciesAttributeValuesCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                attributeDefinitionId: attributeDefinitionId,
                valueJson: valueJson,
                unitCode: unitCode,
                observedAt: observedAt,
                valueSource: valueSource,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $SpeciesAttributeValuesTable,
                    SpeciesAttributeValue
                  >(table),
                  $$SpeciesAttributeValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                animalProfileId = false,
                attributeDefinitionId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$SpeciesAttributeValuesTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$SpeciesAttributeValuesTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (animalProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalProfileId,
                                    referencedTable:
                                        $$SpeciesAttributeValuesTableReferences
                                            ._animalProfileIdTable(db),
                                    referencedColumn:
                                        $$SpeciesAttributeValuesTableReferences
                                            ._animalProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (attributeDefinitionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.attributeDefinitionId,
                                    referencedTable:
                                        $$SpeciesAttributeValuesTableReferences
                                            ._attributeDefinitionIdTable(db),
                                    referencedColumn:
                                        $$SpeciesAttributeValuesTableReferences
                                            ._attributeDefinitionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SpeciesAttributeValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeciesAttributeValuesTable,
      SpeciesAttributeValue,
      $$SpeciesAttributeValuesTableFilterComposer,
      $$SpeciesAttributeValuesTableOrderingComposer,
      $$SpeciesAttributeValuesTableAnnotationComposer,
      $$SpeciesAttributeValuesTableCreateCompanionBuilder,
      $$SpeciesAttributeValuesTableUpdateCompanionBuilder,
      (SpeciesAttributeValue, $$SpeciesAttributeValuesTableReferences),
      SpeciesAttributeValue,
      PrefetchHooks Function({
        bool workspaceId,
        bool animalProfileId,
        bool attributeDefinitionId,
      })
    >;
typedef $$CareSchedulesTableCreateCompanionBuilder =
    CareSchedulesCompanion Function({
      required String id,
      required String workspaceId,
      required String animalProfileId,
      required String title,
      required String careType,
      Value<String?> instructions,
      Value<String> recurrenceType,
      Value<int?> intervalDays,
      required DateTime scheduledAt,
      required DateTime nextDueAt,
      Value<bool> isActive,
      Value<DateTime?> lastCompletedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });
typedef $$CareSchedulesTableUpdateCompanionBuilder =
    CareSchedulesCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> animalProfileId,
      Value<String> title,
      Value<String> careType,
      Value<String?> instructions,
      Value<String> recurrenceType,
      Value<int?> intervalDays,
      Value<DateTime> scheduledAt,
      Value<DateTime> nextDueAt,
      Value<bool> isActive,
      Value<DateTime?> lastCompletedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });

final class $$CareSchedulesTableReferences
    extends BaseReferences<_$AppDatabase, $CareSchedulesTable, CareSchedule> {
  $$CareSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) =>
      db.workspaces.createAlias('care_schedules__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnimalProfilesTable _animalProfileIdTable(_$AppDatabase db) => db
      .animalProfiles
      .createAlias('care_schedules__animal_profile_id__animal_profiles__id');

  $$AnimalProfilesTableProcessedTableManager get animalProfileId {
    final $_column = $_itemColumn<String>('animal_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CareRecordsTable, List<CareRecord>>
  _careRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRecords,
    aliasName: 'care_schedules__id__care_records__schedule_id',
  );

  $$CareRecordsTableProcessedTableManager get careRecordsRefs {
    final manager = $$CareRecordsTableTableManager(
      $_db,
      $_db.careRecords,
    ).filter((f) => f.scheduleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CareSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $CareSchedulesTable> {
  $$CareSchedulesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get careType => $composableBuilder(
    column: $table.careType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueAt => $composableBuilder(
    column: $table.nextDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
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

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableFilterComposer get animalProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> careRecordsRefs(
    Expression<bool> Function($$CareRecordsTableFilterComposer f) f,
  ) {
    final $$CareRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRecords,
      getReferencedColumn: (t) => t.scheduleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRecordsTableFilterComposer(
            $db: $db,
            $table: $db.careRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CareSchedulesTable> {
  $$CareSchedulesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get careType => $composableBuilder(
    column: $table.careType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueAt => $composableBuilder(
    column: $table.nextDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
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

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableOrderingComposer get animalProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareSchedulesTable> {
  $$CareSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get careType =>
      $composableBuilder(column: $table.careType, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextDueAt =>
      $composableBuilder(column: $table.nextDueAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableAnnotationComposer get animalProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> careRecordsRefs<T extends Object>(
    Expression<T> Function($$CareRecordsTableAnnotationComposer a) f,
  ) {
    final $$CareRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRecords,
      getReferencedColumn: (t) => t.scheduleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.careRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareSchedulesTable,
          CareSchedule,
          $$CareSchedulesTableFilterComposer,
          $$CareSchedulesTableOrderingComposer,
          $$CareSchedulesTableAnnotationComposer,
          $$CareSchedulesTableCreateCompanionBuilder,
          $$CareSchedulesTableUpdateCompanionBuilder,
          (CareSchedule, $$CareSchedulesTableReferences),
          CareSchedule,
          PrefetchHooks Function({
            bool workspaceId,
            bool animalProfileId,
            bool careRecordsRefs,
          })
        > {
  $$CareSchedulesTableTableManager(_$AppDatabase db, $CareSchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> animalProfileId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> careType = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String> recurrenceType = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<DateTime> nextDueAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareSchedulesCompanion(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                title: title,
                careType: careType,
                instructions: instructions,
                recurrenceType: recurrenceType,
                intervalDays: intervalDays,
                scheduledAt: scheduledAt,
                nextDueAt: nextDueAt,
                isActive: isActive,
                lastCompletedAt: lastCompletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String animalProfileId,
                required String title,
                required String careType,
                Value<String?> instructions = const Value.absent(),
                Value<String> recurrenceType = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                required DateTime scheduledAt,
                required DateTime nextDueAt,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareSchedulesCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                title: title,
                careType: careType,
                instructions: instructions,
                recurrenceType: recurrenceType,
                intervalDays: intervalDays,
                scheduledAt: scheduledAt,
                nextDueAt: nextDueAt,
                isActive: isActive,
                lastCompletedAt: lastCompletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CareSchedulesTable, CareSchedule>(table),
                  $$CareSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                animalProfileId = false,
                careRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (careRecordsRefs) db.careRecords,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$CareSchedulesTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$CareSchedulesTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (animalProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalProfileId,
                                    referencedTable:
                                        $$CareSchedulesTableReferences
                                            ._animalProfileIdTable(db),
                                    referencedColumn:
                                        $$CareSchedulesTableReferences
                                            ._animalProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (careRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          CareSchedule,
                          $CareSchedulesTable,
                          CareRecord,
                          $CareRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CareSchedulesTableReferences
                              ._careRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CareSchedulesTableReferences(
                                db,
                                table,
                                p0,
                              ).careRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'schedule_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CareSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareSchedulesTable,
      CareSchedule,
      $$CareSchedulesTableFilterComposer,
      $$CareSchedulesTableOrderingComposer,
      $$CareSchedulesTableAnnotationComposer,
      $$CareSchedulesTableCreateCompanionBuilder,
      $$CareSchedulesTableUpdateCompanionBuilder,
      (CareSchedule, $$CareSchedulesTableReferences),
      CareSchedule,
      PrefetchHooks Function({
        bool workspaceId,
        bool animalProfileId,
        bool careRecordsRefs,
      })
    >;
typedef $$CareRecordsTableCreateCompanionBuilder =
    CareRecordsCompanion Function({
      required String id,
      required String workspaceId,
      required String animalProfileId,
      Value<String?> scheduleId,
      required String careType,
      required String title,
      required DateTime performedAt,
      Value<DateTime?> scheduledFor,
      Value<double?> quantityValue,
      Value<String?> quantityUnit,
      Value<String?> notes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CareRecordsTableUpdateCompanionBuilder =
    CareRecordsCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> animalProfileId,
      Value<String?> scheduleId,
      Value<String> careType,
      Value<String> title,
      Value<DateTime> performedAt,
      Value<DateTime?> scheduledFor,
      Value<double?> quantityValue,
      Value<String?> quantityUnit,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CareRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $CareRecordsTable, CareRecord> {
  $$CareRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) =>
      db.workspaces.createAlias('care_records__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnimalProfilesTable _animalProfileIdTable(_$AppDatabase db) => db
      .animalProfiles
      .createAlias('care_records__animal_profile_id__animal_profiles__id');

  $$AnimalProfilesTableProcessedTableManager get animalProfileId {
    final $_column = $_itemColumn<String>('animal_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CareSchedulesTable _scheduleIdTable(_$AppDatabase db) => db
      .careSchedules
      .createAlias('care_records__schedule_id__care_schedules__id');

  $$CareSchedulesTableProcessedTableManager? get scheduleId {
    final $_column = $_itemColumn<String>('schedule_id');
    if ($_column == null) return null;
    final manager = $$CareSchedulesTableTableManager(
      $_db,
      $_db.careSchedules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CareRecordsTable> {
  $$CareRecordsTableFilterComposer({
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

  ColumnFilters<String> get careType => $composableBuilder(
    column: $table.careType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get performedAt => $composableBuilder(
    column: $table.performedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityValue => $composableBuilder(
    column: $table.quantityValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableFilterComposer get animalProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CareSchedulesTableFilterComposer get scheduleId {
    final $$CareSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CareRecordsTable> {
  $$CareRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get careType => $composableBuilder(
    column: $table.careType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get performedAt => $composableBuilder(
    column: $table.performedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityValue => $composableBuilder(
    column: $table.quantityValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableOrderingComposer get animalProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CareSchedulesTableOrderingComposer get scheduleId {
    final $$CareSchedulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableOrderingComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareRecordsTable> {
  $$CareRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get careType =>
      $composableBuilder(column: $table.careType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get performedAt => $composableBuilder(
    column: $table.performedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantityValue => $composableBuilder(
    column: $table.quantityValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableAnnotationComposer get animalProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CareSchedulesTableAnnotationComposer get scheduleId {
    final $$CareSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.careSchedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.careSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareRecordsTable,
          CareRecord,
          $$CareRecordsTableFilterComposer,
          $$CareRecordsTableOrderingComposer,
          $$CareRecordsTableAnnotationComposer,
          $$CareRecordsTableCreateCompanionBuilder,
          $$CareRecordsTableUpdateCompanionBuilder,
          (CareRecord, $$CareRecordsTableReferences),
          CareRecord,
          PrefetchHooks Function({
            bool workspaceId,
            bool animalProfileId,
            bool scheduleId,
          })
        > {
  $$CareRecordsTableTableManager(_$AppDatabase db, $CareRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> animalProfileId = const Value.absent(),
                Value<String?> scheduleId = const Value.absent(),
                Value<String> careType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> performedAt = const Value.absent(),
                Value<DateTime?> scheduledFor = const Value.absent(),
                Value<double?> quantityValue = const Value.absent(),
                Value<String?> quantityUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareRecordsCompanion(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                scheduleId: scheduleId,
                careType: careType,
                title: title,
                performedAt: performedAt,
                scheduledFor: scheduledFor,
                quantityValue: quantityValue,
                quantityUnit: quantityUnit,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String animalProfileId,
                Value<String?> scheduleId = const Value.absent(),
                required String careType,
                required String title,
                required DateTime performedAt,
                Value<DateTime?> scheduledFor = const Value.absent(),
                Value<double?> quantityValue = const Value.absent(),
                Value<String?> quantityUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CareRecordsCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                scheduleId: scheduleId,
                careType: careType,
                title: title,
                performedAt: performedAt,
                scheduledFor: scheduledFor,
                quantityValue: quantityValue,
                quantityUnit: quantityUnit,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CareRecordsTable, CareRecord>(table),
                  $$CareRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                animalProfileId = false,
                scheduleId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$CareRecordsTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$CareRecordsTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (animalProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalProfileId,
                                    referencedTable:
                                        $$CareRecordsTableReferences
                                            ._animalProfileIdTable(db),
                                    referencedColumn:
                                        $$CareRecordsTableReferences
                                            ._animalProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (scheduleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.scheduleId,
                                    referencedTable:
                                        $$CareRecordsTableReferences
                                            ._scheduleIdTable(db),
                                    referencedColumn:
                                        $$CareRecordsTableReferences
                                            ._scheduleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CareRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareRecordsTable,
      CareRecord,
      $$CareRecordsTableFilterComposer,
      $$CareRecordsTableOrderingComposer,
      $$CareRecordsTableAnnotationComposer,
      $$CareRecordsTableCreateCompanionBuilder,
      $$CareRecordsTableUpdateCompanionBuilder,
      (CareRecord, $$CareRecordsTableReferences),
      CareRecord,
      PrefetchHooks Function({
        bool workspaceId,
        bool animalProfileId,
        bool scheduleId,
      })
    >;
typedef $$IndividualDetailsTableCreateCompanionBuilder =
    IndividualDetailsCompanion Function({
      required String animalProfileId,
      Value<String?> sexCode,
      Value<DateTime?> birthDate,
      Value<String?> birthDatePrecision,
      Value<DateTime?> acquiredAt,
      Value<String?> lifeStageCode,
      Value<String?> lifeStageSource,
      Value<int> rowid,
    });
typedef $$IndividualDetailsTableUpdateCompanionBuilder =
    IndividualDetailsCompanion Function({
      Value<String> animalProfileId,
      Value<String?> sexCode,
      Value<DateTime?> birthDate,
      Value<String?> birthDatePrecision,
      Value<DateTime?> acquiredAt,
      Value<String?> lifeStageCode,
      Value<String?> lifeStageSource,
      Value<int> rowid,
    });

final class $$IndividualDetailsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $IndividualDetailsTable,
          IndividualDetail
        > {
  $$IndividualDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalProfilesTable _animalProfileIdTable(_$AppDatabase db) =>
      db.animalProfiles.createAlias(
        'individual_details__animal_profile_id__animal_profiles__id',
      );

  $$AnimalProfilesTableProcessedTableManager get animalProfileId {
    final $_column = $_itemColumn<String>('animal_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IndividualDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $IndividualDetailsTable> {
  $$IndividualDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sexCode => $composableBuilder(
    column: $table.sexCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthDatePrecision => $composableBuilder(
    column: $table.birthDatePrecision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lifeStageCode => $composableBuilder(
    column: $table.lifeStageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lifeStageSource => $composableBuilder(
    column: $table.lifeStageSource,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalProfilesTableFilterComposer get animalProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndividualDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $IndividualDetailsTable> {
  $$IndividualDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sexCode => $composableBuilder(
    column: $table.sexCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDatePrecision => $composableBuilder(
    column: $table.birthDatePrecision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lifeStageCode => $composableBuilder(
    column: $table.lifeStageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lifeStageSource => $composableBuilder(
    column: $table.lifeStageSource,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalProfilesTableOrderingComposer get animalProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndividualDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IndividualDetailsTable> {
  $$IndividualDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sexCode =>
      $composableBuilder(column: $table.sexCode, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get birthDatePrecision => $composableBuilder(
    column: $table.birthDatePrecision,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lifeStageCode => $composableBuilder(
    column: $table.lifeStageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lifeStageSource => $composableBuilder(
    column: $table.lifeStageSource,
    builder: (column) => column,
  );

  $$AnimalProfilesTableAnnotationComposer get animalProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndividualDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IndividualDetailsTable,
          IndividualDetail,
          $$IndividualDetailsTableFilterComposer,
          $$IndividualDetailsTableOrderingComposer,
          $$IndividualDetailsTableAnnotationComposer,
          $$IndividualDetailsTableCreateCompanionBuilder,
          $$IndividualDetailsTableUpdateCompanionBuilder,
          (IndividualDetail, $$IndividualDetailsTableReferences),
          IndividualDetail,
          PrefetchHooks Function({bool animalProfileId})
        > {
  $$IndividualDetailsTableTableManager(
    _$AppDatabase db,
    $IndividualDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IndividualDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IndividualDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IndividualDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> animalProfileId = const Value.absent(),
                Value<String?> sexCode = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> birthDatePrecision = const Value.absent(),
                Value<DateTime?> acquiredAt = const Value.absent(),
                Value<String?> lifeStageCode = const Value.absent(),
                Value<String?> lifeStageSource = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IndividualDetailsCompanion(
                animalProfileId: animalProfileId,
                sexCode: sexCode,
                birthDate: birthDate,
                birthDatePrecision: birthDatePrecision,
                acquiredAt: acquiredAt,
                lifeStageCode: lifeStageCode,
                lifeStageSource: lifeStageSource,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String animalProfileId,
                Value<String?> sexCode = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> birthDatePrecision = const Value.absent(),
                Value<DateTime?> acquiredAt = const Value.absent(),
                Value<String?> lifeStageCode = const Value.absent(),
                Value<String?> lifeStageSource = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IndividualDetailsCompanion.insert(
                animalProfileId: animalProfileId,
                sexCode: sexCode,
                birthDate: birthDate,
                birthDatePrecision: birthDatePrecision,
                acquiredAt: acquiredAt,
                lifeStageCode: lifeStageCode,
                lifeStageSource: lifeStageSource,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IndividualDetailsTable, IndividualDetail>(table),
                  $$IndividualDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalProfileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalProfileId,
                                referencedTable:
                                    $$IndividualDetailsTableReferences
                                        ._animalProfileIdTable(db),
                                referencedColumn:
                                    $$IndividualDetailsTableReferences
                                        ._animalProfileIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IndividualDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IndividualDetailsTable,
      IndividualDetail,
      $$IndividualDetailsTableFilterComposer,
      $$IndividualDetailsTableOrderingComposer,
      $$IndividualDetailsTableAnnotationComposer,
      $$IndividualDetailsTableCreateCompanionBuilder,
      $$IndividualDetailsTableUpdateCompanionBuilder,
      (IndividualDetail, $$IndividualDetailsTableReferences),
      IndividualDetail,
      PrefetchHooks Function({bool animalProfileId})
    >;
typedef $$GroupDetailsTableCreateCompanionBuilder =
    GroupDetailsCompanion Function({
      required String animalProfileId,
      Value<String?> groupPurpose,
      required String memberTrackingMode,
      Value<int?> reportedCount,
      Value<DateTime?> countObservedAt,
      Value<String?> countNote,
      Value<int> rowid,
    });
typedef $$GroupDetailsTableUpdateCompanionBuilder =
    GroupDetailsCompanion Function({
      Value<String> animalProfileId,
      Value<String?> groupPurpose,
      Value<String> memberTrackingMode,
      Value<int?> reportedCount,
      Value<DateTime?> countObservedAt,
      Value<String?> countNote,
      Value<int> rowid,
    });

final class $$GroupDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $GroupDetailsTable, GroupDetail> {
  $$GroupDetailsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AnimalProfilesTable _animalProfileIdTable(_$AppDatabase db) => db
      .animalProfiles
      .createAlias('group_details__animal_profile_id__animal_profiles__id');

  $$AnimalProfilesTableProcessedTableManager get animalProfileId {
    final $_column = $_itemColumn<String>('animal_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupDetailsTable> {
  $$GroupDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get groupPurpose => $composableBuilder(
    column: $table.groupPurpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberTrackingMode => $composableBuilder(
    column: $table.memberTrackingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reportedCount => $composableBuilder(
    column: $table.reportedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get countObservedAt => $composableBuilder(
    column: $table.countObservedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countNote => $composableBuilder(
    column: $table.countNote,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalProfilesTableFilterComposer get animalProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupDetailsTable> {
  $$GroupDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get groupPurpose => $composableBuilder(
    column: $table.groupPurpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberTrackingMode => $composableBuilder(
    column: $table.memberTrackingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reportedCount => $composableBuilder(
    column: $table.reportedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get countObservedAt => $composableBuilder(
    column: $table.countObservedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countNote => $composableBuilder(
    column: $table.countNote,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalProfilesTableOrderingComposer get animalProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupDetailsTable> {
  $$GroupDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get groupPurpose => $composableBuilder(
    column: $table.groupPurpose,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberTrackingMode => $composableBuilder(
    column: $table.memberTrackingMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reportedCount => $composableBuilder(
    column: $table.reportedCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get countObservedAt => $composableBuilder(
    column: $table.countObservedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countNote =>
      $composableBuilder(column: $table.countNote, builder: (column) => column);

  $$AnimalProfilesTableAnnotationComposer get animalProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupDetailsTable,
          GroupDetail,
          $$GroupDetailsTableFilterComposer,
          $$GroupDetailsTableOrderingComposer,
          $$GroupDetailsTableAnnotationComposer,
          $$GroupDetailsTableCreateCompanionBuilder,
          $$GroupDetailsTableUpdateCompanionBuilder,
          (GroupDetail, $$GroupDetailsTableReferences),
          GroupDetail,
          PrefetchHooks Function({bool animalProfileId})
        > {
  $$GroupDetailsTableTableManager(_$AppDatabase db, $GroupDetailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> animalProfileId = const Value.absent(),
                Value<String?> groupPurpose = const Value.absent(),
                Value<String> memberTrackingMode = const Value.absent(),
                Value<int?> reportedCount = const Value.absent(),
                Value<DateTime?> countObservedAt = const Value.absent(),
                Value<String?> countNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupDetailsCompanion(
                animalProfileId: animalProfileId,
                groupPurpose: groupPurpose,
                memberTrackingMode: memberTrackingMode,
                reportedCount: reportedCount,
                countObservedAt: countObservedAt,
                countNote: countNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String animalProfileId,
                Value<String?> groupPurpose = const Value.absent(),
                required String memberTrackingMode,
                Value<int?> reportedCount = const Value.absent(),
                Value<DateTime?> countObservedAt = const Value.absent(),
                Value<String?> countNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupDetailsCompanion.insert(
                animalProfileId: animalProfileId,
                groupPurpose: groupPurpose,
                memberTrackingMode: memberTrackingMode,
                reportedCount: reportedCount,
                countObservedAt: countObservedAt,
                countNote: countNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GroupDetailsTable, GroupDetail>(table),
                  $$GroupDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalProfileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalProfileId,
                                referencedTable: $$GroupDetailsTableReferences
                                    ._animalProfileIdTable(db),
                                referencedColumn: $$GroupDetailsTableReferences
                                    ._animalProfileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GroupDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupDetailsTable,
      GroupDetail,
      $$GroupDetailsTableFilterComposer,
      $$GroupDetailsTableOrderingComposer,
      $$GroupDetailsTableAnnotationComposer,
      $$GroupDetailsTableCreateCompanionBuilder,
      $$GroupDetailsTableUpdateCompanionBuilder,
      (GroupDetail, $$GroupDetailsTableReferences),
      GroupDetail,
      PrefetchHooks Function({bool animalProfileId})
    >;
typedef $$GroupMembershipsTableCreateCompanionBuilder =
    GroupMembershipsCompanion Function({
      required String id,
      required String workspaceId,
      required String groupProfileId,
      required String individualProfileId,
      required DateTime validFrom,
      Value<DateTime?> validTo,
      Value<String?> membershipNote,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$GroupMembershipsTableUpdateCompanionBuilder =
    GroupMembershipsCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> groupProfileId,
      Value<String> individualProfileId,
      Value<DateTime> validFrom,
      Value<DateTime?> validTo,
      Value<String?> membershipNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$GroupMembershipsTableReferences
    extends
        BaseReferences<_$AppDatabase, $GroupMembershipsTable, GroupMembership> {
  $$GroupMembershipsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('group_memberships__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnimalProfilesTable _groupProfileIdTable(_$AppDatabase db) => db
      .animalProfiles
      .createAlias('group_memberships__group_profile_id__animal_profiles__id');

  $$AnimalProfilesTableProcessedTableManager get groupProfileId {
    final $_column = $_itemColumn<String>('group_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnimalProfilesTable _individualProfileIdTable(_$AppDatabase db) =>
      db.animalProfiles.createAlias(
        'group_memberships__individual_profile_id__animal_profiles__id',
      );

  $$AnimalProfilesTableProcessedTableManager get individualProfileId {
    final $_column = $_itemColumn<String>('individual_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_individualProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupMembershipsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupMembershipsTable> {
  $$GroupMembershipsTableFilterComposer({
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

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get membershipNote => $composableBuilder(
    column: $table.membershipNote,
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

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableFilterComposer get groupProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableFilterComposer get individualProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.individualProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupMembershipsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupMembershipsTable> {
  $$GroupMembershipsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get membershipNote => $composableBuilder(
    column: $table.membershipNote,
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

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableOrderingComposer get groupProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableOrderingComposer get individualProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.individualProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupMembershipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupMembershipsTable> {
  $$GroupMembershipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  GeneratedColumn<String> get membershipNote => $composableBuilder(
    column: $table.membershipNote,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableAnnotationComposer get groupProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableAnnotationComposer get individualProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.individualProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupMembershipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupMembershipsTable,
          GroupMembership,
          $$GroupMembershipsTableFilterComposer,
          $$GroupMembershipsTableOrderingComposer,
          $$GroupMembershipsTableAnnotationComposer,
          $$GroupMembershipsTableCreateCompanionBuilder,
          $$GroupMembershipsTableUpdateCompanionBuilder,
          (GroupMembership, $$GroupMembershipsTableReferences),
          GroupMembership,
          PrefetchHooks Function({
            bool workspaceId,
            bool groupProfileId,
            bool individualProfileId,
          })
        > {
  $$GroupMembershipsTableTableManager(
    _$AppDatabase db,
    $GroupMembershipsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupMembershipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupMembershipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupMembershipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> groupProfileId = const Value.absent(),
                Value<String> individualProfileId = const Value.absent(),
                Value<DateTime> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<String?> membershipNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupMembershipsCompanion(
                id: id,
                workspaceId: workspaceId,
                groupProfileId: groupProfileId,
                individualProfileId: individualProfileId,
                validFrom: validFrom,
                validTo: validTo,
                membershipNote: membershipNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String groupProfileId,
                required String individualProfileId,
                required DateTime validFrom,
                Value<DateTime?> validTo = const Value.absent(),
                Value<String?> membershipNote = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GroupMembershipsCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                groupProfileId: groupProfileId,
                individualProfileId: individualProfileId,
                validFrom: validFrom,
                validTo: validTo,
                membershipNote: membershipNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GroupMembershipsTable, GroupMembership>(table),
                  $$GroupMembershipsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                groupProfileId = false,
                individualProfileId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$GroupMembershipsTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$GroupMembershipsTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (groupProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupProfileId,
                                    referencedTable:
                                        $$GroupMembershipsTableReferences
                                            ._groupProfileIdTable(db),
                                    referencedColumn:
                                        $$GroupMembershipsTableReferences
                                            ._groupProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (individualProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.individualProfileId,
                                    referencedTable:
                                        $$GroupMembershipsTableReferences
                                            ._individualProfileIdTable(db),
                                    referencedColumn:
                                        $$GroupMembershipsTableReferences
                                            ._individualProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$GroupMembershipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupMembershipsTable,
      GroupMembership,
      $$GroupMembershipsTableFilterComposer,
      $$GroupMembershipsTableOrderingComposer,
      $$GroupMembershipsTableAnnotationComposer,
      $$GroupMembershipsTableCreateCompanionBuilder,
      $$GroupMembershipsTableUpdateCompanionBuilder,
      (GroupMembership, $$GroupMembershipsTableReferences),
      GroupMembership,
      PrefetchHooks Function({
        bool workspaceId,
        bool groupProfileId,
        bool individualProfileId,
      })
    >;
typedef $$HabitatsTableCreateCompanionBuilder =
    HabitatsCompanion Function({
      required String id,
      required String workspaceId,
      Value<String?> parentHabitatId,
      required String name,
      required String habitatType,
      Value<String> status,
      Value<String?> description,
      Value<double?> capacityValue,
      Value<String?> capacityUnit,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$HabitatsTableUpdateCompanionBuilder =
    HabitatsCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String?> parentHabitatId,
      Value<String> name,
      Value<String> habitatType,
      Value<String> status,
      Value<String?> description,
      Value<double?> capacityValue,
      Value<String?> capacityUnit,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$HabitatsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitatsTable, Habitat> {
  $$HabitatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) =>
      db.workspaces.createAlias('habitats__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HabitatsTable _parentHabitatIdTable(_$AppDatabase db) =>
      db.habitats.createAlias('habitats__parent_habitat_id__habitats__id');

  $$HabitatsTableProcessedTableManager? get parentHabitatId {
    final $_column = $_itemColumn<String>('parent_habitat_id');
    if ($_column == null) return null;
    final manager = $$HabitatsTableTableManager(
      $_db,
      $_db.habitats,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentHabitatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $AnimalHabitatAssignmentsTable,
    List<AnimalHabitatAssignment>
  >
  _animalHabitatAssignmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.animalHabitatAssignments,
        aliasName: 'habitats__id__animal_habitat_assignments__habitat_id',
      );

  $$AnimalHabitatAssignmentsTableProcessedTableManager
  get animalHabitatAssignmentsRefs {
    final manager = $$AnimalHabitatAssignmentsTableTableManager(
      $_db,
      $_db.animalHabitatAssignments,
    ).filter((f) => f.habitatId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _animalHabitatAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitatsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitatsTable> {
  $$HabitatsTableFilterComposer({
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

  ColumnFilters<String> get habitatType => $composableBuilder(
    column: $table.habitatType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get capacityValue => $composableBuilder(
    column: $table.capacityValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get capacityUnit => $composableBuilder(
    column: $table.capacityUnit,
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

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HabitatsTableFilterComposer get parentHabitatId {
    final $$HabitatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentHabitatId,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableFilterComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> animalHabitatAssignmentsRefs(
    Expression<bool> Function($$AnimalHabitatAssignmentsTableFilterComposer f)
    f,
  ) {
    final $$AnimalHabitatAssignmentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.animalHabitatAssignments,
          getReferencedColumn: (t) => t.habitatId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnimalHabitatAssignmentsTableFilterComposer(
                $db: $db,
                $table: $db.animalHabitatAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HabitatsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitatsTable> {
  $$HabitatsTableOrderingComposer({
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

  ColumnOrderings<String> get habitatType => $composableBuilder(
    column: $table.habitatType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get capacityValue => $composableBuilder(
    column: $table.capacityValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get capacityUnit => $composableBuilder(
    column: $table.capacityUnit,
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

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HabitatsTableOrderingComposer get parentHabitatId {
    final $$HabitatsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentHabitatId,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableOrderingComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitatsTable> {
  $$HabitatsTableAnnotationComposer({
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

  GeneratedColumn<String> get habitatType => $composableBuilder(
    column: $table.habitatType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get capacityValue => $composableBuilder(
    column: $table.capacityValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get capacityUnit => $composableBuilder(
    column: $table.capacityUnit,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HabitatsTableAnnotationComposer get parentHabitatId {
    final $$HabitatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentHabitatId,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> animalHabitatAssignmentsRefs<T extends Object>(
    Expression<T> Function($$AnimalHabitatAssignmentsTableAnnotationComposer a)
    f,
  ) {
    final $$AnimalHabitatAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.animalHabitatAssignments,
          getReferencedColumn: (t) => t.habitatId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnimalHabitatAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.animalHabitatAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HabitatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitatsTable,
          Habitat,
          $$HabitatsTableFilterComposer,
          $$HabitatsTableOrderingComposer,
          $$HabitatsTableAnnotationComposer,
          $$HabitatsTableCreateCompanionBuilder,
          $$HabitatsTableUpdateCompanionBuilder,
          (Habitat, $$HabitatsTableReferences),
          Habitat,
          PrefetchHooks Function({
            bool workspaceId,
            bool parentHabitatId,
            bool animalHabitatAssignmentsRefs,
          })
        > {
  $$HabitatsTableTableManager(_$AppDatabase db, $HabitatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String?> parentHabitatId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> habitatType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> capacityValue = const Value.absent(),
                Value<String?> capacityUnit = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitatsCompanion(
                id: id,
                workspaceId: workspaceId,
                parentHabitatId: parentHabitatId,
                name: name,
                habitatType: habitatType,
                status: status,
                description: description,
                capacityValue: capacityValue,
                capacityUnit: capacityUnit,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                Value<String?> parentHabitatId = const Value.absent(),
                required String name,
                required String habitatType,
                Value<String> status = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> capacityValue = const Value.absent(),
                Value<String?> capacityUnit = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitatsCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                parentHabitatId: parentHabitatId,
                name: name,
                habitatType: habitatType,
                status: status,
                description: description,
                capacityValue: capacityValue,
                capacityUnit: capacityUnit,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitatsTable, Habitat>(table),
                  $$HabitatsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                parentHabitatId = false,
                animalHabitatAssignmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (animalHabitatAssignmentsRefs)
                      db.animalHabitatAssignments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable: $$HabitatsTableReferences
                                        ._workspaceIdTable(db),
                                    referencedColumn: $$HabitatsTableReferences
                                        ._workspaceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (parentHabitatId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentHabitatId,
                                    referencedTable: $$HabitatsTableReferences
                                        ._parentHabitatIdTable(db),
                                    referencedColumn: $$HabitatsTableReferences
                                        ._parentHabitatIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (animalHabitatAssignmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Habitat,
                          $HabitatsTable,
                          AnimalHabitatAssignment,
                          $AnimalHabitatAssignmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HabitatsTableReferences
                              ._animalHabitatAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitatsTableReferences(
                                db,
                                table,
                                p0,
                              ).animalHabitatAssignmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'habitat_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HabitatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitatsTable,
      Habitat,
      $$HabitatsTableFilterComposer,
      $$HabitatsTableOrderingComposer,
      $$HabitatsTableAnnotationComposer,
      $$HabitatsTableCreateCompanionBuilder,
      $$HabitatsTableUpdateCompanionBuilder,
      (Habitat, $$HabitatsTableReferences),
      Habitat,
      PrefetchHooks Function({
        bool workspaceId,
        bool parentHabitatId,
        bool animalHabitatAssignmentsRefs,
      })
    >;
typedef $$AnimalHabitatAssignmentsTableCreateCompanionBuilder =
    AnimalHabitatAssignmentsCompanion Function({
      required String id,
      required String workspaceId,
      required String animalProfileId,
      required String habitatId,
      Value<String> assignmentRole,
      required DateTime validFrom,
      Value<DateTime?> validTo,
      Value<String?> note,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$AnimalHabitatAssignmentsTableUpdateCompanionBuilder =
    AnimalHabitatAssignmentsCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> animalProfileId,
      Value<String> habitatId,
      Value<String> assignmentRole,
      Value<DateTime> validFrom,
      Value<DateTime?> validTo,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$AnimalHabitatAssignmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AnimalHabitatAssignmentsTable,
          AnimalHabitatAssignment
        > {
  $$AnimalHabitatAssignmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('animal_habitat_assignments__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AnimalProfilesTable _animalProfileIdTable(_$AppDatabase db) =>
      db.animalProfiles.createAlias(
        'animal_habitat_assignments__animal_profile_id__animal_profiles__id',
      );

  $$AnimalProfilesTableProcessedTableManager get animalProfileId {
    final $_column = $_itemColumn<String>('animal_profile_id')!;

    final manager = $$AnimalProfilesTableTableManager(
      $_db,
      $_db.animalProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HabitatsTable _habitatIdTable(_$AppDatabase db) => db.habitats
      .createAlias('animal_habitat_assignments__habitat_id__habitats__id');

  $$HabitatsTableProcessedTableManager get habitatId {
    final $_column = $_itemColumn<String>('habitat_id')!;

    final manager = $$HabitatsTableTableManager(
      $_db,
      $_db.habitats,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnimalHabitatAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalHabitatAssignmentsTable> {
  $$AnimalHabitatAssignmentsTableFilterComposer({
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

  ColumnFilters<String> get assignmentRole => $composableBuilder(
    column: $table.assignmentRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableFilterComposer get animalProfileId {
    final $$AnimalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HabitatsTableFilterComposer get habitatId {
    final $$HabitatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitatId,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableFilterComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimalHabitatAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalHabitatAssignmentsTable> {
  $$AnimalHabitatAssignmentsTableOrderingComposer({
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

  ColumnOrderings<String> get assignmentRole => $composableBuilder(
    column: $table.assignmentRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableOrderingComposer get animalProfileId {
    final $$AnimalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HabitatsTableOrderingComposer get habitatId {
    final $$HabitatsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitatId,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableOrderingComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimalHabitatAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalHabitatAssignmentsTable> {
  $$AnimalHabitatAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assignmentRole => $composableBuilder(
    column: $table.assignmentRole,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AnimalProfilesTableAnnotationComposer get animalProfileId {
    final $$AnimalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalProfileId,
      referencedTable: $db.animalProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.animalProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HabitatsTableAnnotationComposer get habitatId {
    final $$HabitatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitatId,
      referencedTable: $db.habitats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitatsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimalHabitatAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimalHabitatAssignmentsTable,
          AnimalHabitatAssignment,
          $$AnimalHabitatAssignmentsTableFilterComposer,
          $$AnimalHabitatAssignmentsTableOrderingComposer,
          $$AnimalHabitatAssignmentsTableAnnotationComposer,
          $$AnimalHabitatAssignmentsTableCreateCompanionBuilder,
          $$AnimalHabitatAssignmentsTableUpdateCompanionBuilder,
          (AnimalHabitatAssignment, $$AnimalHabitatAssignmentsTableReferences),
          AnimalHabitatAssignment,
          PrefetchHooks Function({
            bool workspaceId,
            bool animalProfileId,
            bool habitatId,
          })
        > {
  $$AnimalHabitatAssignmentsTableTableManager(
    _$AppDatabase db,
    $AnimalHabitatAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalHabitatAssignmentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AnimalHabitatAssignmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AnimalHabitatAssignmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> animalProfileId = const Value.absent(),
                Value<String> habitatId = const Value.absent(),
                Value<String> assignmentRole = const Value.absent(),
                Value<DateTime> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalHabitatAssignmentsCompanion(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                habitatId: habitatId,
                assignmentRole: assignmentRole,
                validFrom: validFrom,
                validTo: validTo,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String animalProfileId,
                required String habitatId,
                Value<String> assignmentRole = const Value.absent(),
                required DateTime validFrom,
                Value<DateTime?> validTo = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AnimalHabitatAssignmentsCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                animalProfileId: animalProfileId,
                habitatId: habitatId,
                assignmentRole: assignmentRole,
                validFrom: validFrom,
                validTo: validTo,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $AnimalHabitatAssignmentsTable,
                    AnimalHabitatAssignment
                  >(table),
                  $$AnimalHabitatAssignmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                animalProfileId = false,
                habitatId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$AnimalHabitatAssignmentsTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$AnimalHabitatAssignmentsTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (animalProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalProfileId,
                                    referencedTable:
                                        $$AnimalHabitatAssignmentsTableReferences
                                            ._animalProfileIdTable(db),
                                    referencedColumn:
                                        $$AnimalHabitatAssignmentsTableReferences
                                            ._animalProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (habitatId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.habitatId,
                                    referencedTable:
                                        $$AnimalHabitatAssignmentsTableReferences
                                            ._habitatIdTable(db),
                                    referencedColumn:
                                        $$AnimalHabitatAssignmentsTableReferences
                                            ._habitatIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$AnimalHabitatAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimalHabitatAssignmentsTable,
      AnimalHabitatAssignment,
      $$AnimalHabitatAssignmentsTableFilterComposer,
      $$AnimalHabitatAssignmentsTableOrderingComposer,
      $$AnimalHabitatAssignmentsTableAnnotationComposer,
      $$AnimalHabitatAssignmentsTableCreateCompanionBuilder,
      $$AnimalHabitatAssignmentsTableUpdateCompanionBuilder,
      (AnimalHabitatAssignment, $$AnimalHabitatAssignmentsTableReferences),
      AnimalHabitatAssignment,
      PrefetchHooks Function({
        bool workspaceId,
        bool animalProfileId,
        bool habitatId,
      })
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      required String operationId,
      required String workspaceId,
      required String entityKind,
      required String entityId,
      required String operationKind,
      Value<int?> baseServerVersion,
      Value<int> payloadVersion,
      required String payloadJson,
      required DateTime createdAt,
      Value<int> attemptCount,
      Value<DateTime?> nextAttemptAt,
      Value<String> status,
      Value<String?> lastErrorCode,
      Value<int> rowid,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<String> operationId,
      Value<String> workspaceId,
      Value<String> entityKind,
      Value<String> entityId,
      Value<String> operationKind,
      Value<int?> baseServerVersion,
      Value<int> payloadVersion,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
      Value<int> attemptCount,
      Value<DateTime?> nextAttemptAt,
      Value<String> status,
      Value<String?> lastErrorCode,
      Value<int> rowid,
    });

final class $$SyncOutboxTableReferences
    extends BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxData> {
  $$SyncOutboxTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) =>
      db.workspaces.createAlias('sync_outbox__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityKind => $composableBuilder(
    column: $table.entityKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationKind => $composableBuilder(
    column: $table.operationKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseServerVersion => $composableBuilder(
    column: $table.baseServerVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityKind => $composableBuilder(
    column: $table.entityKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationKind => $composableBuilder(
    column: $table.operationKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseServerVersion => $composableBuilder(
    column: $table.baseServerVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityKind => $composableBuilder(
    column: $table.entityKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operationKind => $composableBuilder(
    column: $table.operationKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baseServerVersion => $composableBuilder(
    column: $table.baseServerVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => column,
  );

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOutboxData,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (SyncOutboxData, $$SyncOutboxTableReferences),
          SyncOutboxData,
          PrefetchHooks Function({bool workspaceId})
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> operationId = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> entityKind = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operationKind = const Value.absent(),
                Value<int?> baseServerVersion = const Value.absent(),
                Value<int> payloadVersion = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion(
                operationId: operationId,
                workspaceId: workspaceId,
                entityKind: entityKind,
                entityId: entityId,
                operationKind: operationKind,
                baseServerVersion: baseServerVersion,
                payloadVersion: payloadVersion,
                payloadJson: payloadJson,
                createdAt: createdAt,
                attemptCount: attemptCount,
                nextAttemptAt: nextAttemptAt,
                status: status,
                lastErrorCode: lastErrorCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String operationId,
                required String workspaceId,
                required String entityKind,
                required String entityId,
                required String operationKind,
                Value<int?> baseServerVersion = const Value.absent(),
                Value<int> payloadVersion = const Value.absent(),
                required String payloadJson,
                required DateTime createdAt,
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                operationId: operationId,
                workspaceId: workspaceId,
                entityKind: entityKind,
                entityId: entityId,
                operationKind: operationKind,
                baseServerVersion: baseServerVersion,
                payloadVersion: payloadVersion,
                payloadJson: payloadJson,
                createdAt: createdAt,
                attemptCount: attemptCount,
                nextAttemptAt: nextAttemptAt,
                status: status,
                lastErrorCode: lastErrorCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncOutboxTable, SyncOutboxData>(table),
                  $$SyncOutboxTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workspaceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (workspaceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workspaceId,
                                referencedTable: $$SyncOutboxTableReferences
                                    ._workspaceIdTable(db),
                                referencedColumn: $$SyncOutboxTableReferences
                                    ._workspaceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOutboxData,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (SyncOutboxData, $$SyncOutboxTableReferences),
      SyncOutboxData,
      PrefetchHooks Function({bool workspaceId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$WorkspacesTableTableManager get workspaces =>
      $$WorkspacesTableTableManager(_db, _db.workspaces);
  $$WorkspaceMembershipsTableTableManager get workspaceMemberships =>
      $$WorkspaceMembershipsTableTableManager(_db, _db.workspaceMemberships);
  $$SpeciesTableTableManager get species =>
      $$SpeciesTableTableManager(_db, _db.species);
  $$SpeciesSourcesTableTableManager get speciesSources =>
      $$SpeciesSourcesTableTableManager(_db, _db.speciesSources);
  $$SpeciesAttributeDefinitionsTableTableManager
  get speciesAttributeDefinitions =>
      $$SpeciesAttributeDefinitionsTableTableManager(
        _db,
        _db.speciesAttributeDefinitions,
      );
  $$AnimalProfilesTableTableManager get animalProfiles =>
      $$AnimalProfilesTableTableManager(_db, _db.animalProfiles);
  $$SpeciesAttributeValuesTableTableManager get speciesAttributeValues =>
      $$SpeciesAttributeValuesTableTableManager(
        _db,
        _db.speciesAttributeValues,
      );
  $$CareSchedulesTableTableManager get careSchedules =>
      $$CareSchedulesTableTableManager(_db, _db.careSchedules);
  $$CareRecordsTableTableManager get careRecords =>
      $$CareRecordsTableTableManager(_db, _db.careRecords);
  $$IndividualDetailsTableTableManager get individualDetails =>
      $$IndividualDetailsTableTableManager(_db, _db.individualDetails);
  $$GroupDetailsTableTableManager get groupDetails =>
      $$GroupDetailsTableTableManager(_db, _db.groupDetails);
  $$GroupMembershipsTableTableManager get groupMemberships =>
      $$GroupMembershipsTableTableManager(_db, _db.groupMemberships);
  $$HabitatsTableTableManager get habitats =>
      $$HabitatsTableTableManager(_db, _db.habitats);
  $$AnimalHabitatAssignmentsTableTableManager get animalHabitatAssignments =>
      $$AnimalHabitatAssignmentsTableTableManager(
        _db,
        _db.animalHabitatAssignments,
      );
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
}
