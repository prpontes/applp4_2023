import 'package:flutter/material.dart';
import 'package:galeria_imagem/provider_usuario.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'imagem.dart';
import 'provider_imagem.dart';

class FavoritoImagens extends StatefulWidget {
  Banco? bd;

  FavoritoImagens({Key? key, this.bd}) : super(key: key);

  @override
  State<FavoritoImagens> createState() => _FavoritoImagensState();
}

class _FavoritoImagensState extends State<FavoritoImagens> {
  List<Imagem> listaimg = [];

  Future<void> carregarImagensFavoritos() async {
    listaimg = await widget.bd!.listarImagensFavoritos(Provider.of<UsuarioProvider>(context, listen: false).usuario.id!);
    setState(() {
      listaimg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarImagensFavoritos();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: listaimg.length,
      itemBuilder: (context, index){
          return ListTile(
            title: Text(listaimg[index].titulo),
            subtitle: Text(listaimg[index].descricao),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listaimg[index].url),
            ),
          );
        },
    );
  }
}
