import 'package:flutterapp/utils/base-dao.dart';

import 'contato.dart';

/// Classe de acesso a dados - Data Access Object
class ContatoDAO extends BaseDAO<Contato> {

  // Seta propriedade tableName
  @override
  String get tableName => "contato";

  // Implementa método fromMap
  @override
  Contato fromMap(Map<String, dynamic> map) {
    return Contato.fromMap(map);
  }

}
