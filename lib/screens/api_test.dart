// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/artist_model.dart';
import '../models/track_model.dart';
import '../services/api_refactoring.dart';
import '../models/album_model.dart';
import '../widgets/carousel_silder.dart';

class ApiTest extends StatelessWidget {
  ApiTest({super.key});

  late final Future<List<Album>> albumData = ApiRefctoring().getAlbum();
  late final Future<List<Artist>> artistData = ApiRefctoring().getArtist();
  late final Future<List<Track>> trackData = ApiRefctoring().getTrack();

  Widget _fetchData(BuildContext context) {
    List<Album> albums = [];
    List<Artist> artists = [];
    List<Track> tracks = [];

    Logger().d('fetchData');
    return Column(
      children: [
        FutureBuilder<List<Album>>(
          future: albumData,
          builder: (context, snapshot) {
            Logger().d('albumData.toString(): ${albumData.toString()}');
            if (!snapshot.hasData) {
              albums = snapshot.data!.toList();
              Logger().d(albums.toString());
              return const Text('Loading...');
            }
            return CarouselImage(
              albums: albums,
            );
          },
        ),
        FutureBuilder<List<Artist>>(
          future: artistData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              artists = snapshot.data!.toList();
              return const Text('Loading...');
            }
            return Text(artists[0].artistName);
          },
        ),
        FutureBuilder<List<Track>>(
          future: trackData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              tracks = snapshot.data!.toList();
              return const Text('Loading...');
            }
            return Text(tracks[0].trackName);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Logger().d('ApiTest build');
    return _fetchData(context);
  }
}
