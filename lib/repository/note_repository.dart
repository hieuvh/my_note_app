import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mynote/ui/views/note/note_model.dart';

class LocalRepository {
  static LocalRepository _localRepo;
  static Database _database;

  String dbTable = 'dataTable';
  String id = 'id';
  String title = 'title';
  String desc = 'desc';

  LocalRepository._createInstance();

  factory LocalRepository() {
    if (_localRepo == null) {
      _localRepo = LocalRepository._createInstance();
    }
    return _localRepo;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'data_db.db';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $dbTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $desc TEXT)');
  }

  Future<List<ListModel>> getDbData() async {
    Database db = await this.database;
    List<Map> maps = await db.query(dbTable, orderBy: '$id ASC');
    List<ListModel> noteList = List<ListModel>();
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        noteList.add(ListModel.fromMapObject(maps[i]));
      }
    }
    return noteList;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query(dbTable, orderBy: '$id ASC');
    return result;
  }

  Future<int> insertData(ListModel data) async {
    Database db = await this.database;
    var result = await db.insert(dbTable, data.toMap());
    return result;
  }

  Future<int> updateData(ListModel data) async {
    var db = await this.database;
    var result = await db
        .update(dbTable, data.toMap(), where: '$id = ?', whereArgs: [data.id]);
    return result;
  }

  Future<int> deleteData(int cid) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $dbTable WHERE $id = $cid');
    return result;
  }
}
