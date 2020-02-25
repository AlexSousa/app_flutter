import 'package:flutter/material.dart';
import 'package:genesis2/cards/cardsPrincipal.dart';

List<Widget> listaCard = [
  HomeCard(Colors.amber[100], Colors.greenAccent, "Mensagens", "message",
      "/mensagemTela"),
  HomeCard(Colors.red[200], Colors.indigo[200], "Contatos", "contact",
      "/contatoTela"),
  HomeCard(Colors.yellow[900], Colors.pink[200], "Galeria", "gallery",
      "/galeriaTela"),
  HomeCard(Colors.grey[100], Colors.blue[300], "Perfil", "profile",
       "/perfilTela"),
  HomeCard(Colors.deepPurple[100], Colors.orange[200], "Marcações", "local",
      "/marcacaoTela"),
  HomeCard(Colors.pink[900], Colors.white, "Configurações", "settings",
      "/configuracaoTela"),
];
