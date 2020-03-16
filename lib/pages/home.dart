import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/pages/formulario_contato.dart';
import 'package:flutterapp/pages/listagem_contato.dart';
import 'package:flutterapp/utils/nav.dart';
import 'package:shake/shake.dart';

class Home extends StatelessWidget {

  /// Array de frases aleatórias
//  var arrFrases = ["o padrão tranca a inovação", "é isso que eu digo...", "é isso que me irrita...", "olha, por favor!", "eles não sabem o que é cloud!", "eles são muito burro!", "eu tava vendo umas coisas em GO...", "Blá blá blá...... começa por aí", "Dijon... dijon", "... é uma porcaria!", "a gente pode fazer uma receitinha Docker"];

  @override
  Widget build(BuildContext context) {

//    /// Detector de shake
//    ShakeDetector.autoStart(onPhoneShake: () {
//      _dialogoFrase(context);
//    });

    /// Compoenente principal
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.textsms),
//            tooltip: 'Gerar frase aleatória do Maicon',
//            onPressed: () => _dialogoFrase(context),
//          ),
//        ],
      ),
      body: Container(
        // Padding para todos os lados do componente
        padding: EdgeInsets.all(5),
        // Compoenente listagem
        child: ListagemContato(),
      ),
      // Botão para novo cadastro
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContato(context),
        tooltip: 'Novo contato',
        child: Icon(Icons.add),
      ),
    );
  }

  /// Método responsável por abrir o formulário de cadastro de contato
  void _addContato(context) {
    push(context, FormularioContato());
  }

//  /// Método responsável por abrir uma caixa de diálogo
//  void _dialogoFrase(context) {
//    Widget cancelar = FlatButton(
//      child: Text("Sair"),
//      onPressed: () {
//        pop(context);
//      },
//    );
//    Widget gerarNovaFrase = FlatButton(
//      child: Text("Nova frase"),
//      onPressed: () {
//        pop(context);
//        _dialogoFrase(context);
//      },
//    );
//    AlertDialog alert = AlertDialog(
//      title: Text("Lorem Maicon"),
//      content: Text(_getFraseAleatoria()),
//      actions: [cancelar, gerarNovaFrase],
//    );
//    //exibe o diálogo
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return alert;
//      },
//    );
//  }

//  /// Método responsável por entregar uma frase aleatória do array
//  String _getFraseAleatoria() {
//    var random = new Random();
//    return arrFrases[random.nextInt(arrFrases.length)];
//  }
}
