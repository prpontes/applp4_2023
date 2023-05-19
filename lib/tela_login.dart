import 'package:flutter/material.dart';
import 'provider_usuario.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaLogin extends StatefulWidget {

  Banco? bd;

  TelaLogin({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  void autenticarFirebase(context, email, senha) async {
    try {
      final credencial = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: senha
      );
      var usr = Usuario(nome: credencial.user!.displayName, email: credencial.user!.email, login: credencial.user!.displayName, senha: senha);
      Provider.of<UsuarioProvider>(context, listen: false).usuario = usr;
      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      var str;
      if (e.code == 'user-not-found') {
        str = 'Nenhum usuário encontrado com esse e-mail.';
      } else if (e.code == 'wrong-password') {
        str = 'Senha errada para esse usuário.';
      }
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Aviso"),
              content: Text(str),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
      );
    }
  }

  void autenticar(context, login, senha) async{
    Usuario? usr = await widget.bd!.autenticacao(login, senha);
    if(usr != null){
      Provider.of<UsuarioProvider>(context, listen: false).usuario = usr;
      Navigator.pushReplacementNamed(context, "/home");
    }else{
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Aviso"),
              content: const Text("Usuário não encontrado!"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")
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
        padding: const EdgeInsets.all(20),
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Login"
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: controllerSenha,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Senha"
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          autenticar(context, controllerLogin.text, controllerSenha.text);
                        },
                        child: const Text("Ok")
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
