import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/actors/bloc.dart';
import 'package:flutter_film_fan/bloc/details/bloc.dart';
import 'package:flutter_film_fan/views/pages/details.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/views/widgets/custom_painter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieCard extends StatelessWidget {
  final int id;
  final String poster;
  final String backdrop;
  final String title;
  final DateTime releaseDate;
  final double voteAverage;
  final int voteCount;

  const MovieCard({
    Key key,
    @required this.id,
    @required this.title,
    @required this.poster,
    @required this.backdrop,
    @required this.releaseDate,
    @required this.voteAverage,
    @required this.voteCount,
  }) : super(key: key);

  final double _height = 130;
  final double borderRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DetailsBloc(),
                ),
                BlocProvider(
                  create: (context) => ActorsBloc(),
                )
              ],
              child: Details(
                id: id,
                title: title,
                poster: poster,
                backdrop: backdrop,
                releaseDate: releaseDate,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(this.borderRadius),
      child: Stack(
        children: <Widget>[
          Container(
            height: _height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(this.borderRadius),
              color: AppColors.secondary.withOpacity(0.8),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
              maintainSize: false,
              maintainState: true,
              maintainAnimation: true,
              child: CustomPaint(
                size: Size(130, _height),
                painter: CustomCardShapePainter(
                  borderRadius,
                  Colors.pink.shade100.withOpacity(0.2),
                  AppColors.secondary.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    ),
                    child: Image.network(
                      this.poster,
                      fit: BoxFit.fill,
                      height: 130,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          DateFormat('yyyy MMM dd').format(releaseDate),
                          style: TextStyle(
                            color: Colors.white60,
                            fontFamily: "Quicksand",
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Chip(
                              visualDensity: VisualDensity(
                                horizontal: 0.0,
                                vertical: -4.0,
                              ),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.white10,
                                child: Text(
                                  "$voteAverage",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              label: Text(
                                "/$voteCount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              backgroundColor: Colors.white24,
                              padding: EdgeInsets.all(8.0),
                            ),
                            SizedBox(width: 12.0),
                            Container(
                              child: SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: voteAverage / 2,
                                size: 15.0,
                                isReadOnly: true,
                                color: Colors.amber.shade300,
                                borderColor: Colors.amber.shade100,
                                spacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
