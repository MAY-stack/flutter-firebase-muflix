class Album {
  final String id;
  final String externalUrl;
  final String imageUrl;
  final String name;
  final bool like;

  Album({
    required this.id,
    required this.externalUrl,
    required this.imageUrl,
    required this.name,
    required this.like,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    final List<dynamic> artists = json['artists'];
    final String artistId = artists.isNotEmpty ? artists[0]['id'] : '';

    final List<dynamic> images = json['images'];
    final String imageUrl = images.isNotEmpty ? images[1]['url'] : '';

    return Album(
      id: json['id'],
      externalUrl: json['external_urls']['spotify'],
      imageUrl: imageUrl,
      name: json['name'],
      like: false,
    );
  }
}
