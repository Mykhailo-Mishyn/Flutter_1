import 'package:Fluttegram/layout/feed/entity/post.dart';
import 'package:Fluttegram/layout/feed/entity/story.dart';
import 'package:Fluttegram/util/utility.dart';
import 'package:flutter/material.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  final _postList = <Post>[
    Post(),
    Post(),
    Post(),
    Post(),
    Post(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: BlackPrimary.primaryBlack,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
            title: _buildTabBar(),
          ),
          body: _buildTabBarView(),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.symmetric(horizontal: 0),
      tabs: [
        Align(
            alignment: Alignment.centerLeft,
            child: Tab(
                icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ))),
        Align(
            alignment: Alignment.center,
            child: Tab(
                icon: Text(
              'Fluttergram',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 27),
            ))),
        Align(
            alignment: Alignment.centerRight,
            child: Tab(
                icon: Icon(
              Icons.send,
              color: Colors.white,
            ))),
      ],
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      children: [
        //left
        dummyTestExpandedClass(),

        //main
        CustomScrollView(
          slivers: <Widget>[
            //buildSliverAppBar(),
            buildStories(),
            buildPosts(),
          ],
        ),

        //right
        dummyTestSpacerClass()
      ],
    );
  }

  Center dummyTestExpandedClass() {
    return Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 300,
              ),
            ),
            Container(
              color: Colors.red,
              height: 100,
              width: 100,
            ),
          ],
        ),
      );
  }

  Row dummyTestSpacerClass() {
    return Row(
        children: <Widget>[
          Text('1st',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 27,  color: Colors.white)),
          Spacer(), // Defaults to a flex of one.
          Text('2nd',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 27,  color: Colors.white)),
          // Gives twice the space between Middle and End than Begin and Middle.
          Spacer(flex: 2),
          Text('3rd',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 27,  color: Colors.white)),
        ],
      );
  }

  Widget buildStories() {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Story(),
            Story(),
            Story(),
            Story(),
            Story(),
            Story(),
            Story(),
            Story(),
            Story(),
            Story(),
          ],
        ),
      ),
    );
  }

  Widget buildPosts() {
    return SliverList(
      delegate: SliverChildListDelegate([..._postList]),
    );
  }
}

// @deprecated
// SliverAppBar buildSliverAppBar() {
//   return SliverAppBar(
//     pinned: true,
//     backgroundColor: Colors.black54,
//     centerTitle: true,
//     leading: IconButton(
//       icon: Icon(
//         Icons.camera_alt,
//         color: Colors.white,
//       ),
//       onPressed: () {},
//     ),
//     title: Text(
//       'Fluttergram',
//       style: TextStyle(fontFamily: 'Billabong'),
//     ),
//     actions: <Widget>[
//       IconButton(
//         icon: Icon(
//           Icons.send,
//           color: Colors.white,
//         ),
//         onPressed: () {},
//       )
//     ],
//   );
// }
