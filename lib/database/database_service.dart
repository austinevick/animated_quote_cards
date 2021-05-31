// import 'dart:io';
// import 'package:animated_note_app/model/note.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static Database _db;
//   static const String ID = 'id';
//   static const String TITLE = 'title';
//   static const String CONTENT = 'content';
//   static const String ISIMPORTANT = 'isImportant';
//   static const String TABLE = 'note';
//   static const String DATE = 'date';
//   static const String DB_NAME = 'note.db';

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initializeDatabase();
//     return _db;
//   }

//   initializeDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, DB_NAME);
//     return await openDatabase(path, version: 1, onCreate: createDatabase);
//   }

//   createDatabase(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT, $DATE TEXT, $CONTENT TEXT, $ISIMPORTANT BOOLEAN)');
//   }

//   Future<Note> saveNote(Note note) async {
//     var dbClient = await db;
//     note.id = await dbClient.insert(TABLE, note.toMap());
//     return note;
//   }

//   Future<List<Note>> getNotes() async {
//     var dbClient = await db;
//     List<Map> map = await dbClient.query(
//       TABLE,
//       orderBy: ISIMPORTANT,
//       columns: [ID, TITLE, CONTENT, DATE, ISIMPORTANT],
//     );
//     List<Note> noteList = [];
//     if (map != null) {
//       for (var i = 0; i < map.length; i++) {
//         noteList.add(Note.fromMap(map[i]));
//       }
//     }
//     return noteList;
//   }

//   Future<int> deleteNote(int id) async {
//     var dbClient = await db;
//     return dbClient.delete(
//       TABLE,
//       where: '$ID = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> updateNote(Note note) async {
//     var dbClient = await db;
//     return dbClient.update(
//       TABLE,
//       note.toMap(),
//       where: '$ID = ?',
//       whereArgs: [note.id],
//     );
//   }
// }