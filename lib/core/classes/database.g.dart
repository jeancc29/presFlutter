// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String name;
  final String apiKey;
  final DateTime created_at;
  final bool status;
  Task(
      {@required this.id,
      @required this.name,
      this.apiKey,
      this.created_at,
      @required this.status});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      apiKey:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}api_key']),
      created_at: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      status:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || apiKey != null) {
      map['api_key'] = Variable<String>(apiKey);
    }
    if (!nullToAbsent || created_at != null) {
      map['created_at'] = Variable<DateTime>(created_at);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<bool>(status);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      apiKey:
          apiKey == null && nullToAbsent ? const Value.absent() : Value(apiKey),
      created_at: created_at == null && nullToAbsent
          ? const Value.absent()
          : Value(created_at),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      apiKey: serializer.fromJson<String>(json['apiKey']),
      created_at: serializer.fromJson<DateTime>(json['created_at']),
      status: serializer.fromJson<bool>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'apiKey': serializer.toJson<String>(apiKey),
      'created_at': serializer.toJson<DateTime>(created_at),
      'status': serializer.toJson<bool>(status),
    };
  }

  Task copyWith(
          {int id,
          String name,
          String apiKey,
          DateTime created_at,
          bool status}) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        apiKey: apiKey ?? this.apiKey,
        created_at: created_at ?? this.created_at,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('apiKey: $apiKey, ')
          ..write('created_at: $created_at, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              apiKey.hashCode, $mrjc(created_at.hashCode, status.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.name == this.name &&
          other.apiKey == this.apiKey &&
          other.created_at == this.created_at &&
          other.status == this.status);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> apiKey;
  final Value<DateTime> created_at;
  final Value<bool> status;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.created_at = const Value.absent(),
    this.status = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.apiKey = const Value.absent(),
    this.created_at = const Value.absent(),
    this.status = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Task> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> apiKey,
    Expression<DateTime> created_at,
    Expression<bool> status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (apiKey != null) 'api_key': apiKey,
      if (created_at != null) 'created_at': created_at,
      if (status != null) 'status': status,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> apiKey,
      Value<DateTime> created_at,
      Value<bool> status}) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      apiKey: apiKey ?? this.apiKey,
      created_at: created_at ?? this.created_at,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (created_at.present) {
      map['created_at'] = Variable<DateTime>(created_at.value);
    }
    if (status.present) {
      map['status'] = Variable<bool>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('apiKey: $apiKey, ')
          ..write('created_at: $created_at, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  GeneratedTextColumn _apiKey;
  @override
  GeneratedTextColumn get apiKey => _apiKey ??= _constructApiKey();
  GeneratedTextColumn _constructApiKey() {
    return GeneratedTextColumn(
      'api_key',
      $tableName,
      true,
    );
  }

  final VerificationMeta _created_atMeta = const VerificationMeta('created_at');
  GeneratedDateTimeColumn _created_at;
  @override
  GeneratedDateTimeColumn get created_at =>
      _created_at ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedBoolColumn _status;
  @override
  GeneratedBoolColumn get status => _status ??= _constructStatus();
  GeneratedBoolColumn _constructStatus() {
    return GeneratedBoolColumn('status', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, apiKey, created_at, status];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('api_key')) {
      context.handle(_apiKeyMeta,
          apiKey.isAcceptableOrUnknown(data['api_key'], _apiKeyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _created_atMeta,
          created_at.isAcceptableOrUnknown(
              data['created_at'], _created_atMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Permission extends DataClass implements Insertable<Permission> {
  final int id;
  final String descripcion;
  final DateTime created_at;
  final int idEntidad;
  Permission(
      {@required this.id,
      @required this.descripcion,
      this.created_at,
      @required this.idEntidad});
  factory Permission.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Permission(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      descripcion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}descripcion']),
      created_at: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      idEntidad:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_entidad']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || created_at != null) {
      map['created_at'] = Variable<DateTime>(created_at);
    }
    if (!nullToAbsent || idEntidad != null) {
      map['id_entidad'] = Variable<int>(idEntidad);
    }
    return map;
  }

  PermissionsCompanion toCompanion(bool nullToAbsent) {
    return PermissionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      created_at: created_at == null && nullToAbsent
          ? const Value.absent()
          : Value(created_at),
      idEntidad: idEntidad == null && nullToAbsent
          ? const Value.absent()
          : Value(idEntidad),
    );
  }

  factory Permission.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Permission(
      id: serializer.fromJson<int>(json['id']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      created_at: serializer.fromJson<DateTime>(json['created_at']),
      idEntidad: serializer.fromJson<int>(json['idEntidad']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descripcion': serializer.toJson<String>(descripcion),
      'created_at': serializer.toJson<DateTime>(created_at),
      'idEntidad': serializer.toJson<int>(idEntidad),
    };
  }

  Permission copyWith(
          {int id, String descripcion, DateTime created_at, int idEntidad}) =>
      Permission(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        created_at: created_at ?? this.created_at,
        idEntidad: idEntidad ?? this.idEntidad,
      );
  @override
  String toString() {
    return (StringBuffer('Permission(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('created_at: $created_at, ')
          ..write('idEntidad: $idEntidad')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(descripcion.hashCode,
          $mrjc(created_at.hashCode, idEntidad.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Permission &&
          other.id == this.id &&
          other.descripcion == this.descripcion &&
          other.created_at == this.created_at &&
          other.idEntidad == this.idEntidad);
}

class PermissionsCompanion extends UpdateCompanion<Permission> {
  final Value<int> id;
  final Value<String> descripcion;
  final Value<DateTime> created_at;
  final Value<int> idEntidad;
  const PermissionsCompanion({
    this.id = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.created_at = const Value.absent(),
    this.idEntidad = const Value.absent(),
  });
  PermissionsCompanion.insert({
    this.id = const Value.absent(),
    @required String descripcion,
    this.created_at = const Value.absent(),
    @required int idEntidad,
  })  : descripcion = Value(descripcion),
        idEntidad = Value(idEntidad);
  static Insertable<Permission> custom({
    Expression<int> id,
    Expression<String> descripcion,
    Expression<DateTime> created_at,
    Expression<int> idEntidad,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descripcion != null) 'descripcion': descripcion,
      if (created_at != null) 'created_at': created_at,
      if (idEntidad != null) 'id_entidad': idEntidad,
    });
  }

  PermissionsCompanion copyWith(
      {Value<int> id,
      Value<String> descripcion,
      Value<DateTime> created_at,
      Value<int> idEntidad}) {
    return PermissionsCompanion(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      created_at: created_at ?? this.created_at,
      idEntidad: idEntidad ?? this.idEntidad,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (created_at.present) {
      map['created_at'] = Variable<DateTime>(created_at.value);
    }
    if (idEntidad.present) {
      map['id_entidad'] = Variable<int>(idEntidad.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionsCompanion(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('created_at: $created_at, ')
          ..write('idEntidad: $idEntidad')
          ..write(')'))
        .toString();
  }
}

class $PermissionsTable extends Permissions
    with TableInfo<$PermissionsTable, Permission> {
  final GeneratedDatabase _db;
  final String _alias;
  $PermissionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  GeneratedTextColumn _descripcion;
  @override
  GeneratedTextColumn get descripcion =>
      _descripcion ??= _constructDescripcion();
  GeneratedTextColumn _constructDescripcion() {
    return GeneratedTextColumn(
      'descripcion',
      $tableName,
      false,
    );
  }

  final VerificationMeta _created_atMeta = const VerificationMeta('created_at');
  GeneratedDateTimeColumn _created_at;
  @override
  GeneratedDateTimeColumn get created_at =>
      _created_at ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idEntidadMeta = const VerificationMeta('idEntidad');
  GeneratedIntColumn _idEntidad;
  @override
  GeneratedIntColumn get idEntidad => _idEntidad ??= _constructIdEntidad();
  GeneratedIntColumn _constructIdEntidad() {
    return GeneratedIntColumn(
      'id_entidad',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, descripcion, created_at, idEntidad];
  @override
  $PermissionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'permissions';
  @override
  final String actualTableName = 'permissions';
  @override
  VerificationContext validateIntegrity(Insertable<Permission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion'], _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _created_atMeta,
          created_at.isAcceptableOrUnknown(
              data['created_at'], _created_atMeta));
    }
    if (data.containsKey('id_entidad')) {
      context.handle(_idEntidadMeta,
          idEntidad.isAcceptableOrUnknown(data['id_entidad'], _idEntidadMeta));
    } else if (isInserting) {
      context.missing(_idEntidadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Permission map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Permission.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PermissionsTable createAlias(String alias) {
    return $PermissionsTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final int idEmpresa;
  final int idRol;
  final String nombres;
  final String apellidos;
  final String usuario;
  final String apiKey;
  final String servidor;
  final DateTime created_at;
  final int status;
  User(
      {@required this.id,
      @required this.idEmpresa,
      @required this.idRol,
      @required this.nombres,
      @required this.apellidos,
      @required this.usuario,
      this.apiKey,
      this.servidor,
      this.created_at,
      @required this.status});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idEmpresa:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_empresa']),
      idRol: intType.mapFromDatabaseResponse(data['${effectivePrefix}id_rol']),
      nombres:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombres']),
      apellidos: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apellidos']),
      usuario:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}usuario']),
      apiKey:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}api_key']),
      servidor: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}servidor']),
      created_at: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      status: intType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || idEmpresa != null) {
      map['id_empresa'] = Variable<int>(idEmpresa);
    }
    if (!nullToAbsent || idRol != null) {
      map['id_rol'] = Variable<int>(idRol);
    }
    if (!nullToAbsent || nombres != null) {
      map['nombres'] = Variable<String>(nombres);
    }
    if (!nullToAbsent || apellidos != null) {
      map['apellidos'] = Variable<String>(apellidos);
    }
    if (!nullToAbsent || usuario != null) {
      map['usuario'] = Variable<String>(usuario);
    }
    if (!nullToAbsent || apiKey != null) {
      map['api_key'] = Variable<String>(apiKey);
    }
    if (!nullToAbsent || servidor != null) {
      map['servidor'] = Variable<String>(servidor);
    }
    if (!nullToAbsent || created_at != null) {
      map['created_at'] = Variable<DateTime>(created_at);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idEmpresa: idEmpresa == null && nullToAbsent
          ? const Value.absent()
          : Value(idEmpresa),
      idRol:
          idRol == null && nullToAbsent ? const Value.absent() : Value(idRol),
      nombres: nombres == null && nullToAbsent
          ? const Value.absent()
          : Value(nombres),
      apellidos: apellidos == null && nullToAbsent
          ? const Value.absent()
          : Value(apellidos),
      usuario: usuario == null && nullToAbsent
          ? const Value.absent()
          : Value(usuario),
      apiKey:
          apiKey == null && nullToAbsent ? const Value.absent() : Value(apiKey),
      servidor: servidor == null && nullToAbsent
          ? const Value.absent()
          : Value(servidor),
      created_at: created_at == null && nullToAbsent
          ? const Value.absent()
          : Value(created_at),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      idEmpresa: serializer.fromJson<int>(json['idEmpresa']),
      idRol: serializer.fromJson<int>(json['idRol']),
      nombres: serializer.fromJson<String>(json['nombres']),
      apellidos: serializer.fromJson<String>(json['apellidos']),
      usuario: serializer.fromJson<String>(json['usuario']),
      apiKey: serializer.fromJson<String>(json['apiKey']),
      servidor: serializer.fromJson<String>(json['servidor']),
      created_at: serializer.fromJson<DateTime>(json['created_at']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idEmpresa': serializer.toJson<int>(idEmpresa),
      'idRol': serializer.toJson<int>(idRol),
      'nombres': serializer.toJson<String>(nombres),
      'apellidos': serializer.toJson<String>(apellidos),
      'usuario': serializer.toJson<String>(usuario),
      'apiKey': serializer.toJson<String>(apiKey),
      'servidor': serializer.toJson<String>(servidor),
      'created_at': serializer.toJson<DateTime>(created_at),
      'status': serializer.toJson<int>(status),
    };
  }

  User copyWith(
          {int id,
          int idEmpresa,
          int idRol,
          String nombres,
          String apellidos,
          String usuario,
          String apiKey,
          String servidor,
          DateTime created_at,
          int status}) =>
      User(
        id: id ?? this.id,
        idEmpresa: idEmpresa ?? this.idEmpresa,
        idRol: idRol ?? this.idRol,
        nombres: nombres ?? this.nombres,
        apellidos: apellidos ?? this.apellidos,
        usuario: usuario ?? this.usuario,
        apiKey: apiKey ?? this.apiKey,
        servidor: servidor ?? this.servidor,
        created_at: created_at ?? this.created_at,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('idEmpresa: $idEmpresa, ')
          ..write('idRol: $idRol, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('usuario: $usuario, ')
          ..write('apiKey: $apiKey, ')
          ..write('servidor: $servidor, ')
          ..write('created_at: $created_at, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idEmpresa.hashCode,
          $mrjc(
              idRol.hashCode,
              $mrjc(
                  nombres.hashCode,
                  $mrjc(
                      apellidos.hashCode,
                      $mrjc(
                          usuario.hashCode,
                          $mrjc(
                              apiKey.hashCode,
                              $mrjc(
                                  servidor.hashCode,
                                  $mrjc(created_at.hashCode,
                                      status.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.idEmpresa == this.idEmpresa &&
          other.idRol == this.idRol &&
          other.nombres == this.nombres &&
          other.apellidos == this.apellidos &&
          other.usuario == this.usuario &&
          other.apiKey == this.apiKey &&
          other.servidor == this.servidor &&
          other.created_at == this.created_at &&
          other.status == this.status);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<int> idEmpresa;
  final Value<int> idRol;
  final Value<String> nombres;
  final Value<String> apellidos;
  final Value<String> usuario;
  final Value<String> apiKey;
  final Value<String> servidor;
  final Value<DateTime> created_at;
  final Value<int> status;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.idEmpresa = const Value.absent(),
    this.idRol = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.usuario = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.servidor = const Value.absent(),
    this.created_at = const Value.absent(),
    this.status = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    @required int idEmpresa,
    @required int idRol,
    @required String nombres,
    @required String apellidos,
    @required String usuario,
    this.apiKey = const Value.absent(),
    this.servidor = const Value.absent(),
    this.created_at = const Value.absent(),
    @required int status,
  })  : idEmpresa = Value(idEmpresa),
        idRol = Value(idRol),
        nombres = Value(nombres),
        apellidos = Value(apellidos),
        usuario = Value(usuario),
        status = Value(status);
  static Insertable<User> custom({
    Expression<int> id,
    Expression<int> idEmpresa,
    Expression<int> idRol,
    Expression<String> nombres,
    Expression<String> apellidos,
    Expression<String> usuario,
    Expression<String> apiKey,
    Expression<String> servidor,
    Expression<DateTime> created_at,
    Expression<int> status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idEmpresa != null) 'id_empresa': idEmpresa,
      if (idRol != null) 'id_rol': idRol,
      if (nombres != null) 'nombres': nombres,
      if (apellidos != null) 'apellidos': apellidos,
      if (usuario != null) 'usuario': usuario,
      if (apiKey != null) 'api_key': apiKey,
      if (servidor != null) 'servidor': servidor,
      if (created_at != null) 'created_at': created_at,
      if (status != null) 'status': status,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id,
      Value<int> idEmpresa,
      Value<int> idRol,
      Value<String> nombres,
      Value<String> apellidos,
      Value<String> usuario,
      Value<String> apiKey,
      Value<String> servidor,
      Value<DateTime> created_at,
      Value<int> status}) {
    return UsersCompanion(
      id: id ?? this.id,
      idEmpresa: idEmpresa ?? this.idEmpresa,
      idRol: idRol ?? this.idRol,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      usuario: usuario ?? this.usuario,
      apiKey: apiKey ?? this.apiKey,
      servidor: servidor ?? this.servidor,
      created_at: created_at ?? this.created_at,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idEmpresa.present) {
      map['id_empresa'] = Variable<int>(idEmpresa.value);
    }
    if (idRol.present) {
      map['id_rol'] = Variable<int>(idRol.value);
    }
    if (nombres.present) {
      map['nombres'] = Variable<String>(nombres.value);
    }
    if (apellidos.present) {
      map['apellidos'] = Variable<String>(apellidos.value);
    }
    if (usuario.present) {
      map['usuario'] = Variable<String>(usuario.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (servidor.present) {
      map['servidor'] = Variable<String>(servidor.value);
    }
    if (created_at.present) {
      map['created_at'] = Variable<DateTime>(created_at.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('idEmpresa: $idEmpresa, ')
          ..write('idRol: $idRol, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('usuario: $usuario, ')
          ..write('apiKey: $apiKey, ')
          ..write('servidor: $servidor, ')
          ..write('created_at: $created_at, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idEmpresaMeta = const VerificationMeta('idEmpresa');
  GeneratedIntColumn _idEmpresa;
  @override
  GeneratedIntColumn get idEmpresa => _idEmpresa ??= _constructIdEmpresa();
  GeneratedIntColumn _constructIdEmpresa() {
    return GeneratedIntColumn(
      'id_empresa',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idRolMeta = const VerificationMeta('idRol');
  GeneratedIntColumn _idRol;
  @override
  GeneratedIntColumn get idRol => _idRol ??= _constructIdRol();
  GeneratedIntColumn _constructIdRol() {
    return GeneratedIntColumn(
      'id_rol',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nombresMeta = const VerificationMeta('nombres');
  GeneratedTextColumn _nombres;
  @override
  GeneratedTextColumn get nombres => _nombres ??= _constructNombres();
  GeneratedTextColumn _constructNombres() {
    return GeneratedTextColumn(
      'nombres',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apellidosMeta = const VerificationMeta('apellidos');
  GeneratedTextColumn _apellidos;
  @override
  GeneratedTextColumn get apellidos => _apellidos ??= _constructApellidos();
  GeneratedTextColumn _constructApellidos() {
    return GeneratedTextColumn(
      'apellidos',
      $tableName,
      false,
    );
  }

  final VerificationMeta _usuarioMeta = const VerificationMeta('usuario');
  GeneratedTextColumn _usuario;
  @override
  GeneratedTextColumn get usuario => _usuario ??= _constructUsuario();
  GeneratedTextColumn _constructUsuario() {
    return GeneratedTextColumn(
      'usuario',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  GeneratedTextColumn _apiKey;
  @override
  GeneratedTextColumn get apiKey => _apiKey ??= _constructApiKey();
  GeneratedTextColumn _constructApiKey() {
    return GeneratedTextColumn(
      'api_key',
      $tableName,
      true,
    );
  }

  final VerificationMeta _servidorMeta = const VerificationMeta('servidor');
  GeneratedTextColumn _servidor;
  @override
  GeneratedTextColumn get servidor => _servidor ??= _constructServidor();
  GeneratedTextColumn _constructServidor() {
    return GeneratedTextColumn(
      'servidor',
      $tableName,
      true,
    );
  }

  final VerificationMeta _created_atMeta = const VerificationMeta('created_at');
  GeneratedDateTimeColumn _created_at;
  @override
  GeneratedDateTimeColumn get created_at =>
      _created_at ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedIntColumn _status;
  @override
  GeneratedIntColumn get status => _status ??= _constructStatus();
  GeneratedIntColumn _constructStatus() {
    return GeneratedIntColumn(
      'status',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        idEmpresa,
        idRol,
        nombres,
        apellidos,
        usuario,
        apiKey,
        servidor,
        created_at,
        status
      ];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('id_empresa')) {
      context.handle(_idEmpresaMeta,
          idEmpresa.isAcceptableOrUnknown(data['id_empresa'], _idEmpresaMeta));
    } else if (isInserting) {
      context.missing(_idEmpresaMeta);
    }
    if (data.containsKey('id_rol')) {
      context.handle(
          _idRolMeta, idRol.isAcceptableOrUnknown(data['id_rol'], _idRolMeta));
    } else if (isInserting) {
      context.missing(_idRolMeta);
    }
    if (data.containsKey('nombres')) {
      context.handle(_nombresMeta,
          nombres.isAcceptableOrUnknown(data['nombres'], _nombresMeta));
    } else if (isInserting) {
      context.missing(_nombresMeta);
    }
    if (data.containsKey('apellidos')) {
      context.handle(_apellidosMeta,
          apellidos.isAcceptableOrUnknown(data['apellidos'], _apellidosMeta));
    } else if (isInserting) {
      context.missing(_apellidosMeta);
    }
    if (data.containsKey('usuario')) {
      context.handle(_usuarioMeta,
          usuario.isAcceptableOrUnknown(data['usuario'], _usuarioMeta));
    } else if (isInserting) {
      context.missing(_usuarioMeta);
    }
    if (data.containsKey('api_key')) {
      context.handle(_apiKeyMeta,
          apiKey.isAcceptableOrUnknown(data['api_key'], _apiKeyMeta));
    }
    if (data.containsKey('servidor')) {
      context.handle(_servidorMeta,
          servidor.isAcceptableOrUnknown(data['servidor'], _servidorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _created_atMeta,
          created_at.isAcceptableOrUnknown(
              data['created_at'], _created_atMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $PermissionsTable _permissions;
  $PermissionsTable get permissions => _permissions ??= $PermissionsTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasks, permissions, users];
}
