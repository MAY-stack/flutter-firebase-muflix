import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/track_model.dart';

class ApiRefctoring {
  Logger logger = Logger();
  late final String accessToken;
  late final String tokenType;
  late final int expiresIn;
  bool tokenExist = false; // 유효한 토근 있는지 여부

  // 토큰 만료 시간을 확인하여 만료되었으면 토큰을 다시 요청하고,
  // 만료되지 않았으면 토큰을 재사용한다.

  // get albums
  Future<List<Album>> getAlbum() async {
    if (!tokenExist) await requestTokenPost();

    const String baseUrl = 'https://api.spotify.com/v1/search';
    const String query = 'tag:new';
    const String type = 'album';
    const int limit = 5;
    final Uri uri =
        Uri.parse('$baseUrl?q=$query&type=$type&limit=$limit&market=KR');

    Response responseAlbum = await http.get(
      uri,
      headers: {
        'Authorization': '$tokenType  $accessToken',
      },
    );
    if (responseAlbum.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(responseAlbum.body);
      final List<dynamic> albumList = jsonData['albums']['items'];
      List<Album> albums = [];
      for (var album in albumList) {
        albums.add(Album.fromJson(album));
      }
      return albums;
    }
    throw Exception('Failed to load album');
  }

  Future<List<Artist>> getArtist() async {
    Logger().d('start get Artist requestToken \n tokenExist : $tokenExist');

    if (!tokenExist) await requestTokenPost();

    logger.d('Get Artist.  tokenExist : $tokenExist');

    const String baseUrl = 'https://api.spotify.com/v1/search';
    const String query = 'tag: new';
    const String type = 'artist';
    const int limit = 5;
    final Uri uri =
        Uri.parse('$baseUrl?q=$query&type=$type&limit=$limit&market=KR');

    final responseArtist = await http.get(
      uri,
      headers: {
        'Authorization': '$tokenType  $accessToken',
      },
    );

    if (responseArtist.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(responseArtist.body);
      final List<dynamic> artistList = jsonData['artists']['items'];

      List<Artist> artists = [];
      for (var artist in artistList) {
        artists.add(Artist.fromJson(artist));
      }
      return artists;
    }
    throw Exception('Failed to load artist');
  }

  Future<List<Track>> getTrack() async {
    if (!tokenExist) await requestTokenPost();
    /*get Token*/
    const String baseUrl = 'https://api.spotify.com/v1/search';
    const String query = '%2520track%3ADoxy%2520artist%3AMiles%2520Davis';
    const String type = 'track';
    const int limit = 5;
    final Uri uri =
        Uri.parse('$baseUrl?q=$query&type=$type&limit=$limit&market=KR');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': '$tokenType  $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      Logger().d('jsonData : $jsonData');
      final List<dynamic> trackList = jsonData['tracks']['items'];
      Logger().d('trackList : $trackList');
      List<Track> tracks = [];
      for (var track in trackList) {
        tracks.add(Track.fromJson(track));
      }
      Logger().d('tracks : $tracks');
      return tracks;
    }
    throw Exception('Failed to load artist');
  }

  Future<void> requestTokenPost() async {
    await dotenv.load(fileName: "assets/.env");
    const String url = "https://accounts.spotify.com/api/token";
    final String apiId = dotenv.env['CLIENT_ID'] ?? 'default_secret_key';
    final String apiKey =
        dotenv.env['CLIENT_SECRET_KEY'] ?? 'default_secret_key';

    final Map<String, String> body = {
      "grant_type": "client_credentials",
      "client_id": apiId,
      "client_secret": apiKey
    };

    Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      accessToken = '${data['access_token']}';
      tokenType = '${data['token_type']}';
      expiresIn = data['expires_in'];
      tokenExist = true;
      logger.d("Token을 얻는 POST 요청이 성공하였습니다");
    } else {
      logger.d("Token을 얻는 POST 요청이 실패하였습니다. 상태 코드: ${response.statusCode}");
      logger.d("오류 응답 데이터: ${response.body}");
    }
  }
}
