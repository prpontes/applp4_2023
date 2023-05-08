import 'package:flutter/material.dart';
import 'package:galeria_imagem/provider_imagem.dart';
import 'package:galeria_imagem/provider_usuario.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'drawer.dart';
import 'imagem.dart';
import 'imagem_detalhe.dart';

class TelaImagem extends StatefulWidget {
  Banco? bd;

  TelaImagem({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaImagem> createState() => _TelaImagemState();
}

class _TelaImagemState extends State<TelaImagem> {

  List<Imagem> limg = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerUrl = TextEditingController();
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  int cont = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarImagens();
  }

  Future<void> carregarImagens() async {
    limg = await widget.bd!.listarImagens(Provider.of<UsuarioProvider>(context, listen: false).usr!.id!);
    carregarProvider();
    setState(() {
      limg;
    });
  }

  void carregarProvider(){
    Provider.of<ImagemProvider>(context, listen: false).listaImagem = limg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () async {
                  final id = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImagemDetalhe(img: limg[cont], bd: widget.bd,)
                      )
                  );
                  if(id != null){
                    widget.bd!.removerImagem(id);
                  }
                  carregarImagens();
                },
                child: limg.isEmpty ? Text("carregando") : Image.network(limg[cont].url)
            ),
            limg.isEmpty ? Text("carregando") : Text(limg[cont].titulo,
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      setState((){
                        if(cont > 0) {
                          cont = cont - 1;
                        }
                      });
                    },
                    child: Text("<<")
                ),
                SizedBox(width: 25,),
                ElevatedButton(
                    onPressed: (){
                      setState((){
                        if(cont < limg.length-1) {
                          cont = cont + 1;
                        }
                      });
                    },
                    child: Text(">>")
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (contexto){
                return AlertDialog(
                  title: Text("Inserir nova imagem"),
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
                                decoration: InputDecoration(
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
                                decoration: InputDecoration(
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
                                decoration: InputDecoration(
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
                            await widget.bd!.inserirImagemUsuario(
                                Imagem(
                                    url:
                                    _controllerUrl.text,
                                    titulo:
                                    _controllerTitulo.text,
                                    descricao:
                                    _controllerDescricao.text
                                ),
                                Provider.of<UsuarioProvider>(context, listen: false).usr!.id!
                            );
                            await carregarImagens();
                            _controllerUrl.clear();
                            _controllerTitulo.clear();
                            _controllerDescricao.clear();

                            Navigator.pop(context);
                          }
                        },
                        child: Text("Salvar")
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
