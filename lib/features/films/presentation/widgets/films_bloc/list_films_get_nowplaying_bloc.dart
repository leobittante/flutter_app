import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_movie/features/films/presentation/bloc/get_film_nowplaying/film_search_nowplaying_cubit.dart';
import 'package:list_movie/features/films/presentation/widgets/shimmer/home_shimmer.dart';
import '../films_list.dart';
import 'alert_dialog_error_film.dart';

class ListFilmsGetNowPlayingBloc extends StatelessWidget {
  const ListFilmsGetNowPlayingBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        height: 450,
        child: BlocBuilder<FilmSearchNowPlayingCubit, FilmSearchNowPlayingState>(
            builder: (context, state) {
              //SE O ESTADO FOR INICIAL EXIBE UM LOADING
              if (state is FilmSearchInitial) {
                return const HomeShimmer();
              } //SE CARREGOU COMPLETAMENTE LISTA OS FILMES

              else if (state is FilmSearchLoaded) {
                //RETORNA NOSSA LISTA DE FLMES PARA USARMOS NA LIST VIEW
                final responseFilmEntity = state.responseFilmEntity;
                return Column(
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
                        child: listFilms(
                            responseFilmEntity), //RETORNA A PRIMEIRA LISTA DE FILMES
                      ),

                    ]);
              } //EM CASO DE ERRO EXIBE UM ALERTA
              else {
                return const ErrorFilmAlertDialog();
              }
            }
        )
    );
  }
}
