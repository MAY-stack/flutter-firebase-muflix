class Track {
  final String trackId;
  final String trackName;
  final String albumId;
  final String albumName;
  final String artistId;
  final String artistName;
  final String imageUrl;
  final int popularity;

  Track({
    required this.trackId,
    required this.trackName,
    required this.albumId,
    required this.albumName,
    required this.artistId,
    required this.artistName,
    required this.imageUrl,
    required this.popularity,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    final String trackId = json['id'];
    final String trackName = json['name'];
    final String albumId = json['album']['id'];
    final String albumName = json['album']['name'];
    final String artistId = json['artists'][0]['id'];
    final String artistsName = json['artists'][0]['name'];
    final String imageUrl = json['album']['images'].isEmpty
        ? ''
        : json['album']['images'][0]['url'];
    final int popularity = json['popularity'];

    return Track(
      trackId: trackId,
      trackName: trackName,
      albumId: albumId,
      albumName: albumName,
      artistId: artistId,
      artistName: artistsName,
      imageUrl: imageUrl,
      popularity: popularity,
    );
  }
}
