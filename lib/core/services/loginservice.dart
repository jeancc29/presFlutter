import 'package:prestamo/core/classes/database.dart';
import 'package:flutter/material.dart';


class LoginService {
  static Future save({@required Map<String, dynamic> parsed, AppDatabase db}) async {
    await db.deleteAllTables();
    await db.insertUser(User.fromJson(parsed["usuario"]));
    // await db.insertUser(User(id: parsed["usuario"]["id"], nombres: parsed["usuario"]["nombres"], apellidos: parsed["usuario"]["apellidos"], status: parsed["usuario"]["status"], usuario: parsed["usuario"]["usuario"]));
    // List<Permission> permisos = (parsed["usuario"]["permisos"] != null) ? parsed["usuario"]["permisos"].map<Permission>((json) => Permission.fromJson(json)).toList() : [];
    List<Permission> permisos = (parsed["usuario"]["permisos"] != null) ? parsed["usuario"]["permisos"].map<Permission>((json) => Permission(id: json["id"], descripcion: json["descripcion"], idEntidad: json["idEntidad"])).toList() : [];
    if(permisos.length > 0)
      await db.insertListPermission(permisos);

      // Permission()
  }

  static Future save2( Map<String, dynamic> map) async {
    Map<String, dynamic> parsed = map["parsed"];
    AppDatabase db = map["db"];
    await db.deleteAllTables();
    await db.insertUser(User.fromJson(parsed["usuario"]));
    // await db.insertUser(User(id: parsed["usuario"]["id"], nombres: parsed["usuario"]["nombres"], apellidos: parsed["usuario"]["apellidos"], status: parsed["usuario"]["status"], usuario: parsed["usuario"]["usuario"]));
    // List<Permission> permisos = (parsed["usuario"]["permisos"] != null) ? parsed["usuario"]["permisos"].map<Permission>((json) => Permission.fromJson(json)).toList() : [];
    List<Permission> permisos = (parsed["usuario"]["permisos"] != null) ? parsed["usuario"]["permisos"].map<Permission>((json) => Permission(id: json["id"], descripcion: json["descripcion"], idEntidad: json["idEntidad"])).toList() : [];
    if(permisos.length > 0)
      await db.insertListPermission(permisos);

      // Permission()
  }
}