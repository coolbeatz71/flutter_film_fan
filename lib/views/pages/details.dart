import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/actors/bloc.dart';
import 'package:flutter_film_fan/bloc/details/bloc.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/views/widgets/actors_list.dart';
import 'package:flutter_film_fan/views/widgets/shared/error_msg.dart';
import 'package:flutter_film_fan/views/widgets/tabs/bottom.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Details extends StatefulWidget {
  final int id;
  final String poster;
  final String backdrop;
  final String title;
  final DateTime releaseDate;
  final double voteAverage;
  final int voteCount;

  Details({
    Key key,
    this.id,
    this.poster,
    this.title,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.backdrop,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double topHeight = 0.0;
  DetailsBloc _detailsBloc;
  ActorsBloc _actorsBloc;

  @override
  void initState() {
    super.initState();
    _detailsBloc = BlocProvider.of<DetailsBloc>(context);
    _detailsBloc.add(GetDetailsEvent(widget.id));

    _actorsBloc = BlocProvider.of<ActorsBloc>(context);
    _actorsBloc.add(GetActorsEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailsBloc, DetailsState>(listener: (context, state) {
          if (state is DetailsFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        }),
        BlocListener<ActorsBloc, ActorsState>(listener: (context, state) {
          if (state is ActorsFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        })
      ],
      child: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return Container(
              color: AppColors.dark,
              child: Center(
                child: SpinKitThreeBounce(
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
            );
          } else if (state is DetailsSuccess) {
            return Container(
              color: AppColors.dark,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: Text(
                      "Movie Details",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 25,
                      ),
                    ),
                    expandedHeight: 480.0,
                    backgroundColor: AppColors.primary,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        topHeight = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          background: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget.backdrop),
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
                                      Colors.pinkAccent.withOpacity(0.6),
                                      AppColors.secondary.withOpacity(0.9),
                                    ],
                                    stops: [0.0, 0.9],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 120,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 18.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 160,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white60,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.0),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.0),
                                        ),
                                        child: Image.network(
                                          widget.poster,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 25.0),
                                    Text(
                                      widget.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: "Quicksand",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 32,
                                      ),
                                    ),
                                    SizedBox(height: 18.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          DateFormat("yyyy").format(
                                            state.data.releaseDate,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Icon(
                                          Icons.fiber_manual_record,
                                          color: Colors.white,
                                          size: 8.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Row(
                                          children: state.data.genres.map(
                                            (e) {
                                              return Text(
                                                state.data.genres.last == e
                                                    ? "${e.name}"
                                                    : "${e.name}, ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                        SizedBox(width: 8.0),
                                        Icon(
                                          Icons.fiber_manual_record,
                                          color: Colors.white,
                                          size: 8.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          state.data.originalLanguage
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      child: SmoothStarRating(
                                        allowHalfRating: true,
                                        starCount: 5,
                                        rating: widget.voteAverage / 2,
                                        size: 18.0,
                                        isReadOnly: true,
                                        color: Colors.amber.shade300,
                                        borderColor: Colors.amber.shade100,
                                        spacing: 1.5,
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                    MaterialButton(
                                      color: AppColors.primary,
                                      onPressed: () => print("lol"),
                                      child: Text(
                                        "Rate the movie",
                                        style: TextStyle(
                                          height: 1,
                                          fontFamily: "Quicksand",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ActorsList(overview: state.data.overview),
                  ),
                  SliverToBoxAdapter(
                    child: Material(
                      child: BottomTab(movieId: widget.id),
                    ),
                  )
                ],
              ),
            );
          } else if (state is DetailsFail) {
            return ErrorMsg(message: state.message);
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
