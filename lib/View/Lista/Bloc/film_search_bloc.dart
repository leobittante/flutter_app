import 'dart:async'; //TAREFAS ASSINCRONAS
import 'package:dio/dio.dart';
import 'package:list_movie/Model/film_model.dart';

class FilmSearch {

  final StreamController<String> _streamController = StreamController<String>();
  Sink get input => _streamController.sink;
  Stream<List<FilmModel>> get output => _streamController.stream.asyncMap((text) => buscarFilmes(text));

  //TODA CLASSE ASYNCRONA SERÁ UM RETORNO FUTURO
  Future<List<FilmModel>> buscarFilmes(String text) async{

    //CRIO O MAPA PARA ENVIAR COMO PARAMETRO NO POST
    Map<String, String> queryParameters =  {
      'api_key': '1019e8ecf4e06f155e24735b9f35f3ab',
      'language': 'pt-BR',
      'page': '1'
    };

    Dio dio = Dio();
    Response res = await dio.get('https://api.themoviedb.org/3/movie/' + text, queryParameters: queryParameters);
    if(res.statusCode == 200) {
      List<FilmModel> lista = [];
      var listFilms = res.data['results'];
      listFilms.forEach((element) async{
        lista.add(FilmModel.fromJson(element));
      });

      return lista;
    } else { //CASO DE ERRO AO BUSCAR OS DADOS NO SERVIDOR - RETORNO UMA EXCEPTION
      throw Exception('Falha ao consultar API');
    }
  }
}