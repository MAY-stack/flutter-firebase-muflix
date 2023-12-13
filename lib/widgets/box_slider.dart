import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../utils/my_custom_scroll_behavior.dart';

class BoxSlider extends StatelessWidget {
  final List<Track> tracks;
  const BoxSlider({super.key, required this.tracks});

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
                children: makeBoxImages(context, tracks),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(BuildContext context, List<Track> tracks) {
  List<Widget> results = [];
  for (var i = 0; i < tracks.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return const Text('detail screen');
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.network(tracks[i].imageUrl),
          ),
        ),
      ),
    );
  }
  return results;
}
