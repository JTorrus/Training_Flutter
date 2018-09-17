class Movie {
  final int id;
  final double voteAverage;
  final String title;
  //final List<int> genreIds;
  final String overview;
  final String releaseDate;

  factory Movie(Map jsonMap) => Movie.fromJson(jsonMap);

  Movie.fromJson(Map jsonMap)
      : id = jsonMap['id'].toInt(),
        voteAverage = jsonMap['vote_average'].toDouble(),
        title = jsonMap['title'],
        overview = jsonMap['overview'],
        releaseDate = jsonMap['release_date'];
        /*genreIds =
            jsonMap['genre_ids'].map<int>((value) => value.toInt()).toList();*/

  Map toJson() => {
        'id': id,
        'vote_average': voteAverage,
        'title': title,
        'overview': overview,
        'release_date': releaseDate
        //'genre_ids': genreIds
      };
}
