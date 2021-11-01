import 'package:dartz/dartz.dart';
import 'package:list_movie/features/films/core/errors/search_exception.dart';

abstract class UseCase <Type, Params>{
  Future<Either<SearchException, Type>> call(Params params);
}
