import 'package:flutter/material.dart';
import 'package:galeria_imagem/tela_login.dart';
import 'package:galeria_imagem/tela_usuario.dart';
import 'home.dart';
import 'banco.dart';
import 'imagem.dart';

void main() async{

  Banco bd = Banco();
  await bd.criarBanco();
  print("Banco criado!!");
  await bd.inserirImagem(Imagem(url: "http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png", titulo: "Imagem 1", descricao: "Descricao imagem 1"));
  await bd.inserirImagem(Imagem(url: "https://www.pontotel.com.br/wp-content/uploads/2022/05/imagem-corporativa.jpg", titulo: "Imagem 2", descricao: "Descrição imagem 2"));
  await bd.inserirImagem(Imagem(url: "https://mundoconectado.com.br/uploads/chamadas/capa_145.jpg", titulo: "Imagem 3", descricao: "Descrição imagem 3"));

  runApp(MaterialApp(
    //home: TelaLogin(bd: bd,),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/" : (context) => TelaLogin(bd: bd,),
      "/home" : (context) => Home(bd: bd,),
      "/telausuario": (context) => TelaUsuario(),
    },
  ));
}


