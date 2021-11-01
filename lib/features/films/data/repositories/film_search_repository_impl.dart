import 'package:dartz/dartz.dart';
import 'package:list_movie/features/films/core/errors/search_exception.dart';
import 'package:list_movie/features/films/data/datasources/film_search_datasource.dart';
import 'package:list_movie/features/films/data/models/response_film_model.dart';
import 'package:list_movie/features/films/domain/repositories/film_search_repository.dart';

class FilmSearchRepositoryImpl implements IFilmSearchRepository {

  final IFilmSearchDataSource filmSearchDataSource;
  FilmSearchRepositoryImpl(this.filmSearchDataSource);

  @override
  Future<Either<SearchException, ResponseFilmModel>> getFilmsCommon(int page) async {
    try{
      final ResponseFilmModel listFilm = await filmSearchDataSource.getFilmCommon(page);
      return Right(listFilm);
    } on SearchException catch (e){
      return Left(e);
    } on Exception {
      return Left(SearchException("Erro ao buscar filmes populares"));
    }
  }

  @override
  Future<Either<SearchException, ResponseFilmModel>> getFilmsNowPlaying(int page) async {
    try{
      final ResponseFilmModel listFilm = await filmSearchDataSource.getFilmNowPlaying(page);
      return Right(listFilm);
    } on SearchException catch (e){
      return Left(e);
    } on Exception {
      return Left(SearchException("Erro ao buscar filmes"));
    }
  }
}