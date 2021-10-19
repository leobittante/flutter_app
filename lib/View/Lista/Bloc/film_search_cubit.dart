import 'package:bloc/bloc.dart';
import 'package:list_movie/View/Lista/Repository/search_film_repository.dart';
import 'package:meta/meta.dart';

part 'film_search_state.dart';

class FilmSearchCubit extends Cubit<FilmSearchState> {
  List<String> textEndpoint;
  FilmSearchCubit(this.textEndpoint) : super(FilmSearchInitial()){
    _buscarFilmes(textEndpoint);
  }

  //TODA CLASSE ASYNCRONA SERÁ UM RETORNO FUTURO
  _buscarFilmes(List<String> textEndpoint) async{
    try {
      List objFilms = [];
      SearchFilmRepository searchFilmRepository = SearchFilmRepository();

      for(int i = 0; i < textEndpoint.length; i++){
        final listFilms = await searchFilmRepository.searchRepository(textEndpoint[i]);
        if(searchFilmRepository.validationList(listFilms)){
          objFilms.add(listFilms);
        }
      }
      //VALIDO SE A LISTA TEM O MESMO TAMANHO QUE A QUANTIDADE DE ENDPOINTS
      if(objFilms.length == textEndpoint.length){
        //EMITE O ESTADO DE CONCLUSÃO E RETORNA A LISTA
        emit(FilmSearchLoaded(objFilms));
      } else {
        emit(FilmSearchError());
      }
    } catch (e){
      emit(FilmSearchError());
      throw Exception('Falha ao consultar API: ' + e.toString());
    }
  }
}
