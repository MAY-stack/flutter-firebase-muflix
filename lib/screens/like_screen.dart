import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  late Future<List<Album>> albumData;
  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: albumData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        return _buildList(context, snapshot.data!);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    albumData = ApiService().getAlbums();
  }

  Widget _buildList(BuildContext context, List<Album> snapshot) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: const EdgeInsets.all(3),
          children:
              snapshot.map((data) => _buildListItem(context, data)).toList()),
    );
  }

  Widget _buildListItem(BuildContext context, Album album) {
    return InkWell(
      child: Column(
        children: [
          Image.network(album.imageUrl),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(album.albumName),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(album: album);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20, 27, 20, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          _buildBody(context)
        ],
      ),
    );
  }
}
