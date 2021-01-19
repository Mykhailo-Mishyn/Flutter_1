import 'package:Fluttegram/layout/feed/entity/post.dart';
import 'package:Fluttegram/layout/feed/entity/story.dart';
import 'package:Fluttegram/model/StorySeenCountModel.dart';
import 'package:Fluttegram/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'entity/hero_photo_story.dart';

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
        length: 2,
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
                icon: Text(
              'FikFok',
              style: TextStyle(fontFamily: 'Futura', fontSize: 27),
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

  Image dummyTestSpacerClass() {
    return Image.asset("assets/images/tab.jpg");
  }

  Widget buildStories() {
    return SliverToBoxAdapter(
      child: Container(
        height: 75,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _populateStoryList(),
        ),
      ),
    );
  }

  List<_ClickableStory> _populateStoryList() {
    List<Story> stories = context.select<StorySeenModel, List<Story>>(
      (storyModel) => storyModel.storyViewsCountMap.keys.toList(),
    );
    return stories.map((story) => _ClickableStory(story: story)).toList();
  }

  Widget buildPosts() {
    return SliverList(
      delegate: SliverChildListDelegate([..._postList]),
    );
  }
}

class _ClickableStory extends StatelessWidget {
  final Story story;

  const _ClickableStory({Key key, @required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var isAlreadySeen = context.select<StorySeenModel, bool>(
    //   (storyModel) =>
    //       storyModel.storiesPartitionMap[StoryActuality.SEEN].contains(story),
    // );

    return Container(
      child: Hero(
          tag: story.tag,
          child: GestureDetector(
              onTap: () {
                final model =
                    Provider.of<StorySeenModel>(context, listen: false);
                model.incrementViewCount(story.tag);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HeroPhotoStory(story.username,
                            story.tag, Image.asset(story.contentImagePath))));
              },
              child: story)),
    );
  }
}
