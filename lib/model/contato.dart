import 'package:flutterapp/utils/entity.dart';
import 'dart:convert' as convert;

// Classe base da entidade
class Contato extends Entity {

  // Propriedades
  int id_contato;
  String nome;
  String email;
  int idade;
  String sexo;

  // Construtor
  Contato({this.id_contato, this.nome, this.email, this.idade, this.sexo});

  // Retorna um Map a partir do objeto
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id_contato'] = this.id_contato;
    map['nome'] = this.nome;
    map['email'] = this.email;
    map['idade'] = this.idade;
    map['sexo'] = this.sexo;
    return map;
  }

  // Retorna o objeto a partir de um Map
  Contato.fromMap(Map<String, dynamic> map) {
    id_contato = map['id_contato'];
    nome = map['nome'];
    email = map['email'];
    idade = map['idade'];
    sexo = map['sexo'];
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Contato{id_contato: $id_contato, nome: $nome, email: $email, idade: $idade, sexo: $sexo}';
  }

}
