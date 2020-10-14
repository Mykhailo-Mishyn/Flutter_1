import 'package:Fluttegram/model/StorySeenCountModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroPhotoStory extends StatelessWidget {
  final String username;
  final String tag;
  final Image image;

  HeroPhotoStory(this.username, this.tag, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text('$username'),
      ),
      body: Column(children: <Widget>[
        Container(
          child: Hero(
            tag: '$tag',
            child: this.image,
          ),
        ),
        Text(
          "view count: " + _populateViewsCount(context, tag),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        )
      ]),
      floatingActionButton: _markStorySeenBtn(context, tag),
    );
  }

  FloatingActionButton _markStorySeenBtn(BuildContext context, String tag) {
    var isAlreadySeen = context.select<StorySeenModel, bool>(
      (storyModel) => storyModel.storiesPartitionMap[StoryActuality.SEEN]
          .map((story) => story.tag)
          .contains(tag),
    );

    return FloatingActionButton(
      onPressed: () {
        final model = Provider.of<StorySeenModel>(context,  listen: false);
        model.seeTheStoryByTag(tag);
      },
      tooltip: 'mark as seen',
      child: Icon(Icons.remove_red_eye,
          color: isAlreadySeen ? Colors.red : Colors.green),
    );
  }

  String _populateViewsCount(context, String storyTag) {
    final model = Provider.of<StorySeenModel>(context);
    return model.getViewsCountByStoryTag(storyTag).toString();
  }

  List<Widget> _commentLikeDirect() {
    return [
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.mode_comment,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ];
  }
}
