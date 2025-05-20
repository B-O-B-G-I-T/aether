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
        $kTimestamp DATETIME NOT NULL,
        $kType TEXT NOT NULL,
        $kConversationId TEXT NOT NULL,
        FOREIGN KEY ($kConversationId) REFERENCES conversations($kId)
      )
    ''');

    // Table des conversations
    await db.execute('''
      CREATE TABLE conversations(
        $kId TEXT PRIMARY KEY,
        $kLastMessage TEXT NOT NULL,
        $kLastActivity TEXT NOT NULL,
        $kPeerId TEXT NOT NULL,
        FOREIGN KEY ($kPeerId) REFERENCES peers($kPeerId)
      )
    ''');
    // Table des peers
    await db.execute('''
      CREATE TABLE peers(
        $kPeerId TEXT PRIMARY KEY,
        $kPeerName TEXT NOT NULL,
        $kState INTEGER NOT NULL,
        $kPeerDescription TEXT,
        $kPeerPathImageProfile TEXT,
        $kPeerMyLastStartEncodeImage TEXT
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
    await db.execute('DROP TABLE IF EXISTS conversations');
    await db.execute('DROP TABLE IF EXISTS peers');
    await _createDB(db, 1);
  }

  Future<void> insertTestData() async {
    final db = await instance.database;

    // Insertion des pairs de test
    await db.insert('peers', {
      kPeerId: 'peer1',
      kPeerName: 'Alice',
      kState: 1,
      kPeerDescription: 'Développeuse Flutter',
      kPeerPathImageProfile: 'assets/images/alice.jpg',
      kPeerMyLastStartEncodeImage: '',
    });

    await db.insert('peers', {
      kPeerId: 'peer2',
      kPeerName: 'Bob',
      kState: 1,
      kPeerDescription: 'Designer UI/UX',
      kPeerPathImageProfile: 'assets/images/bob.jpg',
      kPeerMyLastStartEncodeImage: '',
    });

    // Insertion des conversations de test
    await db.insert('conversations', {
      kId: 'conv1',
      kLastMessage: 'Bonjour, comment vas-tu ?',
      kLastActivity: DateTime.now().toIso8601String(),
      kPeerId: 'peer1',
    });

    await db.insert('conversations', {
      kId: 'conv2',
      kLastMessage: 'On se voit demain ?',
      kLastActivity: DateTime.now().toIso8601String(),
      kPeerId: 'peer2',
    });

    // Insertion des messages de test
    await db.insert('messages', {
      kId: 'msg1',
      kContent: 'Bonjour, comment vas-tu ?',
      kTimestamp: DateTime.now().toIso8601String(),
      kType: 'text',
      kConversationId: 'conv1',
    });

    await db.insert('messages', {
      kId: 'msg2',
      kContent: 'Je vais bien, merci !',
      kTimestamp: DateTime.now().toIso8601String(),
      kType: 'text',
      kConversationId: 'conv1',
    });
  }
}
