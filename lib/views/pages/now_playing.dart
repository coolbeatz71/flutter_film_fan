import 'package:flutter/material.dart';
import 'package:flutter_film_fan/constants/index.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/models/now_playing.dart';
import 'package:flutter_film_fan/services/api.dart';
import 'package:flutter_film_fan/views/widgets/movie_card.dart';
import 'package:flutter_film_fan/views/widgets/shared/error_msg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/now_playing/bloc.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  double topHeight = 0.0;
  NowPlayingBloc _nowPlayingBloc;

  ApiService service = ApiService();

  @override
  void initState() {
    super.initState();
    service.generateGuestSession();
    _nowPlayingBloc = BlocProvider.of<NowPlayingBloc>(context);
    _nowPlayingBloc.add(GetNowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    service.generateGuestSession();
    return Builder(
      builder: (context) {
        return Container(
          color: AppColors.dark,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                title: Text(
                  "Now playing",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 25,
                  ),
                ),
                expandedHeight: 280.0,
                backgroundColor: AppColors.primary,
                leading: Icon(
                  Icons.play_circle_outline,
                  size: 32,
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    topHeight = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      background: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/header.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.pinkAccent.withOpacity(0.8),
                                  Colors.black.withOpacity(0.4),
                                ],
                                stops: [0.0, 0.9],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 180,
                              left: 20.0,
                              right: 20.0,
                              bottom: 18.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    color: AppColors.primaryAccent,
                                  ),
                                  child: Text(
                                    "Stay tunned",
                                    style: TextStyle(
                                      height: 1,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'The Kinyarwanda version for "King Kong III" will be released in September...',
                                    style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              BlocListener<NowPlayingBloc, NowPlayingState>(
                listener: (context, state) {
                  if (state is NowPlayingFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
                  builder: (context, state) {
                    if (state is NowPlayingLoading) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: SpinKitThreeBounce(
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      );
                    } else if (state is NowPlayingSuccess) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Result res = state.data.results[index];

                            String poster = "$POSTER_URL${res.posterPath}";
                            String backdrop = "$POSTER_URL${res.backdropPath}";
                            String title = res.originalTitle;
                            DateTime releaseDate = res.releaseDate;
                            double voteAverage = res.voteAverage;
                            int voteCount = res.voteCount;
                            int movieId = res.id;

                            return Material(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 12.0,
                                ),
                                child: MovieCard(
                                  id: movieId,
                                  title: title,
                                  poster: poster,
                                  backdrop: backdrop,
                                  voteCount: voteCount,
                                  releaseDate: releaseDate,
                                  voteAverage: voteAverage,
                                ),
                              ),
                            );
                          },
                          childCount: state.data.results.length,
                        ),
                      );
                    } else if (state is NowPlayingFail) {
                      return ErrorMsg(message: state.message);
                    }

                    return SliverToBoxAdapter(child: Container());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
