import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:interview_note_app/model/user.dart';
import '../../model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE user (
  id $idType,
  userName $textType,
  password $textType
)
''');

    await db.execute('''
CREATE TABLE $tableNotes (
  ${NoteFields.id} $idType, 
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType,
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES user(id)
  )
''');

    await db.insert('user', {'username': 'nidhal', 'password': 'nidhal123'});
    await db.insert('user', {'username': 'brahim', 'password': 'brahim123'});
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes(
      {required int userId, required String filter}) async {
    final db = await instance.database;

    String orderBy = '$filter ASC';

    final result = await db.query(
      tableNotes,
      orderBy: orderBy,
      where: '${NoteFields.userId} = ?',
      whereArgs: [userId],
    );

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>> searchNote(
      {required int userId, required String searchedNote}) async {
    final db = await instance.database;

    final result = await db.query(
      tableNotes,
      where: '${NoteFields.userId} = ? and ${NoteFields.title} LIKE ?',
      whereArgs: [userId, '%$searchedNote%'],
    );

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<User>> getUserByName({required String userName}) async {
    final db = await instance.database;
    final result =
        await db.query('user', where: 'username = ?', whereArgs: [userName]);

    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
