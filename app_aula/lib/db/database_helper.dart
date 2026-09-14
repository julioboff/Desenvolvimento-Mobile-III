import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_async/sqlite_async.dart';

class DatabaseHelper {
  // Singleton para instância única do database
  static final DatabaseHelper instance = DatabaseHelper._init();
  static dynamic _database;
  // Definir o nome para o database do aplicativo
  static const String _dbFileName = 'app_database.db';
  // Construtor de inicialização
  DatabaseHelper._init();

  // Migrations para criar e atualizar tabelas
  final migrations = SqliteMigrations()
    ..add(
      SqliteMigration(1, (tx) async {
        await tx.execute(''' CREATE TABLE usuario (
            id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL,
            email TEXT NOT NULL, senha  TEXT NOT NULL
          ) ''');
      }),
    )
    ..add(
      SqliteMigration(
        2,
        (tx) async {
          await tx.execute('''
              ALTER TABLE usuario ADD COLUMN telefone TEXT
          ''');
        },
        // Optional: down migration se instalar versão anterior do app.
        downMigration: SqliteDownMigration(toVersion: 1)
          ..add('ALTER TABLE usuario DROP COLUMN telefone'),
      ),
    );

  // Método de inicialização do database
  Future _initDataBase() async {
    final dbDirectory = await getApplicationDocumentsDirectory();
    final fullPath = join(dbDirectory.path, _dbFileName);
    final db = SqliteDatabase(path: fullPath);
    await migrations.migrate(db);
    return db;
  }

  // Método para obter o database onde for utilizar
  Future get database async {
    if ((_database != null) && (!_database.closed)) return _database!;
    _database = await _initDataBase();
    return _database;
  }
}
