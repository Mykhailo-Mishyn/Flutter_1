import 'package:flutter/material.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Column(
        children: <Widget>[
          CircleAvatar(backgroundImage: AssetImage("assets/images/avatar.jpg")),
          Text(
            'st_hol',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
