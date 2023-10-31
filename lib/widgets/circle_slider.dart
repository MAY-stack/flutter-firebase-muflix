import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../screens/detail_screen.dart';
import '../utils/my_custom_scroll_behavior.dart';

class CircleSlider extends StatelessWidget {
  final List<Album> albums;
  const CircleSlider({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('미리보기'),
          SizedBox(
            height: 120,
            child: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeCircleImages(context, albums),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<Album> albums) {
  List<Widget> results = [];
  for (var i = 0; i < albums.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
                  album: albums[i],
                );
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage: NetworkImage(albums[i].imageUrl),
              radius: 48,
            ),
          ),
        ),
      ),
    );
  }
  return results;
}
