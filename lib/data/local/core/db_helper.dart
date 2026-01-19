import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'make_plan.db');

    return openDatabase(
      path,
      version: 2, // 🔥 bump version
      onConfigure: (db) async {
        // enable foreign keys (for roadmap steps cascade delete)
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {

        // ---------- TODOS ----------
        await db.execute('''
        CREATE TABLE todos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          taskname TEXT,
          description TEXT,
          datetime TEXT,
          iscompleted INTEGER,
          ispriority INTEGER
        )
        ''');

        // ---------- PLANNERS ----------
        await db.execute('''
        CREATE TABLE planners(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          date TEXT,
          iscompleted INTEGER
        )
        ''');

        // ---------- ROADMAPS ----------
        await db.execute('''
        CREATE TABLE roadmaps(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category TEXT
        )
        ''');

       // ---------- ROADMAP STEPS ----------
await db.execute('''
CREATE TABLE roadmap_steps(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  roadmap_id INTEGER,   -- ✅ FIXED
  title TEXT,
  description TEXT,
  iscompleted INTEGER,
  FOREIGN KEY (roadmap_id) REFERENCES roadmaps(id) ON DELETE CASCADE
)
''');

// ---------- ROADMAP CHAT ----------
await db.execute('''
CREATE TABLE roadmap_chat(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text TEXT,
  is_user INTEGER,
  created_at TEXT
)
''');

      },
    );
  }
}
