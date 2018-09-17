import 'package:flutter/material.dart';
import 'package:training_test/model/movie.dart';
import 'package:training_test/utils/loading_state.dart';
import 'package:training_test/utils/request_provider.dart';
import 'package:training_test/widgets/movie_list_item.dart';

String _currentFilter = "popular";

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RequestProvider _requestProvider = new RequestProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FluttieDB"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => buildFilterBottomSheet(),
          )
        ],
      ),
      body: MovieList(_requestProvider, _currentFilter),
    );
  }

  void buildFilterBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 150.0,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                buildFilterTitle(context),
                Expanded(
                  child: _FilterChipRow(),
                ),
              ],
            ),
          );
        });
  }
}

Widget buildFilterTitle(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    alignment: Alignment.centerLeft,
    height: 46.0,
    decoration: BoxDecoration(color: Colors.blue),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          "Filter by",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        OutlineButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0.0),
          shape: const StadiumBorder(),
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

class MovieList extends StatefulWidget {
  MovieList(this.provider, this.currentFilter, {Key key}) : super(key: key);

  final RequestProvider provider;
  final String currentFilter;

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
          .provideMedia(widget.currentFilter, page: _pageNumber);

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

class _FilterChipRow extends StatefulWidget {
  @override
  _FilterChipRowState createState() {
    return new _FilterChipRowState();
  }
}

class _FilterChipRowState extends State<_FilterChipRow> {
  bool _filterPopularity = true;
  bool _filterRate = false;
  bool _filterLatest = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FilterChip(
          label: Text("Popularity"),
          onSelected: (value) {
            setState(() {
              _filterPopularity = value;
              _filterRate = !value;
              _filterLatest = !value;
              _currentFilter = "popular";
            });
          },
          selected: _filterPopularity,
        ),
        FilterChip(
          label: Text("Ratings"),
          onSelected: (value) {
            setState(() {
              _filterRate = value;
              _filterPopularity = !value;
              _filterLatest = !value;
              _currentFilter = "top_rated";
            });
          },
          selected: _filterRate,
        ),
        FilterChip(
          label: Text("Latest"),
          onSelected: (value) {
            setState(() {
              _filterLatest = value;
              _filterRate = !value;
              _filterPopularity = !value;
              _currentFilter = "latest";
            });
          },
          selected: _filterLatest,
        ),
      ],
    );
  }
}
