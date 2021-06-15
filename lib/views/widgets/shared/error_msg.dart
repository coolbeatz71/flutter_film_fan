import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String message;
  const ErrorMsg({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          this.message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
