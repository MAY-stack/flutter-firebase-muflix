import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/album_model.dart';

class DetailScreen extends StatefulWidget {
  final Album album;
  const DetailScreen({super.key, required this.album});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    super.initState();
    // like = widget.album.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.album.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  height: 300,
                                  child: Image.network(
                                    widget.album.imageUrl,
                                    height: 300,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  child: const Text(
                                    '99%일치 2019 15+ 시즌 1개',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Container(
                                  // title
                                  padding: const EdgeInsets.all(7),
                                  child: Text(
                                    widget.album.albumName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  // play button
                                  padding: const EdgeInsets.all(3),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '재생',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // album info
                                  padding: const EdgeInsets.all(5),
                                  child: Text(widget.album.albumName),
                                ),
                                Container(
                                  // artist info
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.album.artistName,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.black26,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            like = !like;
                            // widget.album.reference.update({'like': like});
                          });
                        },
                        child: Column(
                          children: [
                            like
                                ? const Icon(Icons.check)
                                : const Icon(Icons.add),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            const Text(
                              '내가 찜한 콘텐츠',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {},
                        child: const Column(
                          children: [
                            Icon(Icons.thumb_up),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '평가',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {},
                        child: const Column(
                          children: [
                            Icon(Icons.send),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '공유',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeMenuButton() {
  return Container();
}
