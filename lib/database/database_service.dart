import 'dart:io';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String TEXT = 'text';
  static const String AUTHOR = 'author';
  static const String ISFAVOURITE = 'isFavourite';
  static const String TABLE = 'quote';
  static const String DB_NAME = 'quote.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initializeDatabase();
    return _db;
  }

  initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);
    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TEXT TEXT,  $AUTHOR TEXT, $ISFAVOURITE BOOLEAN)');
  }

  // Future<Quote> saveNote(Quote quote) async {
  //   var dbClient = await db;
  //   note.id = await dbClient!.insert(TABLE, quote.toMap());
  //   return note;
  // }

  // Future<List<Note>> getNotes() async {
  //   var dbClient = await db;
  //   List<Map> map = await dbClient.query(
  //     TABLE,
  //     orderBy: ISIMPORTANT,
  //     columns: [ID, TITLE, CONTENT, DATE, ISIMPORTANT],
  //   );
  //   List<Note> noteList = [];
  //   if (map != null) {
  //     for (var i = 0; i < map.length; i++) {
  //       noteList.add(Note.fromMap(map[i]));
  //     }
  //   }
  //   return noteList;
  // }

  // Future<int> deleteNote(int id) async {
  //   var dbClient = await db;
  //   return dbClient.delete(
  //     TABLE,
  //     where: '$ID = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<int> updateNote(Note note) async {
  //   var dbClient = await db;
  //   return dbClient.update(
  //     TABLE,
  //     note.toMap(),
  //     where: '$ID = ?',
  //     whereArgs: [note.id],
  //   );
  // }
}
