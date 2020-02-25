import 'package:flutter/material.dart';
import 'package:genesis2/cards/listaCards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
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
                    Colors.yellow,
                    Colors.red,
                    Colors.indigo,
                    Colors.teal
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: GridView.count(crossAxisCount: 2, children: listaCard),
            )
          ],
        ),
      ),
    );
  }
}
