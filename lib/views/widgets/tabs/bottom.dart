import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_film_fan/bloc/recommended/bloc.dart';
import 'package:flutter_film_fan/bloc/similar/bloc.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/models/tabs.dart';
import 'package:flutter_film_fan/views/widgets/tabs/recommend.dart';
import 'package:flutter_film_fan/views/widgets/tabs/similar.dart';

class BottomTab extends StatefulWidget {
  final int movieId;
  const BottomTab({Key key, this.movieId}) : super(key: key);

  static List<TabItem> tabs = tabHeaders;

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: BottomTab.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white54,
                width: 0.2,
              ),
            ),
          ),
          child: TabBar(
            isScrollable: true,
            controller: _controller,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primaryAccent,
            unselectedLabelColor: Colors.white54,
            indicatorWeight: 2.5,
            tabs: BottomTab.tabs
                .map(
                  (tab) => Tab(
                    child: Text(tab.title),
                  ),
                )
                .toList(),
          ),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RecommendedBloc(),
            ),
            BlocProvider(
              create: (context) => SimilarBloc(),
            )
          ],
          child: Container(
            height: height * 0.6,
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                Recommended(movieId: widget.movieId),
                Similar(movieId: widget.movieId),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
