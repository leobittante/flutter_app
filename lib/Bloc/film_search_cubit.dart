import 'package:bloc/bloc.dart';
import 'package:list_movie/Repositories/search_film_repository.dart';
import 'package:meta/meta.dart';

part 'film_search_state.dart';

class FilmSearchCubit extends Cubit<FilmSearchState> {
  List<String> textEndpoint;
  final searchFilmRepository = SearchFilmRepository();

  FilmSearchCubit(this.textEndpoint) : super(FilmSearchInitial()){
    _buscarFilmes(textEndpoint);
  }

  //TODA CLASSE ASYNCRONA SERÁ UM RETORNO FUTURO
  _buscarFilmes(List<String> textEndpoint) async{
    try {
      //CRIO UMA LISTA PARA RECEBER AS LISTAS DE FILMES
      List objFilms = [];

      for(int i = 0; i < textEndpoint.length; i++){
        final listFilms = await searchFilmRepository.fetchFilms(textEndpoint[i]);
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
