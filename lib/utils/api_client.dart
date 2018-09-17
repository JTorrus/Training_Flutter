import 'dart:_http';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:training_test/model/movie.dart';

class ApiClient {
  static final _client = ApiClient._internal();
  final _http = HttpClient();

  ApiClient._internal();

  final String baseUrl = 'https://api.themoviedb.org/3';

  factory ApiClient() => _client;

  Future<dynamic> _getJson(Uri uri) async {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    return json.decode(transformedResponse);
  }

  Future<List<Movie>> fetchMovies(
      {int page: 1, String category: "popular"}) async {
    var url = Uri.https(baseUrl, '/movie/$category', {
      'api_key': "15a26b90b4fa66d7f654f28746887f70",
      'page': page.toString()
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) => data.map<Movie>((item) => Movie(item)).toList());
  }
}
