import 'package:dartz/dartz.dart';
import 'package:list_movie/features/films/core/errors/search_exception.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';

abstract class IFilmSearchRepository{
  Future<Either<SearchException, ResponseFilmEntity>> getFilmsNowPlaying(int page);
  Future<Either<SearchException, ResponseFilmEntity>> getFilmsCommon(int page);
}