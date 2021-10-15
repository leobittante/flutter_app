import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:list_movie/Model/film_model.dart';
import 'package:meta/meta.dart';

part 'film_search_state.dart';

class FilmSearchCubit extends Cubit<FilmSearchState> {
  String text;
  FilmSearchCubit(this.text) : super(FilmSearchInitial()){
    _buscarFilmes(text);
  }

  //TODA CLASSE ASYNCRONA SERÁ UM RETORNO FUTURO
  void _buscarFilmes(String text) async{

    //CRIO O MAPA PARA ENVIAR COMO PARAMETRO NO POST
    Map<String, String> queryParameters =  {
      'api_key': '1019e8ecf4e06f155e24735b9f35f3ab',
      'language': 'pt-BR',
      'page': '1'
    };

    try {
      Dio dio = Dio();
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/' + text,
          queryParameters: queryParameters);

      if(res.statusCode == 200) {
        final movies = await _listFilms(res);

        //VALIDA SE A LISTA NÃO É NULA
        if(movies.isNotEmpty){
          //EMITE O ESTADO DE CONCLUSÃO E RETORNA A LISTA
          emit(FilmSearchLoaded(movies));
        } else {
          //EMITE O ESTADO DE ERRO CASO A LISTA ESTEJA VAZIA
          emit(FilmSearchError());
        }
      } else { //CASO DE ERRO AO BUSCAR OS DADOS NO SERVIDOR - RETORNO UMA EXCEPTION
        //EMITE O EVENTO DE ERRO PARA MOSTRAR AO USURIO
        emit(FilmSearchError());
        throw Exception('Falha ao consultar API');
      }

    } catch (e){
      emit(FilmSearchError());
      throw Exception('Falha ao consultar API: ' + e.toString());
    }
  }

  //TODA CLASSE ASYNCRONA SERÁ UM RETORNO FUTURO
  Future<List<FilmModel>> _listFilms(Response response) async{

      List<FilmModel> list = [];
      var listFilms = response.data['results'];
      listFilms.forEach((element) async {
        list.add(FilmModel.fromJson(element));
      });
      return list;
  }
}
