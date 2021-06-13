import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: Colors.pinkAccent.shade400,
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Film fan"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
