class Contato {
  int? id;
  String? nome;
  String? email;
  String? senha;

  Contato() {
    id = null;
    nome = '';
    email = '';
    senha = '';
  }

  Contato.init(this.id, this.nome, this.email, this.senha);

  factory Contato.fromMap(Map<String, dynamic> json) {
    return Contato.init(json['id'], json['nome'], json['email'], json['senha']);
  }
  Map<String, dynamic> toMap() => {
    'id': id,
    'nome': nome,
    'email': email,
    'senha': senha,
  };
}
