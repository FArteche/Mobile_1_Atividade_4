import 'dart:async';
import 'package:calcom_2_0/Model/DatabaseHelper.dart';
import 'package:calcom_2_0/Model/carro.dart';
import 'package:sqflite/sqflite.dart';

class carroDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final StreamController<List<carro>> _carroStreamController =
      StreamController<List<carro>>();
  Stream<List<carro>> get carroStreamList => _carroStreamController.stream;

  Future<void> loadCarros() async {
    final carros = await selectCarro();
    _carroStreamController.add(carros);
  }

  Stream<List<carro>> getCarroStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield await selectCarro();
    }
  }

  Future<void> insertCarro(carro carro) async {
    final db = await _dbHelper.database;
    await db.insert('Carro', carro.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await loadCarros();
  }

  Future<void> updateCarro(carro carro) async {
    final db = await _dbHelper.database;
    await db
        .update('Carro', carro.toMap(), where: 'id = ?', whereArgs: [carro.id]);
    await loadCarros();
  }

  Future<void> deleteCarro(int idDel) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Carro',
      where: 'id = ?',
      whereArgs: [idDel],
    );
    await loadCarros();
  }
  
  Future<List<carro>> selectCarro() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Carro');
    return List.generate(
      tipoJSON.length,
      (i) {
        return carro.fromMap(tipoJSON[i]);
      },
    );
  }
}
