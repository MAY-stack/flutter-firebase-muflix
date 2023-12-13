import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muflix/models/album_model.dart';
import 'package:muflix/screens/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Album> albums;
  const CarouselImage({super.key, required this.albums});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Album> albums;
  late List<String> idS;
  late List<String> titles;
  late List<Widget> images;
  late List<int> popularities;

  int _currentPage = 0;
  late String _currentTitle;

  void setAlbums() {
    albums = widget.albums;
    idS = albums.map((a) => a.albumId).toList();
    images = albums.map((a) => Image.network(a.imageUrl)).toList();
    titles = albums.map((a) => a.albumName).toList();
    _currentTitle = titles[_currentPage];
  }

  @override
  Widget build(BuildContext context) {
    setAlbums();
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
          ),
          //앨범 이미지
          CarouselSlider(
            items: images,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentPage = index;
                    _currentTitle = titles[_currentPage];
                  },
                );
              },
            ),
          ),
          // 앨범 제목
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
            width: 300,
            height: 60,
            child: Center(
              child: Text(
                _currentTitle,
                overflow: TextOverflow.ellipsis, // 말줄임표 표시
                maxLines: 2, // 표시할 최대 줄 수
                style: const TextStyle(
                  fontSize: 20.0, // 텍스트 크기
                ),
              ),
            ),
          ),
          // 버튼들
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  // 내가 찜한 콘텐츠
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.check),
                      ),
                      // likes[_currentPage]
                      //     ? IconButton(
                      //         icon: const Icon(Icons.check),
                      //         onPressed: () {
                      //           setState(() {
                      //             likes[_currentPage] = !likes[_currentPage];

                      //             // firestore의 데이터 업데이트
                      //             // albums[_currentPage]
                      //             // .reference
                      //             // .update({'like': likes[_currentPage]});
                      //           });
                      //         },
                      //       ) // likes[_currentPage] 가 true
                      //     : IconButton(
                      //         icon: const Icon(Icons.add),
                      //         onPressed: () {
                      //           setState(() {
                      //             likes[_currentPage] = !likes[_currentPage];
                      //             // albums[_currentPage]
                      //             //     .reference
                      //             //     .update({'like': likes[_currentPage]});
                      //           });
                      //         },
                      //       ), // flase 일때
                      const Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  //재생버튼
                  padding: const EdgeInsets.only(right: 10),
                  width: 100,
                  child: /*FlatButton*/ TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // 정보
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              fullscreenDialog: true,
                              builder: (context) {
                                return DetailScreen(
                                  album: albums[_currentPage],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: makeIndicator(albums, _currentPage)),
          ),
        ],
      ),
    );
  }

  List<Widget> makeIndicator(List list, int currentPage) {
    List<Widget> results = [];
    for (var i = 0; i < list.length; i++) {
      results.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == i
                  ? const Color.fromRGBO(255, 255, 255, 0.9)
                  : const Color.fromRGBO(255, 255, 255, 0.4)),
        ),
      );
    }
    return results;
  }
}
