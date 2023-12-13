import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../screens/detail_screen.dart';
import '../utils/my_custom_scroll_behavior.dart';

class CircleSlider extends StatelessWidget {
  final List<dynamic> items;
  const CircleSlider({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('아티스트'),
          SizedBox(
            height: 120,
            child: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeCircleImages(context, items),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<dynamic> items) {
  List<Widget> results = [];
  for (var i = 0; i < items.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
                  album: items[i],
                );
              },
            ),
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(items[i].imageUrl),
                  radius: 48,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                '${items[i].artistName}',
                overflow: TextOverflow.ellipsis, // 말줄임표 표시
                maxLines: 1, // 표시할 최대 줄 수
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return results;
}
