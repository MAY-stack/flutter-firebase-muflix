class Album {
  final String albumId;
  final String artistId;
  final String artistName;
  final String externalUrl;
  final String imageUrl;
  final String albumName;

  Album({
    required this.albumId,
    required this.artistId,
    required this.artistName,
    required this.externalUrl,
    required this.imageUrl,
    required this.albumName,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    final String albumId = json['id'];
    final String artistId = json['artists'][0]['id'];
    final String artistName = json['artists'][0]['name'];
    final String externalUrl = json['external_urls']['spotify'];
    final String imageUrl =
        json["images"].isEmpty ? '' : json['images'][0]['url'];
    final String albumName = json['name'];

    return Album(
      albumId: albumId,
      artistId: artistId,
      artistName: artistName,
      externalUrl: externalUrl,
      imageUrl: imageUrl,
      albumName: albumName,
    );
  }
}
