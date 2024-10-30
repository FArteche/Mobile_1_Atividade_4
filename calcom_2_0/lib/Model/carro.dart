class carro {
  int? id;
  String nome;
  double autonomia;

  carro({
    this.id,
    required this.nome,
    required this.autonomia,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'autonomia': autonomia,
    };
  }

  factory carro.fromMap(Map<String, dynamic> map) {
    return carro(
      id: map['id'],
      nome: map['nome'],
      autonomia: map['autonomia'],
    );
  }

  String toString() {
    return nome;
  }
}
