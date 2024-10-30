import 'dart:async';

import 'package:calcom_2_0/Model/DatabaseHelper.dart';
import 'package:calcom_2_0/Model/combustivel.dart';
import 'package:sqflite/sqflite.dart';

class combustivelDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final StreamController<List<combustivel>> _combustivelStreamController =
      StreamController<List<combustivel>>();
  Stream<List<combustivel>> get combustivelStreamList =>
      _combustivelStreamController.stream;

  Future<void> loadCombustivel() async {
    final combustivel = await selectCombustivel();
    _combustivelStreamController.add(combustivel);
  }

  Stream<List<combustivel>> getCombustivelStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield await selectCombustivel();
    }
  }

  Future<void> insertCombustivel(combustivel combustivel) async {
    final db = await _dbHelper.database;
    await db.insert('Combustivel', combustivel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await loadCombustivel();
  }

  Future<void> updateCombustivel(combustivel combustivel) async {
    final db = await _dbHelper.database;
    await db.update('Combustivel', combustivel.toMap(),
        where: 'id = ?', whereArgs: [combustivel.id]);
    await loadCombustivel();
  }

  Future<void> deleteCombustivel(int idDel) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Combustivel',
      where: 'id = ?',
      whereArgs: [idDel],
    );
    await loadCombustivel();
  }

  Future<List<combustivel>> selectCombustivel() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Combustivel');
    return List.generate(
      tipoJSON.length,
      (i) {
        return combustivel.fromMap(tipoJSON[i]);
      },
    );
  }
}
