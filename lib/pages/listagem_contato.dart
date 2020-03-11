import 'package:flutter/material.dart';
import 'package:flutterapp/model/contato.dart';
import 'package:flutterapp/model/contato_bloc.dart';
import 'package:flutterapp/widgets/text-error.dart';

class ListagemContato extends StatefulWidget {
  @override
  _ListagemContatoState createState() => _ListagemContatoState();
}

class _ListagemContatoState extends State<ListagemContato> {
  // Classe responsável pelas regras de negócio do componente
  ContatoBloc _bloc = new ContatoBloc();

  @override
  void initState() {
    super.initState();
    // Chama a classe de negócio para buscar os dados da lista
    _bloc.fetch();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        // Regras que serão executadas após receber o retorno
        // Se a requisição falhar exibe mensagem
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os dados...");
        }
        // Enquanto os dados não vem habilita o "loader circular"
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Recebe a lista de carros
        List<Contato> arrContatos = snapshot.data;
        // Retorna o componente listview com os dados
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: lista(arrContatos),
        );
      },
    );
  }

  lista(arrContatos) {
    return Container(
      child: ListView.builder(
          itemCount: arrContatos != null ? arrContatos.length : 0,
          itemBuilder: (context, index) {
            Contato c = arrContatos[index];
            return Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(c.nome),
                    Text(
                      c.email,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      c.sexo.toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      c.idade.toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }
}
