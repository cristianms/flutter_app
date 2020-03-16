import 'dart:async';

import 'package:flutterapp/model/contato.dart';
import 'package:flutterapp/model/contato_dao.dart';
import 'package:flutterapp/utils/simple_bloc.dart';

/// Classe Bloc criada para tratar regras e requisições de 'contato'
class ContatoBloc extends SimpleBloc<List<Contato>> {
  /// Método responsável por retornar um List de contatos
  Future<List<Contato>> fetch() async {
    try {
      // Realiza a consulta através da classe DAO
      List<Contato> arrContatos = await ContatoDAO().findAll();

//      if(arrContatos.length < 100) {
//          Contato entity = Contato();
//          var objDao = ContatoDAO();
//          for (int i = 0; i < 100; i++) {
//            entity.nome = "Teste $i";
//            entity.email = "teste_$i@teste.com.br";
//            entity.idade = i;
//            entity.sexo = 'm';
//            objDao.save(entity);
//          }
//          print('um milhão inseridos...');
//      }

      // Adiciona dados para o stream
      add(arrContatos);
      // Retorna
      return arrContatos;
    } catch (e) {
      print(e);
      addError(e);
    }
  }
}
