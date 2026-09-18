class Animal {
  int? id;
  String nome;
  String especie;
  String raca;
  int idade;
  String pelagem;
  double peso;
  String observacoes;

  Animal({
    this.id,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.idade,
    required this.pelagem,
    required this.peso,
    required this.observacoes,
  });
}
