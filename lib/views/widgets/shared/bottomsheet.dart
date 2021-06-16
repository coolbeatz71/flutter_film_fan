import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/rating/bloc.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/views/widgets/rate_movie.dart';

class BottomSheetContainer extends StatelessWidget {
  final int movieId;
  const BottomSheetContainer({
    Key key,
    this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 4, left: 8, right: 8),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(child: Container()),
                    Flexible(
                      child: InkWell(
                        child: Theme(
                          data: new ThemeData(accentColor: Colors.white),
                          child: FloatingActionButton(
                            heroTag: key,
                            elevation: 0,
                            mini: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => RatingBloc(),
                child: RateMovie(movieId: movieId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
