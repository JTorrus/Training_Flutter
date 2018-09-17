import 'dart:async';

import 'package:training_test/model/movie.dart';
import 'package:training_test/utils/api_client.dart';

class RequestProvider {
  RequestProvider();

  ApiClient _apiClient = ApiClient();

  Future<List<Movie>> provideMedia(String category, {int page: 1}) {
    return _apiClient.fetchMovies(category: category, page: page);
  }
}