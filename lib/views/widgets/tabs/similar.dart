import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/similar/bloc.dart';
import 'package:flutter_film_fan/constants/index.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/models/similar.dart';
import 'package:flutter_film_fan/views/widgets/movie_card.dart';
import 'package:flutter_film_fan/views/widgets/shared/error_msg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Similar extends StatefulWidget {
  final int movieId;
  const Similar({Key key, this.movieId}) : super(key: key);

  @override
  _SimilarState createState() => _SimilarState();
}

class _SimilarState extends State<Similar> {
  SimilarBloc _nowPlayingBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingBloc = BlocProvider.of<SimilarBloc>(context);
    _nowPlayingBloc.add(GetSimilarEvent(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: BlocListener<SimilarBloc, SimilarState>(
        listener: (context, state) {
          if (state is SimilarFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<SimilarBloc, SimilarState>(
          builder: (context, state) {
            if (state is SimilarLoading) {
              return Center(
                child: SpinKitThreeBounce(
                  color: AppColors.primary,
                  size: 30,
                ),
              );
            } else if (state is SimilarSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
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
                itemCount: state.data.results.length,
              );
            } else if (state is SimilarFail) {
              return ErrorMsg(message: state.message);
            }

            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
