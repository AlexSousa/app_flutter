import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ConfiguracaoScreen extends StatefulWidget {
  @override
  _ConfiguracaoScreenState createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  String _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;

  Future _recuperarImagem(String origemImagem) async {
    File imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.gallery);

        break;
    }
    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo =
        pastaRaiz.child("perfil").child(_idUsuarioLogado + ".jpg");
    StorageUploadTask task = arquivo.putFile(_imagem);

    task.events.listen((StorageTaskEvent storageEvent) {
      if (storageEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (storageEvent.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recuprerarUrlImagem(snapshot);
    });
  }

  Future _recuprerarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore(url);

    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _atualizarNomeFirestore() {
    String nome = _controllerNome.text;
    Firestore db = Firestore.instance;

    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData({"usuario": nome});
  }

  _atualizarUrlImagemFirestore(String url) {
    Firestore db = Firestore.instance;

    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData({"urlImagem": url});
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("usuarios").document(_idUsuarioLogado).get();
    Map<String, dynamic> dados = snapshot.data;
    setState(() {
      _controllerNome.text = dados["usuario"];

      if (dados["urlImagem"] != null) {
        _urlImagemRecuperada = dados["urlImagem"];
      }
    });
  }

  @override
  void initState() {
    _recuperarDadosUsuario();
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
                  0.2,
                  0.3,
                  0.5,
                  0.8,
                ],
                    colors: [
                  Colors.greenAccent,
                  Colors.white,
                  Colors.amber,
                  Colors.red
                ])),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _subindoImagem ? CircularProgressIndicator() : Container(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        backgroundImage: _urlImagemRecuperada != null
                            ? NetworkImage(_urlImagemRecuperada)
                            : null,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () {
                              _recuperarImagem("camera");
                            },
                            child:
                                Text("Câmera", style: TextStyle(fontSize: 20))),
                        FlatButton(
                            onPressed: () {
                              _recuperarImagem("galeria");
                            },
                            child: Text("Galeria",
                                style: TextStyle(fontSize: 20))),
                      ],
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _controllerNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple, fontSize: 20),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          icon: Icon(Icons.person),
                          hintText: "Alterar nome do perfil",
                          hintStyle: TextStyle(fontSize: 20),
                          labelText: "Nome",
                          labelStyle:
                              TextStyle(fontSize: 24, color: Colors.blue[600])),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          _atualizarNomeFirestore();
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
