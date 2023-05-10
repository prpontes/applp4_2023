import 'package:flutter/material.dart';
import 'package:galeria_imagem/imagem.dart';
import 'package:galeria_imagem/provider_imagem.dart';
import 'package:provider/provider.dart';

class GridImagens extends StatefulWidget {
  const GridImagens({Key? key}) : super(key: key);

  @override
  State<GridImagens> createState() => _GridImagensState();
}

class _GridImagensState extends State<GridImagens> {

  List<Imagem> listaimg = [];

  @override
  Widget build(BuildContext context) {
    listaimg = Provider.of<ImagemProvider>(context, listen: true).listaImagem;

    return GridView.builder(
      itemCount: listaimg.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index){
        return Container(
          padding: const EdgeInsets.all(8),
          child: Image.network(listaimg[index].url),
        );
      },
    );
  }
}
