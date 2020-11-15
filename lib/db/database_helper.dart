import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:CrudMedicamentos/model/medicamento.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

 void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE medicamento(id INTEGER PRIMARY KEY,nome TEXT, principio TEXT, concentracao TEXT, preco TEXT)');
  }

  Future<int> inserirMedicamento(Medicamento medicamento) async {
    var dbClient = await db;
    var result = await dbClient.insert("medicamento", medicamento.toMap());

    return result;
  }

  Future<List> getMedicamentos() async {
    var dbClient = await db;
    var result = await dbClient.query("medicamento", columns: ["id", "nome", "principio", "concentracao", "preco"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM medicamento'));
  }
Future<Medicamento> getMedicamento(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("medicamento",
        columns: ["id", "nome", "principio", "concentracao", "preco"], where: 'ide = ?', whereArgs: [id]);
    if (result.length > 0) {
      return new Medicamento.fromMap(result.first);
    }
    return null;
  }
Future<int> deleteMedicamento(int id) async {
    var dbClient = await db;
    return await dbClient.delete("medicamento", where: 'id = ?', whereArgs: [id]);
  }
Future<int> updateMedicamento(Medicamento medicamento) async {
    var dbClient = await db;
    return await dbClient.update("medicamento", medicamento.toMap(),
        where: "id = ?", whereArgs: [medicamento.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
