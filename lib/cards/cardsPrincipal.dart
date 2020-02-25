import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genesis2/style/estilo.dart';

class HomeCard extends StatelessWidget {
  Color cor1;
  Color cor2;
  String texto;
  String imagemLocal;
  String rota;
  HomeCard(this.cor1, this.cor2, this.texto, this.imagemLocal, this.rota);
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '$rota');
      },
      child: Card(
        child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("img/$imagemLocal.png"),
                  SizedBox(height: 15),
                  Text(
                    texto,
                    style: estilo,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [cor1, cor2]))),
      ),
    );
  }
}
