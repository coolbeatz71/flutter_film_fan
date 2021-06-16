import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  final int movieId;
  const Recommended({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      child: Text(movieId.toString()),
    );
  }
}
