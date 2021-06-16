import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/actors/bloc.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/views/widgets/shared/actors_avatar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ActorsList extends StatelessWidget {
  final String overview;
  const ActorsList({
    Key key,
    this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Plot summary",
              style: TextStyle(
                height: 1,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              overview,
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.5,
                fontFamily: "Quicksand",
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Divider(
                color: AppColors.lightGrey.withOpacity(0.2),
              ),
            ),
            BlocBuilder<ActorsBloc, ActorsState>(
              builder: (context, state) {
                if (state is ActorsLoading) {
                  return Container(
                    color: AppColors.dark,
                    child: Center(
                      child: SpinKitChasingDots(
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                  );
                } else if (state is ActorsSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Casting",
                        style: TextStyle(
                          height: 1,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        height: 120.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: state.data.cast
                              .where(
                                (e) => e.knownForDepartment == "Acting",
                              )
                              .map(
                                (e) => Column(
                                  children: <Widget>[
                                    e.profilePath != null
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 12.0,
                                            ),
                                            child: ActorsAvatar(cast: e),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  );
                }

                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
