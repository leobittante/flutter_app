import 'package:bloc/bloc.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';
import 'package:list_movie/features/films/domain/usecases/get_film_common.dart';
import 'package:meta/meta.dart';
part 'film_search_common_state.dart';

class FilmSearchCommonCubit extends Cubit<FilmSearchCommonState> {

  GetFilmCommonUseCase getFilmCommonUseCase;

  FilmSearchCommonCubit(this.getFilmCommonUseCase) : super(FilmSearchInitial()){
    _searchCommon(1);
  }
  _searchCommon(int page) async{
    try {
      //RETORNAMOS AS LISTAS DE FILMES PARA E ADICIONAMOS NA LISTA DE RESULTADOS
      final listFilmCommon = await getFilmCommonUseCase(Params(page: page));
      listFilmCommon.fold(
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
