import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:svelty/Track.dart';

class DatabaseHelper {
  DatabaseHelper();

  Future<void> _onCreate(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS track (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,weight INTEGER, chest INTEGER, abs INTEGER, hip INTEGER, bottom INTEGER, leg INTEGER, created_at INTEGER, to_synchronize INTEGER);');
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  _onOpen(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    log('db version ${await db.getVersion()}');
  }

  Future<Database> getDb() async {
    return openDatabase(
      'main.db',
      version: 1, onConfigure: _onConfigure,
      onCreate: (Database database, int version) async {
        await _onCreate(database);
      }, onOpen: _onOpen,
    singleInstance: true);
  }

  //CREATE
  Future<int> createFlashCard(num weight, int? chest, int? abs, int? hip, int? bottom, int? leg, int createdAt, bool toSynchronize) async {
    final db = await getDb();
    final data = {
      'weight': weight,
      'chest': chest,
      'abs': abs,
      'hip': hip,
      'bottom': bottom,
      'leg': leg,
      'created_at': createdAt,
      'to_synchronize': 1
    };
    final id = await db.insert("track", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //READ
  Future<List<Track>> getAllTracks() async {
    final db = await getDb();
    var maps = await db.query('track', orderBy: "id");
    var list = List.generate(maps.length, (i) {
      return Track.fromMap(maps[i]);
    });
    return list;
  }

  Future<Track> findById(int id) async {
    final db = await getDb();
    var maps = await db
        .query("track", where: "id = ?", limit: 1, whereArgs: [id]);
    var list = List.generate(maps.length, (i) {
      return Track.fromMap(maps[i]);
    });
    return list.first;
  }
  
  Future<int?> getTrackCount()async {
    final db = await getDb();
    final int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM track'));
    return count;
  }

  Future<bool> isThereNonSynchroData() async {
    final db = await getDb();
    final int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM TRACK WHERE to_synchronize = 1'));
    return count != null && count>0;
  }

}