import 'package:aether/core/constants/peer_constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/chat_constants.dart';
import '../../../../core/constants/conversation_constants.dart';

class DatabaseConfig {
  static final DatabaseConfig instance = DatabaseConfig._init();
  static Database? _database;

  DatabaseConfig._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aether.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // Table des messages
    await db.execute('''
      CREATE TABLE messages(
        $kId TEXT PRIMARY KEY,
        $kContent TEXT NOT NULL,
        $kSenderId TEXT NOT NULL,
        $kReceiverId TEXT NOT NULL,
        $kTimestamp DATETIME NOT NULL,
        $kType TEXT NOT NULL
      )
    ''');

    // Table des peers
    await db.execute('''
      CREATE TABLE peers(
        $kPeerId TEXT PRIMARY KEY,
        $kPeerName TEXT NOT NULL,
        $kPeerDescription TEXT,
        $kPeerDeviceId TEXT NOT NULL,
        $kPeerLastSeen DATETIME NOT NULL,
        $kState TEXT NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clearDatabase() async {
    final db = await instance.database;
    await db.execute('DROP TABLE IF EXISTS messages');
    await db.execute('DROP TABLE IF EXISTS peers');
    await _createDB(db, 1);
  }
}
