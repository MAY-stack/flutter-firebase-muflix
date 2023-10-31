// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  final focusNode = FocusNode();
  String _searchText = "";
  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text.toString();
      });
    });
  }

  late Future<List<Album>> albumData;
  // final String _searchText = _filter.text.toString();
  @override
  void initState() {
    super.initState();
    albumData = ApiService().getAlbums();
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: albumData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        return _buildList(context, snapshot.data!);
      },
    );
  }

  Widget _buildList(BuildContext context, List<Album> snapshot) {
    List<Album> searchResults = [];
    for (Album a in snapshot) {
      if (a.albumName.toString().contains(_searchText)) {
        searchResults.add(a);
      }
    }
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: const EdgeInsets.all(3),
        children:
            searchResults.map((data) => _buildListItem(context, data)).toList(),
      ),
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
    return SizedBox(
      child: Column(
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            //검색창
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 15),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                            )
                          : Container(),
                      hintText: '검색',
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                focusNode.hasFocus
                    ? Expanded(
                        child: TextButton(
                          child: const Text('취소'),
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              focusNode.unfocus();
                            });
                          },
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(),
                      ),
              ],
            ),
          ),
          _buildBody(context),
        ],
      ),
    );
  }
}
