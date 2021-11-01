part of 'film_search_common_cubit.dart';

@immutable
abstract class FilmSearchCommonState {}

//CLASSE DE ESTADOS DO CUBIT

//ESTADO INICIAL
class FilmSearchInitial extends FilmSearchCommonState {}

//ESTADO COMPLETO
class FilmSearchLoaded extends FilmSearchCommonState {

  final ResponseFilmEntity responseFilmEntity;
  FilmSearchLoaded(this.responseFilmEntity);

  Future<Object> get props async => [responseFilmEntity];
}

//ESTADO DE ERRO
class FilmSearchError extends FilmSearchCommonState {}