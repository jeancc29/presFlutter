import 'package:moor/moor.dart';
import 'package:moor/moor_web.dart';


part 'database.g.dart';
// flutterb packages pub run build_runner watch

class Tasks extends Table{
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get apiKey => text().nullable()();
  DateTimeColumn get created_at => dateTime().nullable()();
  BoolColumn get status => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Permissions extends Table{
  IntColumn get id => integer()();
  TextColumn get descripcion => text()();
  DateTimeColumn get created_at => dateTime().nullable()();
  IntColumn get idEntidad => integer()();

  // IntColumn get status => integer()();
  // BoolColumn get status => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Users extends Table{
  IntColumn get id => integer()();
  IntColumn get idEmpresa => integer()();
  IntColumn get idRol => integer()();
  TextColumn get nombres => text()();
  TextColumn get apellidos => text()();
  TextColumn get usuario => text()();
  TextColumn get apiKey => text().nullable()();
  TextColumn get servidor => text().nullable()();
  DateTimeColumn get created_at => dateTime().nullable()();
  IntColumn get status => integer()();
  // BoolColumn get status => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}


@UseMoor(tables: [Tasks, Permissions, Users])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(WebDatabase('app', logStatements: true));

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Future insertTask(Task task) => into(tasks).insert(task);
  Future updateTask(Task task) => update(tasks).replace(task);
  Future deleteTask(Task task) => delete(tasks).delete(task);
  Future<void> insertListTask(List<Task> listTask) {
    return batch((b) => b.insertAllOnConflictUpdate(tasks, listTask));
  }

  Future<void> insertListPermission(List<Permission> permisos) async {
    return await batch((b) => b.insertAllOnConflictUpdate(permissions, permisos));
  }
  Future deleteAllPermission() => customStatement("delete from permissions");
  Future<bool> existePermiso(String permiso) async {
    var p = await ((select(permissions)..where((p) => p.descripcion.equals(permiso))).getSingle());
    // print("moor_Database existePermiso: ${p.toJson()}");
    return p != null;
  }




  Future insertUser(User user) => into(users).insertOnConflictUpdate(user);
  Future updateUser(User user) => update(users).replace(user);
  Future deleteUser(User user) => delete(users).delete(user);
  Future deleteAllUser() => customStatement("delete from users");
  Future<Map<String, dynamic>> getUsuario() async => (await ((select(users)..limit(1)).getSingle())).toJson();
  Future<int> getIdUsuario() async {
    User e = await ((select(users)..limit(1)).getSingle());
    return (e != null) ? e.id : 0;
  }
  Future<int> idUsuario() async {
    User e = await ((select(users)..limit(1)).getSingle());
    return (e != null) ? e.id : 0;
  }



 
  Future<void> deleteAllTables() async {
    // return await batch((b) => b.insertAllOnConflictUpdate(servers, listServer));
    await batch((b) {
      b.customStatement("delete from users", []);
      b.customStatement("delete from permissions", []);
    });
  }

}

