class combustivel {
  DateTime data;
  String tipo;
  double preco;

  combustivel({
    required this.preco,
    required this.data,
    required this.tipo,
  });

    String toString(){
    return "$tipo R\$$preco";
  }
}
