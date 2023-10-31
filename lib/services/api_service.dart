import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../models/album_model.dart';

class ApiService {
  List<Album> albums = [];
  Logger logger = Logger();
  // 앨범 목록을 파싱합니다.

  List<Album> parseAlbums(String jsonStr) {
    final Map<String, dynamic> jsonData = json.decode(jsonStr);
    final List<dynamic> albumList = jsonData['albums']['items'];

    return albumList.map((item) => Album.fromJson(item)).toList();
  }

  late String accessToken;
  late String tokenType;
  late int expiresIn;

  // Token을 요청하고 성공적으로 얻었는지를 나타내는 플래그
  bool tokenObtained = false;

  // Token 요청 생성
  Future<void> sendGetTokenRequest() async {
    await dotenv.load(fileName: "assets/.env");
    const String URL = "https://accounts.spotify.com/api/token";
    final String apiId = dotenv.env['CLIENT_ID'] ?? 'default_secret_key';
    final String apiKey =
        dotenv.env['CLIENT_SECRET_KEY'] ?? 'default_secret_key';

    final Map<String, String> body = {
      "grant_type": "client_credentials",
      "client_id": apiId,
      "client_secret": apiKey,
    };

    final response = await http.post(
      Uri.parse(URL),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      logger.d("Token 생성 요청이 성공하였습니다.");
      final Map<String, dynamic> data = json.decode(response.body);
      accessToken = '${data['access_token']}';
      tokenType = '${data['token_type']}';
      expiresIn = data['expires_in'];
      tokenObtained = true; // 토큰을 성공적으로 얻었다고 표시
    } else {
      logger.d("POST 요청이 실패하였습니다. 상태 코드: ${response.statusCode}");
      logger.d("오류 응답 데이터: ${response.body}");
    }
  }

  Future<List<Album>> getAlbums() async {
    List<Album> albums = [];
    // 토큰이 얻어졌는지 확인
    if (!tokenObtained) {
      logger.d('토큰 없음');
      // 토큰이 없다면
      await sendGetTokenRequest(); // 토큰을 얻기 위해 요청
      logger.d('토큰 가져옴');
    }

    if (tokenObtained) {
      logger.d('토큰 있음');
      // 토큰이 있다면
      const String baseUrl = 'https://api.spotify.com/v1/search';
      const String query = 'album tag:new';
      const String type = 'album';
      const int limit = 5;
      final Uri uri = Uri.parse('$baseUrl?q=$query&type=$type&limit=$limit');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': '$tokenType  $accessToken',
        },
      );
      if (response.statusCode == 200) {
        logger.d('statusCode 200');
        albums = parseAlbums(response.body);
      } else {
        logger.d('Failed to fetch data. Status Code: ${response.statusCode}');
      }
      return albums;
    }
    throw Error();
  }
}
