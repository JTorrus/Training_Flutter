import 'package:training_test/utils/media_details.dart';

class Movie {
  int id;
  double voteAverage;
  String title;
  List<int> genreIds;
  String overview;
  String releaseDate;
  String posterPath;
  String backdropPath;

  String getBackdropUrl() => getLargePictureUrl(backdropPath);

  String getPosterUrl() => getMediumPictureUrl(posterPath);

  int getReleaseYear() {
    return releaseDate == null || releaseDate == ""
        ? 0
        : DateTime.parse(releaseDate).year;
  }

  factory Movie(Map jsonMap) => Movie.fromJson(jsonMap);

  Movie.fromJson(Map jsonMap)
      : id = jsonMap['id'].toInt(),
        voteAverage = jsonMap['vote_average'].toDouble(),
        title = jsonMap['title'],
        overview = jsonMap['overview'],
        releaseDate = jsonMap['release_date'],
        posterPath = jsonMap['poster_path'] ?? "",
        backdropPath = jsonMap['backdrop_path'] ?? "",
        genreIds = (jsonMap["genre_ids"] as List<dynamic>)
            .map<int>((value) => value.toInt())
            .toList();

  Map toJson() => {
        'id': id,
        'vote_average': voteAverage,
        'title': title,
        'overview': overview,
        'release_date': releaseDate,
        'genre_ids': genreIds,
        'poster_path': posterPath,
        'backdrop_path': backdropPath
      };
}
