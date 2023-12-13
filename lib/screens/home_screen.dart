// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../models/track_model.dart';
import '../services/api_service.dart';
import '../models/album_model.dart';
import '../widgets/box_slider.dart';
import '../widgets/carousel_silder.dart';
import '../widgets/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<Album>> albumData = ApiService().getAlbums();
  final Future<List<Artist>> artistData = ApiService().getArtists();
  final Future<List<Track>> trackData = ApiService().getTracks();

  Widget _fetchData(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder(
          future: albumData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarouselImage(albums: snapshot.data as List<Album>);
            }
            return const CircularProgressIndicator();
          },
        ),
        FutureBuilder(
          future: artistData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CircleSlider(items: snapshot.data as List<Artist>);
            }
            return const CircularProgressIndicator();
          },
        ),
        FutureBuilder(
          future: trackData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BoxSlider(tracks: snapshot.data as List<Track>);
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}
