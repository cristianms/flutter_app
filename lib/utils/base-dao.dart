import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'entity.dart';

/// Classe de acesso a dados - Data Access Object
abstract class BaseDAO<T extends Entity> {
  /// Captura a instância do banco
  Future<Database> get db => DatabaseHelper.getInstance().db;

  /// Propriedade que precisará ser setada ao utilizar o BaseDAO representa a
  /// entidade
  String get tableName;

  /// Método responsável por receber um Map e retornar o objeto
  T fromMap(Map<String, dynamic> map);

  /// Método responsável por salvar o registro passado
  Future<int> save(T entity) async {
    /// Captura instância do banco
    var dbClient = await db;

    /// Insere na tabela da entidade o json (automático)
    /// "conflictAlgorithm" significa que o banco irá ignorar registros duplicados
    /// e não lançará erro nesse caso
    var id = await dbClient.insert(tableName, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id_entidade cadastrada: $id');

    /// Retorna o id inserido/alterado
    return id;
  }

  /// Método responsável por buscar todos os registros da tabela da entidade do banco
  Future<List<T>> findAll() {
    //final dbClient = await db;
    //final list = await dbClient.rawQuery('SELECT * FROM $tableName');
    //return list.map<T>((json) => fromMap(json)).toList();
    return query('SELECT * FROM $tableName');
  }

  /// Método responsável por buscar todos os registros de entidade POR ID
  Future<T> findById(int id) async {
    //var dbClient = await db;
    //final list = await dbClient.rawQuery('SELECT * FROM $tableName where id = ?', [id]);
    //if (list.length > 0) {
    //  return fromMap(list.first);
    //}
    //return null;
    List<T> list = await query('SELECT * FROM $tableName WHERE id = ?', [id]);
    return list.length > 0 ? list.first : null;
  }

  /// Método responsável por verificar se um ID já existe no banco
  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  /// Método responsável por contar quantos registros de carros há no banco
  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(list);
  }

  /// Método responsável por apagar um registro através do ID recebido
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('DELETE FROM $tableName where id = ?', [id]);
  }

  /// Método responsável por apagar todos os registros do banco
  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM $tableName');
  }

  /// Método responsável por executar uma query
  Future<List<T>> query(String sql, [List<dynamic> arguments]) async {
    final dbClient = await db;
    // Retorna um List da consulta
    final list = await dbClient.rawQuery(sql, arguments);
    // Percorre o List
    return list.map<T>((json) => fromMap(json)).toList();
  }
}
