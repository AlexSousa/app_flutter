import 'package:flutter/material.dart';
import 'package:genesis2/model/Conversa.dart';

class MensagemScreen extends StatefulWidget {
  @override
  _MensagemScreenState createState() => _MensagemScreenState();
}

class _MensagemScreenState extends State<MensagemScreen> {
  List<Conversa> listaConversas = [
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
    Conversa("Amanda", "Oi meu amor",
        "https://firebasestorage.googleapis.com/v0/b/projeto-genesis-a1828.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=53e5ca1e-57d6-4663-9c64-d1bc0abd2828"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: listaConversas.length,
          itemBuilder: (context, indice) {
            Conversa conversa = listaConversas[indice];
            return ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(conversa.caminhoFoto),
                ),
                title: Text(
                  conversa.nome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(conversa.mensagem,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )));
          },
        ),
      ),
    );
  }
}
