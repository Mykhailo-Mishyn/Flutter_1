import 'package:flutter/material.dart';

class HeroPhotoPage extends StatelessWidget {
  final String username;
  final String tag;
  final Image image;
  final String description;

  HeroPhotoPage(this.username, this.tag, this.image, this.description);

  @override
  Widget build(BuildContext context) {
    double iconRadius = 100;

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text('$username'),
      ),
      body: Column(children: <Widget>[
        Stack(
          children: [
            Container(
              child: Hero(
                tag: '$tag',
                child: this.image,
              ),
            ),
            _overflowingHeartSign(context, iconRadius),
          ],
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _commentLikeDirect(),
          ),
        ),
        Expanded(
            flex: 3,
            child: Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  this.description,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                )))
      ]),
      floatingActionButton: _downloadBtn(),
    );
  }

  Positioned _overflowingHeartSign(BuildContext context, double iconRadius) {
    return Positioned(
            left: (MediaQuery.of(context).size.width / 2) - iconRadius,
            top: iconRadius,
            child: Icon(
              Icons.favorite_border,
              color: Color.fromRGBO(255, 255, 255, 0.35),
              size: iconRadius * 2,
            ),
          );
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

  FloatingActionButton _downloadBtn() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'download',
      child: Icon(Icons.file_download, color: Colors.green),
    );
  }
}