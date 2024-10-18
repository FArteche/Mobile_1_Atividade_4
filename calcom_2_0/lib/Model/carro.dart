class carro {
  String nome;
  double autonomia;

  carro({
    required this.nome,
    required this.autonomia,
  });

  String toString(){
    return nome;
  }
}