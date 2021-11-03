import 'package:flutter_test/flutter_test.dart';
import 'package:list_movie/features/films/domain/repositories/film_search_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_film_common_test.mocks.dart';

@GenerateMocks([IFilmSearchRepository])
void main(){

MockIFilmSearchRepository mockitoFilmSearchRepository;

setUp(() => mockitoFilmSearchRepository = MockIFilmSearchRepository());

test('should return a list of movies from the repository', () async => {

});



}