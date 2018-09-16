import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Movie> fetchMovie() async {
  final response = await http.get('https://api.themoviedb.org/3/movie/popular?api_key=15a26b90b4fa66d7f654f28746887f70&language=es-ES');

  if (response.statusCode == 200) {
    return Movie.fromJson(json.decode(response.body));
  } else {
    throw Exception('Request failed');
  }
}

class Movie {
  final int id;
  final double voteAverage;
  final String title;
  final List<int> genreIds;
  final String overview;
  final String releaseDate;

  Movie({this.id, this.voteAverage, this.title, this.genreIds, this.overview,
      this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      voteAverage: json['voteAverage'],
      title: json['title'],
      genreIds: json['genreIds'],
      overview: json['overview'],
      releaseDate: json['releaseDate'],
    );
  }
}