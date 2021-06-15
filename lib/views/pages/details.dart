import 'package:flutter/material.dart';
import 'package:flutter_film_fan/helpers/colors.dart';

class Details extends StatefulWidget {
  final int id;
  final String poster;
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
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double topHeight = 0.0;

  @override
  Widget build(BuildContext context) {
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
            expandedHeight: 280.0,
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
