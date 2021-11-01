import 'package:dio/dio.dart';
import 'package:list_movie/features/films/data/models/response_film_model.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';

abstract class IFilmSearchDataSource {
  Future<ResponseFilmModel> getFilmNowPlaying(int page);
  Future<ResponseFilmModel> getFilmCommon(int page);
}

class FilmSearchDataSourceImpl implements IFilmSearchDataSource{

  final Dio dio = Dio();
  late Response response;
  final String endpoint = "https://api.themoviedb.org/3/movie/";

  final Map<String, String> queryParameters =  {
    'api_key': '1019e8ecf4e06f155e24735b9f35f3ab',
    'language': 'pt-BR'
  };

  @override
  Future<ResponseFilmModel> getFilmCommon(int page) async{
    queryParameters.addAll({'page' : page.toString()});

    response = await dio.get(endpoint + 'popular', queryParameters: queryParameters);

    if(response.statusCode == 200) {
      final ResponseFilmModel listResults = ResponseFilmModel.fromJson(response.data);
      return listResults;
    } else {
      throw Exception('Falha ao consultar API');
    }
  }

  @override
  Future<ResponseFilmModel> getFilmNowPlaying(int page) async{
    queryParameters.addAll({'page' : page.toString()});

    response = await dio.get(endpoint + 'now_playing', queryParameters: queryParameters);

    if(response.statusCode == 200) {
      final ResponseFilmModel listResults = ResponseFilmModel.fromJson(response.data);
      return listResults;
    } else {
      throw Exception('Falha ao consultar API');
    }
  }
}