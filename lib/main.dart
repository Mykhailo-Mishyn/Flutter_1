import 'package:Fluttegram/layout/feed/FeedList.dart';
import 'package:Fluttegram/model/StorySeenCountModel.dart';
import 'package:Fluttegram/theme/ThemeSettings.dart';
import 'package:Fluttegram/util/Utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<MyApp> {
  int _currentIndex = 0;

  final _feedScreen = GlobalKey<NavigatorState>();
  final _diagramScreen = GlobalKey<NavigatorState>();

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
              debugShowCheckedModeBanner: false,
              title: 'st-hol instagram copy (fluttergram)',
              theme: notifier.isDarkTheme ? dark : light,
              home: home(context),
            );
          },
        ));
  }

  Scaffold home(BuildContext context) {
    return Scaffold(
              body: IndexedStack(
                index: _currentIndex,
                children: <Widget>[
                  Navigator(
                    key: _feedScreen,
                    onGenerateRoute: (route) => MaterialPageRoute(
                      settings: route,
                      builder: (context) => FeedList(),
                    ),
                  ),
                  Navigator(
                    key: _diagramScreen,
                    initialRoute: '/',
                    onGenerateRoute: generateRouteForDiagramsScreen,
                    onUnknownRoute: (settings) => MaterialPageRoute(
                        builder: (context) => UndefinedView(
                          name: settings.name,
                        )),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: (val) => _onTap(val, context),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_books),
                    title: Text('Library'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    title: Text('Playlists'),
                  ),
                ],
              ),
            );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _feedScreen.currentState.popUntil((route) => route.isFirst);
          break;
        case 1:
          _diagramScreen.currentState.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}

Route<dynamic> generateRouteForDiagramsScreen(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Text('1')); //InitialDiagramScreen(),
    case 'b':
      return MaterialPageRoute(builder: (context) => Text('2'));
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,));
  }
}

class UndefinedView extends StatelessWidget {
  final String name;
  const UndefinedView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => ThemeNotifier(),
//         ),
//         ChangeNotifierProvider<StorySeenModel>(
//             create: (context) => StorySeenModel()),
//       ],
//       child: Consumer<ThemeNotifier>(
//         builder: (context, ThemeNotifier notifier, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'st-hol instagram copy (fluttergram)',
//             theme: notifier.isDarkTheme ? dark : light,
//             // theme: ThemeData(
//             //   primarySwatch: BlackPrimary.primaryBlack,
//             //   visualDensity: VisualDensity.adaptivePlatformDensity,
//             // ),
//             home: FeedList(),
//           );
//         },
//       ));
// }


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

