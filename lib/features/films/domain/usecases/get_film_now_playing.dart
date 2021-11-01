import 'package:dartz/dartz.dart';
import 'package:list_movie/features/films/core/errors/search_exception.dart';
import 'package:list_movie/features/films/core/usecases/usecases.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';
import 'package:list_movie/features/films/domain/repositories/film_search_repository.dart';
import 'package:list_movie/features/films/presentation/bloc/get_film_nowplaying/film_search_nowplaying_cubit.dart';

class GetFilmNowPlayingUseCase extends UseCase<ResponseFilmEntity, Params> {

  final IFilmSearchRepository filmSearchRepository;
  GetFilmNowPlayingUseCase(this.filmSearchRepository);

  @override
  Future<Either<SearchException, ResponseFilmEntity>> call(params) async{
    return await filmSearchRepository.getFilmsNowPlaying(params.page);
  }
}
