import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/rating/bloc.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/helpers/show_buttomsheet.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RateMovie extends StatefulWidget {
  final int movieId;
  RateMovie({Key key, this.movieId}) : super(key: key);

  @override
  _RateMovieState createState() => _RateMovieState();
}

class _RateMovieState extends State<RateMovie> {
  double value = 1.0;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Column(
          children: [
            Text(
              "Give us some stars if you enjoyed the movie",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 22.0),
            SmoothStarRating(
              allowHalfRating: true,
              starCount: 5,
              rating: value,
              size: 28.0,
              color: Colors.amber,
              borderColor: Colors.amber.shade200,
              spacing: 1.5,
              onRated: (v) {
                setState(() {
                  value = v;
                });
              },
            ),
            SizedBox(height: 22.0),
            BlocListener<RatingBloc, RatingState>(
              listener: (BuildContext context, RatingState state) {
                if (state is RatingLoading) {
                  setState(() {
                    _isButtonDisabled = true;
                  });
                } else if (state is RatingSuccess) {
                  Navigator.of(context).pop();
                  setState(() {
                    _isButtonDisabled = false;
                  });

                  Utils.showToast(message: state.data.statusMessage);
                } else if (state is RatingFail) {
                  setState(() {
                    _isButtonDisabled = true;
                  });
                  Utils.showToast(
                    toastGravity: ToastGravity.TOP,
                    message: state.message,
                  );
                }
              },
              child: SizedBox(
                width: 120,
                child: MaterialButton(
                  color: AppColors.primary,
                  disabledColor: AppColors.darkGrey,
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          BlocProvider.of<RatingBloc>(context).add(
                            PostRatingEvent(
                              widget.movieId,
                              value,
                            ),
                          );
                        },
                  child: BlocBuilder<RatingBloc, RatingState>(
                    builder: (BuildContext context, RatingState state) {
                      if (state is RatingLoading) {
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 12,
                          ),
                        );
                      } else {
                        return Text(
                          "Rate now!",
                          style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
