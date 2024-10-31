import 'dart:async';
import 'package:calcom_2_0/Model/DatabaseHelper.dart';
import 'package:calcom_2_0/Model/historico.dart';
import 'package:sqflite/sqflite.dart';

class historicoDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Stream<List<historico>> getHistoricoStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield await selectHistorico();
    }
  }

  Future<void> insertHistorico(historico historico) async {
    final db = await _dbHelper.database;
    await db.insert('Historico', historico.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateHistorico(historico historico) async {
    final db = await _dbHelper.database;
    await db
        .update('Historico', historico.toMap(), where: 'id = ?', whereArgs: [historico.id]);
  }

  Future<void> deleteHistorico(int idDel) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Historico',
      where: 'id = ?',
      whereArgs: [idDel],
    );
  }
  
  Future<List<historico>> selectHistorico() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Historico');
    return List.generate(
      tipoJSON.length,
      (i) {
        return historico.fromMap(tipoJSON[i]);
      },
    );
  }
}
