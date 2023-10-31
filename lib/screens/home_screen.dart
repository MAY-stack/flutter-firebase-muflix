// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/circle_slider.dart';
import '../models/album_model.dart';
import '../widgets/box_slider.dart';
import '../widgets/carousel_silder.dart';
import '../widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Album>> albumData = ApiService().getAlbums();

  @override
  void initState() {
    super.initState();
    // albumData = ApiService().getAlbums();
  }

  Widget _fetchData(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: albumData,
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
            const TopBar(),
            CarouselImage(
              albums: albums,
            ),
          ],
        ),
        CircleSlider(
          albums: albums,
        ),
        BoxSlider(
          albums: albums,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}
