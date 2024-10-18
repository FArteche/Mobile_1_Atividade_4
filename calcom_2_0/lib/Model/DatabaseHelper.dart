import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'calcom.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE Carro (
      id INT AUTO_INCREMENT PRIMARY KEY,
      nome_veiculo VARCHAR(255) NOT NULL,
      autonomia DOUBLE NOT NULL
      );

      CREATE TABLE Combustivel (
      id INT AUTO_INCREMENT PRIMARY KEY,
      data VARCHAR(10) NOT NULL, -- Formato da data: 'YYYY-MM-DD'
      tipo VARCHAR(50) NOT NULL,
      preco DOUBLE NOT NULL
      );

      CREATE TABLE Destino (
      id INT AUTO_INCREMENT PRIMARY KEY,
      nomedestino VARCHAR(255) NOT NULL,
      distancia DOUBLE NOT NULL
      );''',
    );
  }

  Future close() async{
    final db = await database;
    db.close();
  }
}
