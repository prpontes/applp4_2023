import 'package:flutter/material.dart';
import 'banco.dart';
import 'usuario.dart';

class TelaLogin extends StatefulWidget {

  Banco? bd;

  TelaLogin({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  void autenticar(login, senha) async{
    if(await widget.bd!.autenticacao(Usuario(login: login, senha: senha))){
      Navigator.pushReplacementNamed(context, "/home");
    }else{
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Aviso"),
              content: Text("Usuário não encontrado!"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Ok")
                )
              ],
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerLogin,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Login"
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: controllerSenha,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Senha"
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          autenticar(controllerLogin.text, controllerSenha.text);
                        },
                        child: Text("Ok")
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
