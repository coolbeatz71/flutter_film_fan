import 'package:flutter/material.dart';

class Similar extends StatelessWidget {
  final int movieId;
  const Similar({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(movieId.toString()),
    );
  }
}
