import 'package:Fluttegram/layout/feed/feed_list.dart';
import 'package:Fluttegram/model/StorySeenCountModel.dart';
import 'package:Fluttegram/theme/ThemeSettings.dart';
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
          ChangeNotifierProvider(
            create: (_) => ThemeNotifier(),
          ),
          ChangeNotifierProvider<StorySeenModel>(
              create: (context) => StorySeenModel()),
        ],
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
              title: 'st-hol instagram copy (fluttergram)',
              theme: notifier.isDarkTheme ? dark : light,
              // theme: ThemeData(
              //   primarySwatch: BlackPrimary.primaryBlack,
              //   visualDensity: VisualDensity.adaptivePlatformDensity,
              // ),
              home: FeedList(),
            );
          },
        ));
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ThemeNotifier(),
//       child: Consumer<ThemeNotifier>(
//         builder: (context, notifier, child) {
//           return MaterialApp(
//             title: "Flutter Provider",
//             theme: notifier.darkTheme ? dark : light,
//             home: FeedList(),
//           );
//         },
//       ),
//     );
//   }
// }

