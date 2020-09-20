import 'package:Fluttegram/layout/feed/feed_list.dart';
import 'package:Fluttegram/util/utility.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'st-hol instagram copy (fluttergram)',
        theme: ThemeData(
          primarySwatch: BlackPrimary.primaryBlack,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FeedList());
  }
}
