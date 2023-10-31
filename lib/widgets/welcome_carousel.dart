import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WelcomeCarousel extends StatefulWidget {
  const WelcomeCarousel({super.key});

  @override
  State<WelcomeCarousel> createState() => _WelcomeCarouselState();
}

class _WelcomeCarouselState extends State<WelcomeCarousel> {
  List<Widget> cropedImages = [
    cropImage(
        'https://www.madtimes.org/news/photo/202210/15012_34194_3946.jpg'),
    cropImage('https://cdn.cwn.kr/news/photo/202303/15698_15208_3214.jpg'),
    cropImage(
      'https://designcompass.org/wp-content/uploads/2023/03/spotify-update-03-1024x1024.png',
    ),
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
          ),
          CarouselSlider(
              items: cropedImages,
              options: CarouselOptions(onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              })),
          SizedBox(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: makeIndicator(cropedImages, _currentPage)),
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

Widget cropImage(String url) {
  return ClipRect(
    child: Image.network(
      url,
      width: 200, // 원하는 가로 크기
      height: 200, // 원하는 세로 크기
      fit: BoxFit.cover, // 이미지 크기에 맞게 조정
    ),
  ); // 에러 발생 시 표시할 위젯을 여기에 구현
}
