import 'package:flutter/material.dart';

/// Classe que centraliza os botões do app
class AppButton extends StatelessWidget {
  // Label do botão
  String label;
  // Função a ser executada ao clicar no botão
  Function onPressed;
  // Flag que define se mostra ou não o CircularProgressIndicator no botão
  bool showProgress;
  // Construtor
  AppButton(this.label, {this.onPressed, this.showProgress = false});
  // Método que renderiza o componente/widget
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(15),
      child: showProgress
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ))
          : Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
      color: Colors.blue,
      onPressed: onPressed,
    );
  }
}
