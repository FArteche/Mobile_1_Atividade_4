import 'dart:async';

import 'package:calcom_2_0/Model/DatabaseHelper.dart';
import 'package:calcom_2_0/Model/destino.dart';
import 'package:sqflite/sqflite.dart';

class destinoDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final StreamController<List<destino>> _destinoStreamController =
      StreamController<List<destino>>();
  Stream<List<destino>> get destinoStreamList =>
      _destinoStreamController.stream;

  Future<void> loadDestino() async {
    final destinos = await selectDestino();
    _destinoStreamController.add(destinos);
  }

  Stream<List<destino>> getDestinoStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield await selectDestino();
    }
  }

  Future<void> insertDestino(destino destino) async {
    final db = await _dbHelper.database;
    await db.insert('Destino', destino.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await loadDestino();
  }

  Future<void> updateDestino(destino destino) async {
    final db = await _dbHelper.database;
    await db.update('Destino', destino.toMap(),
        where: 'id = ?', whereArgs: [destino.id]);
    await loadDestino();
  }

  Future<void> deleteDestino(int idDel) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Destino',
      where: 'id = ?',
      whereArgs: [idDel],
    );
    await loadDestino();
  }

  Future<List<destino>> selectDestino() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Destino');
    return List.generate(
      tipoJSON.length,
      (i) {
        return destino.fromMap(tipoJSON[i]);
      },
    );
  }
}
