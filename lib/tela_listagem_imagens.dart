import 'package:flutter/material.dart';
import 'provider_imagem.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'imagem.dart';
import 'imagem_detalhe.dart';

class ListagemImagens extends StatefulWidget {
  Banco? bd;

  ListagemImagens({Key? key, this.bd}) : super(key: key);

  @override
  State<ListagemImagens> createState() => _ListagemImagensState();
}

class _ListagemImagensState extends State<ListagemImagens> {

  List<Imagem> listaimg = [];
  int? favorito;

  void atualizarFavorito(context, Imagem img){
    if(img.favorito == 1){
      img.favorito = 0;
    }else{
      img.favorito = 1;
    }
    widget.bd!.atualizarImagem(img);
  }

  @override
  Widget build(BuildContext context) {

    listaimg = Provider.of<ImagemProvider>(context, listen: true).listaImagem;

    return ListView.builder(
      itemCount: listaimg.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(listaimg[index].titulo),
          subtitle: Text(listaimg[index].descricao),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(listaimg[index].url),
          ),
          trailing: IconButton(
            onPressed: (){
              setState(() {
                atualizarFavorito(context, listaimg[index]);
              });
            },
            icon: listaimg[index].favorito == 1 ? const Icon(Icons.star, color: Colors.blue,) : const Icon(Icons.star_border) ,
          ),
          onTap: ()async {
            final id = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImagemDetalhe(img: listaimg[index], bd: widget.bd,)
                )
            );
            if(id != null){
              widget.bd!.removerImagem(id);
            }
          },
        );
      },
    );
  }
}
