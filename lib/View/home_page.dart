import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_movie/Bloc/film_search_cubit.dart';
import 'dart:core'; //SUBSTRING
import 'Lista/lista_filmes.dart';

//CLASSE PRINCIPAL - MYAPP
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(leading: const Icon(Icons.account_circle_rounded, size: 35), title: const Text('FilmFlix'), centerTitle: true),
            body: BlocProvider<FilmSearchCubit>(
                create: (context) =>
                    FilmSearchCubit(['now_playing', 'popular']), //ENCAMINHA UMA LISTA DE ENDPOINTS
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: BlocBuilder<FilmSearchCubit, FilmSearchState>(
                      builder: (context, state) {
                    //SE O ESTADO FOR INICIAL EXIBE UM LOADING
                    if (state is FilmSearchInitial) {
                      return const Center( //EXIBIR LOADING
                          child:  CircularProgressIndicator(
                          strokeWidth: 5,
                        )
                      );
                    } //SE CARREGOU COMPLETAMENTE LISTA OS FILMES
                    else if (state is FilmSearchLoaded) {
                      //RETORNA NOSSA LISTA DE FLMES PARA USARMOS NA LIST VIEW
                      final movies = state.movies;
                      return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("Os Mais Populares",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 400,
                              child: listFilms(movies[0]), //RETORNA A PRIMEIRA LISTA DE FILMES
                            ),
                            const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("Nos Cinemas",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 400,
                              child: listFilms(movies[1]), // RETORNA A SEGUNDA LISTA DE FILMES
                            )
                          ])
                      );
                    } //EM CASO DE ERRO EXIBE UM ALERTA
                    else {
                      return AlertDialog(
                        title: const Text('Erro ao Listar os Filmes'),
                        content: const Text('Não foi possível listar os flmes. Por favor, tente novamente!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ),
    ));
  }
}
