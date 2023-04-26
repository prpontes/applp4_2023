import 'package:flutter/cupertino.dart';
import 'package:galeria_imagem/usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'imagem.dart';

class Banco{

  Future<Database>? database;

  Future<void> criarBanco() async{
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'bancoimagem.db'),
      onCreate: (db, version){
        return db.transaction((txn) async {
          await txn.execute('CREATE TABLE imagem(id INTEGER PRIMARY KEY, url TEXT, titulo TEXT, descricao TEXT)');
          await txn.execute('CREATE TABLE usuario(id INTEGER PRIMARY KEY, login TEXT, senha TEXT)');
          await txn.rawInsert('INSERT INTO usuario (login, senha) VALUES (?, ?)', ['paulo', '123456']);
        });
      },
      version: 1,
    );
  }

  Future<void> inserirImagem(Imagem img) async {
    final db = await database;

    db!.insert("imagem", img.toMap());
  }

  Future<List<Imagem>> listarImagens() async{
    final db = await database;

    final List<Map<String, dynamic>> map = await db!.query('imagem');

    return List.generate(map.length,
        (index) {
        return Imagem(
          id: map[index]['id'],
          url: map[index]['url'],
          titulo: map[index]['titulo'],
          descricao: map[index]['descricao'],
        );
      }
    );
  }

  Future<void> removerImagem(int id) async {
    final db = await database;

    await db!.delete("imagem", where: "id = ?", whereArgs: [id]);
  }

  Future<void> atualizarImagem(Imagem img) async{
    final db = await database;

    await db!.update("imagem",
      img.toMap(),
      where: 'id = ?',
      whereArgs: [img.id]
    );
  }
  
  Future<Imagem> obterImagem(int id) async {
    final db = await database;
    
    final List<Map<String, dynamic>> maps = await db!.query("imagem", where: "id = ?", whereArgs: [id]);

    Imagem? img;
    if(maps.isNotEmpty){
      img = Imagem(
        id: maps.first['id'],
        url: maps.first['url'],
        titulo: maps.first['titulo'],
        descricao: maps.first['descricao']
      );
    }
    return img!;
  }

  Future<bool> autenticacao(Usuario usr) async{

    final db = await database;

    List<Map<String, Object?>> map = await db!.query("usuario", where: "login = ? and senha = ?", whereArgs: [usr.login, usr.senha]);

    if(map.isNotEmpty) {
      return true;
    }else {
      return false;
    }
  }
}