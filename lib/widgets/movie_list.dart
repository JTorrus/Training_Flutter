import 'package:flutter/material.dart';
import 'package:training_test/model/movie.dart';
import 'package:training_test/utils/loading_state.dart';
import 'package:training_test/utils/request_provider.dart';
import 'package:training_test/widgets/movie_list_item.dart';

String _currentFilter = "";

class HomePage extends StatefulWidget {
  HomePage({Key key, this.provider, this.initialFilter}) : super(key: key);

  final RequestProvider provider;
  final String initialFilter;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movies = List();
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

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
      body: buildBody(),
    );
  }

  Widget buildFilterBottomSheetUpper() {
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
            onPressed: () => performUpdate(),
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

  void buildFilterBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 150.0,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                buildFilterBottomSheetUpper(),
                Expanded(
                  child: FilterChipRow(),
                ),
              ],
            ),
          );
        });
  }

  _loadNextPage() async {
    _isLoading = true;

    try {
      var nextMovies =
          await widget.provider.provideMedia(_currentFilter, page: _pageNumber);

      setState(() {
        _loadingState = LoadingState.DONE;
        _movies.addAll(nextMovies);
        _isLoading = false;
        _pageNumber++;
      });
    } catch (e) {
      _isLoading = false;

      setState(() => _loadingState = LoadingState.ERROR);
    }
  }

  void performUpdate() {
    setState(() {
      _movies.clear();
      _pageNumber = 1;
      _loadingState = LoadingState.LOADING;
      Navigator.pop(context);
    });

    _loadNextPage();
  }

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialFilter;
    _loadNextPage();
  }

  Widget buildBody() {
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

class FilterChipRow extends StatefulWidget {
  @override
  _FilterChipRowState createState() {
    return new _FilterChipRowState();
  }
}

class _FilterChipRowState extends State<FilterChipRow> {
  bool _filterPopularity;
  bool _filterRate;
  bool _filterLatest;

  @override
  Widget build(BuildContext context) {
    checkFilters();

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
          selectedColor: Colors.blue[300],
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
          selectedColor: Colors.blue[300],
        ),
        FilterChip(
          label: Text("Upcoming"),
          onSelected: (value) {
            setState(() {
              _filterLatest = value;
              _filterRate = !value;
              _filterPopularity = !value;
              _currentFilter = "upcoming";
            });
          },
          selected: _filterLatest,
          selectedColor: Colors.blue[300],
        ),
      ],
    );
  }

  void checkFilters() {
    if (_currentFilter == "popular") {
      _filterPopularity = true;
      _filterRate = false;
      _filterLatest = false;
    } else if (_currentFilter == "top_rated") {
      _filterPopularity = false;
      _filterRate = true;
      _filterLatest = false;
    } else if (_currentFilter == "upcoming") {
      _filterPopularity = false;
      _filterRate = false;
      _filterLatest = true;
    }
  }
}
