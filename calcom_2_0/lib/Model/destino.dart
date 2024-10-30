class destino {
  int? id;
  String nomeDestino;
  double distancia;

  destino({
    this.id,
    required this.nomeDestino,
    required this.distancia,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomedestino': nomeDestino,
      'distancia': distancia,
    };
  }

  factory destino.fromMap(Map<String, dynamic> map) {
    return destino(
      id: map['id'],
      nomeDestino: map['nomedestino'],
      distancia: map['distancia'],
    );
  }

  String toString() {
    return nomeDestino;
  }
}
