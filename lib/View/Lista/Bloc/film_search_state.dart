part of 'film_search_cubit.dart';

@immutable
abstract class FilmSearchState {}

//CLASSE DE ESTADOS DO CUBIT

//ESTADO INICIAL
class FilmSearchInitial extends FilmSearchState {}

//ESTADO COMPLETO
class FilmSearchLoaded extends FilmSearchState {

  final List<FilmModel> movies;
  FilmSearchLoaded(this.movies);

  Future<List<Object>> get props async => [movies];
}

//ESTADO DE ERRO
class FilmSearchError extends FilmSearchState {}