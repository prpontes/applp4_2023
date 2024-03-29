import 'package:flutter/material.dart';

import 'banco.dart';
import 'imagem.dart';

class ImagemDetalhe extends StatefulWidget {

  Imagem? img;
  Banco? bd;

  ImagemDetalhe({Key? key, this.img, this.bd}) : super(key: key);

  @override
  State<ImagemDetalhe> createState() => _ImagemDetalheState();
}

class _ImagemDetalheState extends State<ImagemDetalhe> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerUrl = TextEditingController();
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();

  formEditarImagem(context){
    _controllerUrl.text = widget.img!.url;
    _controllerTitulo.text = widget.img!.titulo;
    _controllerDescricao.text = widget.img!.descricao;

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Editar imagem"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerUrl,
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                              hintText: "Insira uma url",
                              labelText: "Url"
                          ),
                          validator: (url){
                            if(url == null || url.isEmpty){
                              return "digite uma url";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerTitulo,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira um título",
                              labelText: "Título"
                          ),
                          validator: (titulo){
                            if(titulo == null || titulo.isEmpty){
                              return "Insira um título";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerDescricao,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira uma descrição",
                              labelText: "Descrição"
                          ),
                          validator: (desc){
                            if(desc == null || desc.isEmpty){
                              return "Insira um título";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      widget.bd!.atualizarImagem(
                          Imagem(
                              id: widget.img!.id,
                              url: _controllerUrl.text,
                              titulo: _controllerTitulo.text,
                              descricao: _controllerDescricao.text
                          )
                      );
                      Navigator.pop(context);
                    }
                    widget.img = await widget.bd!.obterImagem(widget.img!.id);
                    setState(() {
                      widget.img;
                    });
                  },
                  child: const Text("Editar")
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhe da imagem"),
        actions: [
          IconButton(
              onPressed: (){
                formEditarImagem(context);
              },
              icon: const Icon(Icons.edit)
          ),
          IconButton(
              onPressed: (){
                Navigator.pop(context, widget.img!.id);
              },
              icon: const Icon(Icons.delete)
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Url", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.img!.url, style: const TextStyle(fontSize: 20)),
          ),
          ListTile(
            title: const Text("Titulo", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.img!.titulo, style: const TextStyle(fontSize: 20)),
          ),
          ListTile(
            title: const Text("Descrição", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.img!.descricao, style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
