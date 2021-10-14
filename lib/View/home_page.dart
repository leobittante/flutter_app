import 'package:flutter/material.dart';
import 'dart:core'; //SUBSTRING
import 'Lista/lista_filmes.dart';

//CLASSE PRINCIPAL - MYAPP
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Lista de Filmes')
            ),
            body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   const [
                    Padding(padding: EdgeInsets.all(8),
                        child: Text("Os Mais Populares", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                    ),
                    SizedBox(
                      height: 420,
                      child: listaFilmes('now_playing'),
                    ),
                    Padding(padding: EdgeInsets.all(8),
                        child: Text("Nos Cinemas", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                    ),
                    SizedBox(
                      height: 400,
                      child: listaFilmes('popular'),
                    )
                  ],
                )
            )
        )
    );
  }
}