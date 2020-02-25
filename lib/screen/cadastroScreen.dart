import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController usuarioController = TextEditingController();
  static TextEditingController senhaController = TextEditingController();
  String mensagemErro = "";
  
  Future<void> cadastrarUsuario(
      String emailUser, String senhaUSer, String usuarioUser) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String email = emailUser;
    String senha = senhaUSer;
    String usuario = usuarioUser;

    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((firebaseUser) {
      Firestore db = Firestore.instance;
      db
          .collection("usuarios")
          .document(firebaseUser.user.uid)
          .setData({"email": email, "usuario": usuario});
      Navigator.pushReplacementNamed(context, '/homeTela');
    }).catchError((erro) {
      print("erro app:" + erro.toString());
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9
                ],
                    colors: [
                  Colors.purple,
                  Colors.tealAccent,
                  Colors.lightGreen,
                  Colors.white
                ])),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              status = true;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              icon: Icon(Icons.mail),
                              hintText: "Escreva seu email",
                              hintStyle: TextStyle(fontSize: 20),
                              labelText: "E-mail",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.red)),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Preencha com seu e-mail";
                            } else if (!(value.contains("@"))) {
                              return "Coloque um e-mail Valido";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              status = true;
                            });
                          },
                          controller: usuarioController,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              icon: Icon(Icons.person),
                              hintText: "Escreva seu nome de usuario",
                              hintStyle: TextStyle(fontSize: 20),
                              labelText: "Usuario",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.red)),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Preencha com seu usuario";
                            } else if (value.length < 6) {
                              return "O seu nome de usuario é muito curto";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              status = true;
                            });
                          },
                          obscureText: true,
                          controller: senhaController,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              icon: Icon(Icons.lock),
                              hintText: "Escreva sua senha",
                              hintStyle: TextStyle(fontSize: 20),
                              labelText: "Senha",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.red)),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Preencha com sua senha";
                            } else if (value.length < 6) {
                              return "sua senha é muito curta";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RaisedButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: status ? Colors.blue : Colors.redAccent,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                cadastrarUsuario(
                                    emailController.text,
                                    senhaController.text,
                                    usuarioController.text);
                              });
                              print("clicou");
                            } else {
                              setState(() {
                                status = false;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Cadastrar",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink[900],
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(mensagemErro,
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
