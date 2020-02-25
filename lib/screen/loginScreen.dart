import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  var mensagemErro = "";

  Future<void> logarUsuario(String emailUser, String senhaUser) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: emailUser, password: senhaUser)
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, '/homeTela');
    }).catchError((error) {
      setState(() {
        print(error.toString());
        status = false;
        mensagemErro = "Email ou senha Incorreto";
      });
    });
  }

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioAtual = await auth.currentUser();
    if (usuarioAtual != null) {
      print(usuarioAtual.email.toString());
      Navigator.pushReplacementNamed(context, '/homeTela');
    }
  }

  bool status = true;
  @override
  void initState() {
    //_recuperarDadosUsuario();
    super.initState();
  }

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
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow
                ])),
            child: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          onChanged: (text) {
                            setState(() {
                              status = true;
                              mensagemErro = "";
                            });
                          },
                          controller: emailController,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              icon: Icon(Icons.person),
                              hintText: "Escreva seu email",
                              hintStyle: TextStyle(fontSize: 20),
                              labelText: "E-mail",
                              labelStyle:
                                  TextStyle(fontSize: 22, color: Colors.red)),
                          validator: (String value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return "Email invalido";
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          onChanged: (text) {
                            setState(() {
                              status = true;
                              mensagemErro = "";
                            });
                          },
                          controller: senhaController,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              icon: Icon(Icons.lock),
                              hintText: "Escreva sua senha",
                              hintStyle: TextStyle(fontSize: 20),
                              labelText: "Senha",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.red)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Senha invalida";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: status ? Colors.blue : Colors.redAccent,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                logarUsuario(
                                    emailController.text, senhaController.text);
                              });
                            } else {
                              setState(() {
                                status = false;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Entrar",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink[900],
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/cadastroTela');
                          },
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text("Não tem conta ? Cadastre-se",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
      ),
    );
  }
}
