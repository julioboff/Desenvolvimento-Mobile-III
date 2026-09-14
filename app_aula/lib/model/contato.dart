class Contato {
  int? id;
  String? nome;
  String? email;
  String? telefone;
  Contato() {
    id = null;
    nome = "";
    email = "";
    telefone = "";
  }
  Contato.init(this.id, this.nome, this.email, this.telefone);
  factory Contato.fromMap(Map<String, dynamic> json) {
    return Contato.init(
      json['id'],
      json['nome'],
      json['email'],
      json['telefone'],
    );
  }
  Map<String, dynamic> toMap() => {
    'id': id,
    'nome': nome,
    'email': email,
    'telefone': telefone,
  };
}
