import 'package:intl/intl.dart';

class combustivel {
  int? id;
  DateTime data;
  String tipo;
  double preco;

  combustivel({
    this.id,
    required this.preco,
    required this.data,
    required this.tipo,
  });

  String formatarData(DateTime date) {
    final DateFormat formatar = DateFormat('yyyy-MM-dd');
    return formatar.format(date); 
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': formatarData(data),
      'tipo': tipo,
      'preco': preco,
    };
  }

  factory combustivel.fromMap(Map<String, dynamic> map) {
    return combustivel(
      id: map['id'],
      preco: map['preco'],
      data: DateTime.parse(map['data']),
      tipo: map['tipo'],
    );
  }

  String toString() {
    return "$tipo R\$$preco";
  }
}
