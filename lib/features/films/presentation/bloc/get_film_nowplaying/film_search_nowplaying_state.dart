part of 'film_search_nowplaying_cubit.dart';

@immutable
abstract class FilmSearchNowPlayingState {}

//CLASSE DE ESTADOS DO CUBIT

//ESTADO INICIAL
class FilmSearchInitial extends FilmSearchNowPlayingState {}

//ESTADO COMPLETO
class FilmSearchLoaded extends FilmSearchNowPlayingState {

  final ResponseFilmEntity responseFilmEntity;
  FilmSearchLoaded(this.responseFilmEntity);

  Future<Object> get props async => [responseFilmEntity];
}

//ESTADO DE ERRO
class FilmSearchError extends FilmSearchNowPlayingState {}