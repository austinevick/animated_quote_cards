import 'dart:io';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String TEXT = 'q';
  static const String AUTHOR = 'a';
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

  Future<Quote> saveQuote(Quote quote) async {
    var dbClient = await db;
    quote.id = await dbClient!.insert(TABLE, quote.toMap());
    return quote;
  }

  Future<List<Quote>> getQuotes() async {
    var dbClient = await db;
    List<Map<String, Object?>> map = await dbClient!.query(
      TABLE,
      columns: [ID, TEXT, AUTHOR, ISFAVOURITE],
    );
    List<Quote> quoteList = [];
    for (var i = 0; i < map.length; i++) {
      quoteList.add(Quote.fromMap(map[i]));
    }
    return quoteList;
  }

  Future<int> deleteQuote(int id) async {
    var dbClient = await db;
    return dbClient!.delete(
      TABLE,
      where: '$ID = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateQuote(Quote quote) async {
    var dbClient = await db;
    return dbClient!.update(
      TABLE,
      quote.toMap(),
      where: '$ID = ?',
      whereArgs: [quote.id],
    );
  }
}
