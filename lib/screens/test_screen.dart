import 'package:flutter/material.dart';
import 'package:muflix/services/api_service.dart';

import '../models/album_model.dart';
import '../widgets/carousel_silder.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Widget _fetchData(BuildContext context) {
    Future<List<Album>> albums = ApiService().getAlbums();
    return FutureBuilder<List<Album>>(
      future: albums,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }
        return _buildBody(context, snapshot);
      },
    );
  }

  Widget _buildBody(BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
    List<Album> albums = snapshot.data!.toList();
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 7),
            CarouselImage(
              albums: albums,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}
