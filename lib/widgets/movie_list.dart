import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_test/model/movie.dart';
import 'package:http/http.dart' as http;


class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List movies;

  Future<Movie> getMovies() async {
    final response = await http.get('https://api.themoviedb.org/3/movie/popular?api_key=15a26b90b4fa66d7f654f28746887f70&language=es-ES');

    if (response.statusCode == 200) {
      movies = json.decode(response.body);
    } else {
      throw Exception('Request failed');
    }
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {

  }
}

