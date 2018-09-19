import 'package:flutter/material.dart';
import 'package:training_test/details.dart';
import 'package:training_test/model/movie.dart';
import 'package:training_test/utils/media_details.dart';

class MovieListItem extends StatelessWidget {
  MovieListItem(this.movie);

  final Movie movie;

  Widget _getTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      height: 260.0,
      child: Wrap(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            child: Text(
                              movie.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            movie.getReleaseYear().toString(),
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        getGenreString(movie.genreIds),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    movie.voteAverage.toString(),
                  ),
                  Icon(
                    Icons.stars,
                    size: 16.0,
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Material(
              child: Image(
                image: NetworkImage(getLargePictureUrl(movie.backdropPath)),
              ),
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
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Details(movie);
          }));
        },
        child: Container(
          child: _getTitleSection(context),
        ),
      ),
    );
  }
}