import 'package:cine_vault/model/cine_item.dart';
import 'package:cine_vault/model/watchlist.dart';
import 'package:cine_vault/strategy/i_local_data_source.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PersistenceManager extends ILocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cinevault.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cine_items (
        imdbID TEXT PRIMARY KEY,
        Title TEXT,
        Type TEXT,
        Poster TEXT,
        Year TEXT,
        imdbRating TEXT,
        Released TEXT,
        Runtime TEXT,
        Genre TEXT,
        Language TEXT,
        Country TEXT,
        Plot TEXT
      )
    ''');
  }

  @override
  Future<void> saveList(Watchlist list) async {
    final db = await database;
    await db.delete('cine_items');
    final batch = db.batch();
    for (final item in list.items) {
      batch.insert('cine_items', item.toJson());
    }
    await batch.commit();
  }

  @override
  Future<Watchlist?> loadList(String id) async {
    final db = await database;
    final result = await db.query('cine_items');
    if (result.isEmpty) {
      return null;
    }
    final items = result.map((json) => CineItem.fromJson(json)).toList();
    return Watchlist(listId: id, name: 'My Vault', items: items);
  }
}
