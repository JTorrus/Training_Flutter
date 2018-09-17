import 'package:flutter/material.dart';
import 'package:training_test/utils/request_provider.dart';
import 'package:training_test/widgets/movie_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FluttieDB',
      home: new HomePage(),
    );
  }
}

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
      appBar: AppBar(title: Text("FluttieDB"),),
      body: MovieList(
        _requestProvider, "popular"
      ),
    );
  }
}
