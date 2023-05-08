import 'package:flutter/material.dart';
import 'package:galeria_imagem/drawer.dart';
import 'package:galeria_imagem/tela_grid_imagens.dart';
import 'package:galeria_imagem/tela_imagem.dart';
import 'package:galeria_imagem/tela_listagem_imagens.dart';

import 'banco.dart';

class Home extends StatefulWidget {
  Banco? bd;

  Home({Key? key, this.bd}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int barraNavegacaoIndex = 0;
  var telaImagem;
  var telaListagemImagens;
  var telaGridImagens;

  List<Widget>? telas;

  @override
  Widget build(BuildContext context) {

    telaImagem = TelaImagem(bd: widget.bd,);
    telaListagemImagens = ListagemImagens(bd: widget.bd,);
    telaGridImagens = GridImagens();

    telas = [telaImagem, telaListagemImagens, telaGridImagens];

    return Scaffold(
      appBar: AppBar(
        title: Text("Imagem"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: telas!.elementAt(barraNavegacaoIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "imagem",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "listagem",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_4x4),
            label: "grid",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "configuração",
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: barraNavegacaoIndex,
        selectedItemColor: Colors.black,
        onTap: (index){
          setState(() {
            barraNavegacaoIndex = index;
          });
        },
      ),
    );
  }
}
