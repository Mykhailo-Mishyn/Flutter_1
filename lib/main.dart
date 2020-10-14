import 'package:Fluttegram/layout/feed/feed_list.dart';
import 'package:Fluttegram/model/StorySeenCountModel.dart';
import 'package:Fluttegram/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<StorySeenModel>(
              create: (context) => StorySeenModel()),
        ],
        child: MaterialApp(
            title: 'st-hol instagram copy (fluttergram)',
            theme: ThemeData(
              primarySwatch: BlackPrimary.primaryBlack,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FeedList()));
  }
}
