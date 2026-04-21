class CineEpisode {
  const CineEpisode({
    required this.title,
    required this.episodeNumber,
    required this.released,
    required this.imdbRating,
    required this.imdbId,
  });

  final String title;
  final String episodeNumber;
  final String released;
  final String imdbRating;
  final String imdbId;

  factory CineEpisode.fromJson(Map<String, dynamic> json) {
    return CineEpisode(
      title: json['Title'] ?? 'Unknown',
      episodeNumber: json['Episode'] ?? '',
      released: json['Released'] ?? 'N/A',
      imdbRating: json['imdbRating'] ?? 'N/A',
      imdbId: json['imdbID'] ?? '',
    );
  }
}
