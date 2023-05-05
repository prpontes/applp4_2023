import 'package:flutter/material.dart';
import 'package:galeria_imagem/banco.dart';
import 'package:galeria_imagem/drawer.dart';
import 'package:galeria_imagem/usuario.dart';

class TelaUsuario extends StatefulWidget {

  Banco? bd;

  TelaUsuario({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {

  List<Usuario> listaUser = [];

  Future<void> listarUsuarios() async {
    listaUser = await widget.bd!.listarUsuarios();
    setState(() {
      listaUser;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listarUsuarios();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Usuário"),
      ),
      drawer: DrawerMenu(),
      body: ListView.builder(
          itemCount: listaUser.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(listaUser[index].avatar!)),
              title: Text(listaUser[index].nome!),
              subtitle: Text(listaUser[index].email!),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.edit,
                          color: Colors.blue,
                        )
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.delete,
                          color: Colors.red,
                        )
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
