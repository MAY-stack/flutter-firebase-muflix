class Track {
  final String trackId;
  final String trackName;
  final String albumId;
  final String albumName;
  final String artistId;
  final String artistName;
  final String imageUrl;
  final int trackPopularity;

  Track({
    required this.trackId,
    required this.trackName,
    required this.albumId,
    required this.albumName,
    required this.artistId,
    required this.artistName,
    required this.imageUrl,
    required this.trackPopularity,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    final String trackId = json['items']['id'];
    final String trackName = json['items']['name'];
    final String albumId = json['items']['album']['id'];
    final String albumName = json['items']['album']['name'];
    final String artistId = json['items']['artists'][0]['id'];
    final String artistsName = json['items']['artists'][0]['name'];
    final String imageUrl =
        json['items']['album ']['itmes']['images'][1]['url'];
    final int trackPopularity = json['items']['popularity'];
    return Track(
      trackId: trackId,
      trackName: trackName,
      albumId: albumId,
      albumName: albumName,
      artistId: artistId,
      artistName: artistsName,
      imageUrl: imageUrl,
      trackPopularity: trackPopularity,
    );
  }
}
