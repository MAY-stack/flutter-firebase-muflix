class Taste {
  final String uuid;
  final List<String> likedAlbums;
  final List<String> likedArtists;
  final List<String> likedTracks;

  Taste({
    required this.uuid,
    required this.likedAlbums,
    required this.likedArtists,
    required this.likedTracks,
  });
}
