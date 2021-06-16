import 'package:flutter/material.dart';
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

    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
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
              indicatorColor: Colors.deepOrangeAccent,
              labelColor: Colors.deepOrangeAccent,
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
          Container(
            height: height * 0.6,
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                Recommended(movieId: widget.movieId),
                Similar(movieId: widget.movieId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
