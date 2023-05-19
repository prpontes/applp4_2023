import 'package:flutter/material.dart';
import 'provider_imagem.dart';
import 'provider_usuario.dart';
import 'tela_imagem.dart';
import 'tela_login.dart';
import 'tela_usuario.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'banco.dart';
import 'imagem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Banco bd = Banco();
  await bd.criarBanco();
  print("Banco criado!!");
  await bd.inserirImagemUsuario(Imagem(url: "http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png", titulo: "Imagem 1", descricao: "Descricao imagem 1"), 1);
  await bd.inserirImagemUsuario(Imagem(url: "https://www.pontotel.com.br/wp-content/uploads/2022/05/imagem-corporativa.jpg", titulo: "Imagem 2", descricao: "Descrição imagem 2"), 1);
  await bd.inserirImagemUsuario(Imagem(url: "https://mundoconectado.com.br/uploads/chamadas/capa_145.jpg", titulo: "Imagem 3", descricao: "Descrição imagem 3"), 1);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ChangeNotifierProvider(create: (_) => ImagemProvider()),
    ],
    child: MaterialApp(
      //home: TelaLogin(bd: bd,),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => TelaLogin(bd: bd,),
        "/home" : (context) => Home(bd: bd,),
        "/telausuario" : (context) => TelaUsuario(bd: bd,),
        "/telaimagem" : (context) =>TelaImagem(bd: bd,),
      },
    ),
  ));
}