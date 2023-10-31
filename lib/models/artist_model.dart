class Artist {
  final String artistId;
  final String imageUrl;
  final String artistName;
  final String artistPopularity;
  final String artistUri;

  Artist({
    required this.artistId,
    required this.imageUrl,
    required this.artistName,
    required this.artistPopularity,
    required this.artistUri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    final String artistId = json['items']['id'];
    final String imageUrl = json['items']['images'][0]['url'];
    final String artistName = json['items']['name'];
    final String artistPopularity = json['items']['popularity'];
    final String artistUri = json['items']['uri'];

    return Artist(
      artistId: artistId,
      imageUrl: imageUrl,
      artistName: artistName,
      artistPopularity: artistPopularity,
      artistUri: artistUri,
    );
  }
}
