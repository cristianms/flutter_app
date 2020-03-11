import 'package:flutter/material.dart';
import 'package:flutterapp/model/contato.dart';
import 'package:flutterapp/model/contato_dao.dart';
import 'package:flutterapp/utils/alert.dart';
import 'package:flutterapp/utils/nav.dart';
import 'package:flutterapp/widgets/app_button.dart';
import 'package:flutterapp/widgets/app_text.dart';

class FormularioContato extends StatefulWidget {
  // Declaração do objeto contato a ser administrado
  Contato contato;

  // Declaração do construtor
  FormularioContato({this.contato});

  // Implementa método obrigatório para criação do state
  @override
  _FormularioContatoState createState() => _FormularioContatoState();
}

class _FormularioContatoState extends State<FormularioContato> {
  // Declara key para controle do estado do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador do campo 'nome'
  final tNome = TextEditingController();

  // Controlador do campo 'e-mail'
  final tEmail = TextEditingController();

  // Controlador do campo 'idade'
  final tIdade = TextEditingController();

  // Controlador do campo 'sexo'
  final tSexo = TextEditingController();
  int _radioIndex = 0;

  // Declara get para a propriedade contato
  Contato get contato => widget.contato;

  // Propriedade responsável por controlar se deve mostrar o loading no botão
  var _showProgress = false;

  // Implementa método para iniciar o estado do formulário
  @override
  void initState() {
    super.initState();
    // Se tiver os dados do contato preenche o formulário
    if (contato != null) {
      tNome.text = contato.nome;
      tEmail.text = contato.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de contato'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _onCadastrarContato(context),
          ),
        ],
      ),
      body: Formulario(context),
    );
  }

  // Widget responsável por montar layout do formulário
  Formulario(context) {
    return Form(
      key: this._formKey,
      child: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          _headerFoto(),
          Container(
            padding: EdgeInsets.all(5),
            child: AppText(
              'Nome',
              '',
              controller: tNome,
              keyboardType: TextInputType.text,
              validator: _validar,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: AppText(
              'E-mail',
              '',
              controller: tEmail,
              keyboardType: TextInputType.emailAddress,
              validator: _validar,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: AppText(
              'Idade',
              '',
              controller: tIdade,
              keyboardType: TextInputType.number,
              validator: _validar,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: _radioSexo(),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: AppButton(
              'Salvar',
              onPressed: () => _onCadastrarContato(context),
              showProgress: _showProgress,
            ),
          ),
        ],
      ),
    );
  }

  _headerFoto() {
    return Image.asset(
      "assets/images/camera.png",
      height: 100,
    );
  }

  String _validar(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  void _onCadastrarContato(context) {
    // Chama as funções de validação definidas nos campos
    if (!_formKey.currentState.validate()) {
      return;
    }
    // Cria o contato para salvar
    Contato contatoSalvar = contato ?? Contato();
    contatoSalvar.nome = tNome.text;
    contatoSalvar.email = tEmail.text;
    contatoSalvar.idade = int.parse(tIdade.text);
    contatoSalvar.sexo = _getSexo();
    print("Contato para salvar: $contatoSalvar");
    // Add loding no botão
    setState(() {
      _showProgress = true;
    });
    // Salva cadastro
    ContatoDAO().save(contatoSalvar);
    // Fecha formulário
    pop(context);
    // Remove o loding do botão
    setState(() {
      _showProgress = false;
    });

    alert(context, "Dados cadastrados com sucesso");
  }

  _radioSexo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickRadio,
        ),
        Text(
          "Feminino",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickRadio,
        ),
        Text(
          "Masculino",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickRadio(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  String _getSexo() {
    switch (_radioIndex) {
      case 0:
        return "f";
      case 1:
        return "m";
    }
  }
}
