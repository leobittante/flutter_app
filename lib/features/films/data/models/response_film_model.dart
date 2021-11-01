import 'package:list_movie/features/films/domain/entities/dates_model.dart';
import 'package:list_movie/features/films/domain/entities/film_model.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';

class ResponseFilmModel implements ResponseFilmEntity {

  late Dates? dates;
  late int page;
  late List<FilmModel> results;
  late int totalPages;
  late int totalResults;

  ResponseFilmModel.fromJson(Map<String, dynamic> json) {
    dates = (json['dates'] != null ? Dates.fromJson(json['dates']) : null);
    page = json['page'];
    results = [];
    json['results'].forEach((v) {
      results.add(FilmModel.fromJson(v));
    });
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dates'] = dates!.toJson();
    data['page'] = page;
    data['results'] = results.map((v) => v.toJson()).toList();
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}