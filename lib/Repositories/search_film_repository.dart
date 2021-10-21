import 'package:dio/dio.dart';
import 'package:list_movie/Model/film_model.dart';

class SearchFilmRepository {

  //FAZ A BUSCA NO SERVIDOR
  Future<List> fetchFilms(String textEndpoint) async {

    Dio dio = Dio();

    //CRIO O MAPA PARA ENVIAR COMO PARAMETRO NO POST
    Map<String, String> queryParameters =  {
      'api_key': '1019e8ecf4e06f155e24735b9f35f3ab',
      'language': 'pt-BR',
      'page': '1'
    };

    Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/' + textEndpoint,
        queryParameters: queryParameters);

    if(response.statusCode == 200) {
      return _listFilms(response);
    } else { //CASO DE ERRO AO BUSCAR OS DADOS NO SERVIDOR - RETORNO UMA EXCEPTION
      throw Exception('Falha ao consultar API');
    }
  }

  //RETORNA UMA LISTA DE FILMES
  List<FilmModel> _listFilms(Response response) {
    List<FilmModel> list = [];
    var listFilms = response.data['results'];
    listFilms.forEach((element) async {
      list.add(FilmModel.fromJson(element));
    });
    return list;
  }

  //VALIDA SE A LISTA ESTA VAZIA
  bool validationList(List list){
    if(list.isNotEmpty){
      return true;
    } return false;
  }
}