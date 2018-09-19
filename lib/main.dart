import 'package:flutter/material.dart';
import 'package:training_test/utils/request_provider.dart';
import 'package:training_test/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final String _initialFilter = "popular";
  final RequestProvider _requestProvider = new RequestProvider();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FluttieDB',
      home: new HomePage(initialFilter: _initialFilter, provider: _requestProvider,),
    );
  }
}
