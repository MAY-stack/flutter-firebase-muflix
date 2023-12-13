import 'package:logger/logger.dart';

class Artist {
  final String artistId;
  final String imageUrl;
  final String artistName;
  final int artistPopularity;
  final String artistUri;

  Artist({
    required this.artistId,
    required this.imageUrl,
    required this.artistName,
    required this.artistPopularity,
    required this.artistUri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    final String artistId = json['id'];

    final String imageUrl = json["images"].isEmpty
        ? 'https://cdn0.iconfinder.com/data/icons/shopping-197/48/bl_872_profile_avatar_anonymous_customer_user_head_human-512.png'
        : json['images'][0]['url'];
    final String artistName = json['name'];
    final int artistPopularity = json['popularity'];
    final String artistUri = json['uri'];

    return Artist(
      artistId: artistId,
      imageUrl: imageUrl,
      artistName: artistName,
      artistPopularity: artistPopularity,
      artistUri: artistUri,
    );
  }
}
