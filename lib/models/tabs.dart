import 'package:flutter/material.dart';

class TabItem {
  final String title;

  const TabItem({@required this.title});
}

List<TabItem> tabHeaders = [
  TabItem(title: "Recommended"),
  TabItem(title: "Similar"),
];
