import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_movie/features/films/presentation/bloc/get_film_common/film_search_common_cubit.dart';
import 'package:list_movie/features/films/presentation/bloc/get_film_nowplaying/film_search_nowplaying_cubit.dart';
import 'package:list_movie/features/films/presentation/widgets/films_bloc/list_films_get_common_bloc.dart';
import 'package:list_movie/features/films/presentation/widgets/films_bloc/list_films_get_nowplaying_bloc.dart';
import 'dart:core';

import 'package:list_movie/injection_locator.dart'; //SUBSTRING

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
          appBar: AppBar(
              leading: const Icon(Icons.account_circle_rounded, size: 35),
              title: const Text('FilmFlix'),
              centerTitle: true),

          body: MultiBlocProvider(
                  providers: [
                    BlocProvider<FilmSearchNowPlayingCubit>(
                      create: (context) => sl.get<FilmSearchNowPlayingCubit>()
                    ),
                    BlocProvider<FilmSearchCommonCubit>(
                        create: (context) => sl.get<FilmSearchCommonCubit>()
                    )
                  ],
              child:  SingleChildScrollView(
                child: Column(
                  children: const [
                    ListFilmsGetNowPlayingBloc(),
                    ListFilmsGetCommonBloc()
                  ],
                )
              )
              )
          )
        );
  }
}
