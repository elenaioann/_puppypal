//Diary Database using SQL lite for flutter to accomodate persistent storage
import 'package:path/path.dart';
import 'package:puppy_pal/pages/diary/diary.dart';
import 'package:sqflite/sqflite.dart';

class DiaryDatabase {
  //constructor
  static final DiaryDatabase item =
      DiaryDatabase._init(); //calling constuctor instance
  static Database?
      _database; //database field which comes from the sqf lite package

  DiaryDatabase._init();

  Future<Database> get database async {
    //creates the new database
    if (_database != null)
      return _database!; //return the database in case it exists
    _database = await _initDB(
        'diary.db'); //initialise new database creates new file where db is stored
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    //initialises the database
    //open database
    final dbPath = await getDatabasesPath(); //save db in the path storage
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: _generateDB); //open database
  }

  Future _generateDB(Database db, int version) async {
    //creates database table

    //table variables
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT'; //identifier
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INTEGER NOT NULL';

    //sql input for creating the table
    //structure of table
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

  //creating the diary note
  Future<Diary> create(Diary diary) async {
    final db = await item.database; //reference of db
    final id = await db.insert(
        diaryNotes,
        diary
            .toJson()); //insert the diary object to the db that would generate an id
    return diary.copy(
        id: id); //returning the id to the object by using copy method and modifying the id
  }

  //function returns diary entry
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

  //for displaying all notes in the diary page
  Future<List<Diary>> allEntriesDiary() async {
    final db = await item.database;

    const orderBy = '${DiaryFields.time} ASC';
    final result = await db.query(diaryNotes, orderBy: orderBy);
    return result.map((json) => Diary.fromJson(json)).toList();
  }

  //for updating notes
  Future<int> update(Diary diary) async {
    final db = await item.database;

    return db.update(
      diaryNotes,
      diary.toJson(),
      where: '${DiaryFields.id} = ?',
      whereArgs: [diary.id],
    );
  }

  //for deleting notes
  Future<int> delete(int id) async {
    final db = await item.database;

    return await db.delete(
      diaryNotes,
      where: '${DiaryFields.id} = ?',
      whereArgs: [id],
    );
  }

  //closing the database
  Future close() async {
    final db = await item.database; //access db
    db.close(); //close db
  }
}
