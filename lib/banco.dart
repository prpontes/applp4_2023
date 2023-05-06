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
          await txn.execute('CREATE TABLE imagem(id INTEGER PRIMARY KEY, url TEXT, titulo TEXT, descricao TEXT, id_usuario INTEGER)');
          await txn.execute('CREATE TABLE usuario(id INTEGER PRIMARY KEY, nome TEXT, email TEXT, avatar TEXT, login TEXT, senha TEXT)');
          await txn.rawInsert('INSERT INTO usuario (nome, email, login, senha, avatar) VALUES (?, ?, ?, ?, ?)', ['Paulo Ricardo', 'paulo.pontes@ifto.edu.br', 'paulo', '123456', 'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg']);
        });
      },
      version: 1,
    );
  }

  Future<void> inserirImagem(Imagem img) async {
    final db = await database;

    db!.insert("imagem", img.toMap());
  }

  Future<void> inserirImagemUsuario(Imagem img, int id_usuario) async {
    final db = await database;

    db!.rawInsert('INSERT INTO imagem (url, titulo, descricao, id_usuario) VALUES (?, ?, ?, ?)', [img.url, img.titulo, img.descricao, id_usuario]);
  }

  Future<List<Imagem>> listarImagens(int id_usuario) async{
    final db = await database;

    final List<Map<String, dynamic>> map = await db!.query('imagem', where: 'id_usuario = ?', whereArgs: [id_usuario]);

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

  Future<Usuario?> autenticacao(login, senha) async{

    final db = await database;

    List<Map<String, dynamic>> map = await db!.query("usuario", where: "login = ? and senha = ?", whereArgs: [login, senha]);

    if(map.isNotEmpty) {
      return Usuario(
        id: map[0]['id'],
        nome: map[0]['nome'],
        email: map[0]['email'],
        login: map[0]['login'],
        senha: map[0]['senha'],
        avatar: map[0]['avatar'],
      );
    }else {
      return null;
    }
  }

  Future<List<Usuario>> listarUsuarios() async{
    final db = await database;
    final List<Map<String, dynamic>> map = await db!.query("usuario");

    return List.generate(map.length,
      (index) {
        return Usuario(
          id: map[index]['id'],
          nome: map[index]['nome'],
          email: map[index]['email'],
          login: map[index]['login'],
          senha: map[index]['senha'],
          avatar: map[index]['avatar'],
        );
      }
    );
  }

  Future<void> inserirUsuario(Usuario usr) async {
    final db = await database;

    db!.insert("usuario", usr.toMap());
  }
}