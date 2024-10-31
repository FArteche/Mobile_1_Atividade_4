class historico {
  int? id;
  double gasto;
  String histComb;
  String histVeic;
  String histDest;

  historico({
    this.id,
    required this.gasto,
    required this.histComb,
    required this.histVeic,
    required this.histDest,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gasto': gasto,
      'histComb': histComb,
      'histVeic': histVeic,
      'histDest': histDest,
    };
  }

  factory historico.fromMap(Map<String, dynamic> map) {
    return historico(
      id: map['id'],
      gasto: map['gasto'],
      histComb: map['histComb'],
      histVeic: map['histVeic'],
      histDest: map['histDest'],
    );
  }
}
