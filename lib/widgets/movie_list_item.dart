import 'package:flutter/material.dart';
import 'package:training_test/model/movie.dart';

class MovieListItem extends StatelessWidget {
  MovieListItem(this.movie);

  final Movie movie;

  Widget _getTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(movie.title),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(movie.releaseDate),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            _getTitleSection(context),
          ],
        ),
      ),
    );
  }
}