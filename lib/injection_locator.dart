import 'package:get_it/get_it.dart';
import 'package:list_movie/features/films/domain/repositories/film_search_repository.dart';
import 'package:list_movie/features/films/domain/usecases/get_film_now_playing.dart';
import 'package:list_movie/features/films/presentation/bloc/get_film_common/film_search_common_cubit.dart';
import 'package:list_movie/features/films/presentation/bloc/get_film_nowplaying/film_search_nowplaying_cubit.dart';
import 'features/films/data/datasources/film_search_datasource.dart';
import 'features/films/data/repositories/film_search_repository_impl.dart';
import 'features/films/domain/usecases/get_film_common.dart';

 final sl = GetIt.instance;

void init(){

  //BLOC
  sl.registerFactory(() => FilmSearchCommonCubit(sl()));
  sl.registerFactory(() => FilmSearchNowPlayingCubit(sl()));

  //USE CASE
  sl.registerLazySingleton(() => GetFilmNowPlayingUseCase(sl()));
  sl.registerLazySingleton(() => GetFilmCommonUseCase(sl()));

  //REPOSITORY
  sl.registerLazySingleton<IFilmSearchRepository>(() => FilmSearchRepositoryImpl(sl()));

  //DATASOURCE
  sl.registerLazySingleton<IFilmSearchDataSource>(() => FilmSearchDataSourceImpl());
}