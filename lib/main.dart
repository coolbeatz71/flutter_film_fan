import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/now_playing/bloc.dart';

import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/views/pages/now_playing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: AppColors.primary,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => NowPlayingBloc(),
        child: NowPlaying(),
      ),
    ),
  );
}
