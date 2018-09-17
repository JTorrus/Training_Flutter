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
