import 'dates_model.dart';
import 'film_model.dart';

class ResponseFilmEntity {
  late Dates? dates;
  late int page;
  late List<FilmModel> results;
  late int totalPages;
  late int totalResults;

  ResponseFilmEntity(
      { this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults});
}