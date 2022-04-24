import 'package:path/path.dart';
import 'package:puppy_pal/pages/diary/diary.dart';
import 'package:sqflite/sqflite.dart';

class DiaryDatabase {
  static final DiaryDatabase item = DiaryDatabase._init();

  static Database? _database;

  DiaryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('diary.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    //open db
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _generateDB);
  }

  Future _generateDB(Database db, int version) async {
    //creates database table
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $diaryNotes (
      ${DiaryFields.id} $idType,
      ${DiaryFields.isEssential} $boolType,
      ${DiaryFields.number} $intType,
      ${DiaryFields.title} $textType,
      ${DiaryFields.description} $textType,
      ${DiaryFields.time} $textType
    )
  ''');
  }

  Future<Diary> create(Diary diary) async {
    final db = await item.database;
    final id = await db.insert(diaryNotes, diary.toJson());
    return diary.copy(id: id);
  }

  Future<Diary> readDiary(int id) async {
    final db = await item.database;
    final maps = await db.query(
      diaryNotes,
      columns: DiaryFields.values,
      where: '${DiaryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Diary.fromJson(maps.first);
    } else {
      throw Exception('$id unavailable');
    }
  }

  Future<List<Diary>> allEntriesDiary() async {
    final db = await item.database;

    const orderBy = '${DiaryFields.time} ASC';
    final result = await db.query(diaryNotes, orderBy: orderBy);
    return result.map((json) => Diary.fromJson(json)).toList();
  }

  Future<int> update(Diary diary) async {
    final db = await item.database;

    return db.update(
      diaryNotes,
      diary.toJson(),
      where: '${DiaryFields.id} = ?',
      whereArgs: [diary.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await item.database;

    return await db.delete(
      diaryNotes,
      where: '${DiaryFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await item.database;
    db.close(); //close db
  }
}
