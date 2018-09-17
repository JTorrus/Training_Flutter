import 'package:flutter/material.dart';
import 'package:training_test/model/movie.dart';
import 'package:training_test/utils/loading_state.dart';
import 'package:training_test/utils/request_provider.dart';
import 'package:training_test/widgets/movie_list_item.dart';

class MovieList extends StatefulWidget {
  MovieList(this.provider, this.category, {Key key}) : super(key: key);

  final RequestProvider provider;
  final String category;

  @override
  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> _movies = List();
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

  _loadNextPage() async {
    _isLoading = true;

    try {
      var nextMovies = await widget.provider
          .provideMedia(widget.category, page: _pageNumber);

      setState(() {
        _loadingState = LoadingState.DONE;
        _movies.addAll(nextMovies);
        _isLoading = false;
        _pageNumber++;
      });
    } catch (e) {
      _isLoading = false;

      if (_loadingState == LoadingState.LOADING) {
        setState(() => _loadingState = LoadingState.ERROR);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loadingState) {
      case LoadingState.DONE:
        return ListView.builder(
            itemCount: _movies.length,
            itemBuilder: (BuildContext context, int index) {
              if (!_isLoading && index > (_movies.length * 0.7)) {
                _loadNextPage();
              }

              return MovieListItem(_movies[index]);
            });
      case LoadingState.ERROR:
        return Center(
            child: Text("Error retrieving movies, check your connection"));
      case LoadingState.LOADING:
        return Center(child: CircularProgressIndicator());
      default:
        return Container();
    }
  }
}
