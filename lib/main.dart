import 'package:flutter/material.dart';
import 'package:genesis2/screen/CadastroScreen.dart';
import 'package:genesis2/screen/configuracaScreen.dart';
import 'package:genesis2/screen/contatoScreen.dart';
import 'package:genesis2/screen/galeriaScreen.dart';
import 'package:genesis2/screen/homeScreen.dart';
import 'package:genesis2/screen/loginScreen.dart';
import 'package:genesis2/screen/marcacaoScreen.dart';
import 'package:genesis2/screen/mensagemScreen.dart';
import 'package:genesis2/screen/perfilScreen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      '/homeTela': (context) => HomeScreen(),
      '/configuracaoTela': (context) => ConfiguracaoScreen(),
      '/contatoTela': (context) => ContatoScreen(),
      '/galeriaTela': (context) => GaleriaScreen(),
      '/marcacaoTela': (context) => MarcacaoScreen(),
      '/mensagemTela': (context) => MensagemScreen(),
      '/perfilTela': (context) => PerfilScreen(),
      '/cadastroTela': (context) => CadastroScreen(),
    },
    theme: ThemeData(
        primaryColor: Colors.purple[800],
        accentColor: Colors.amber,
        accentColorBrightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
  ));
}
