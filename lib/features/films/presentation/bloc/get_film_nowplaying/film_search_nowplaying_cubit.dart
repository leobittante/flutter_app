import 'package:bloc/bloc.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';
import 'package:list_movie/features/films/domain/usecases/get_film_now_playing.dart';
import 'package:meta/meta.dart';
part 'film_search_nowplaying_state.dart';

class FilmSearchNowPlayingCubit extends Cubit<FilmSearchNowPlayingState> {

  GetFilmNowPlayingUseCase getFilmNowPlayingUseCase;

  FilmSearchNowPlayingCubit(this.getFilmNowPlayingUseCase) : super(FilmSearchInitial()){
    _searchNowPlaying(1);
  }
  _searchNowPlaying(int page) async{
    try {
      //RETORNAMOS AS LISTAS DE FILMES PARA E ADICIONAMOS NA LISTA DE RESULTADOS
      final listFilmNowPlaying = await getFilmNowPlayingUseCase(Params(page: page));
      listFilmNowPlaying.fold(
              (searchFailure) => emit(FilmSearchError()),
              (listFilm) => emit(FilmSearchLoaded(listFilm)));
    } catch (e){
      emit(FilmSearchError());
      throw Exception('Falha ao consultar API: ' + e.toString());
    }
  }
}

class Params {
  final int page;
  const Params({required this.page});
}
