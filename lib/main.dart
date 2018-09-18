import 'package:flutter/material.dart';
import 'package:training_test/utils/request_provider.dart';
import 'package:training_test/widgets/movie_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  String _initialFilter = "popular";
  RequestProvider _requestProvider = new RequestProvider();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FluttieDB',
      home: new HomePage(initialFilter: _initialFilter, provider: _requestProvider,),
    );
  }
}
