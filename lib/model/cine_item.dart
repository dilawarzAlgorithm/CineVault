import 'package:cine_vault/enum/cine_type.dart';

class CineItem {
  const CineItem({
    required this.id,
    required this.title,
    required this.type,
    required this.posterUrl,
    required this.year,
    required this.rating,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.language,
    required this.country,
    required this.plot,
  });

  final String id;
  final String title;
  final CineType type;
  final String posterUrl;
  final String year;
  final double rating;
  final String released;
  final String runtime;
  final String genre;
  final String language;
  final String country;
  final String plot;

  factory CineItem.fromJson(Map<String, dynamic> json) {
    return CineItem(
      id: json['imdbID'] ?? '',
      title: json['Title'] ?? 'Unknown',
      type: _parseType(json['Type']),
      posterUrl: json['Poster'] ?? '',
      year: json['Year'] ?? '',
      rating: double.tryParse(json['imdbRating'] ?? '0.0') ?? 0.0,
      released: json['Released'] ?? 'N/A',
      runtime: json['Runtime'] ?? '0 min',
      genre: json['Genre'] ?? '',
      language: json['Language'] ?? '',
      country: json['Country'] ?? '',
      plot: json['Plot'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imdbID': id,
      'Title': title,
      'Type': type.name,
      'Poster': posterUrl,
      'Year': year,
      'imdbRating': rating.toString(),
      'Released': released,
      'Runtime': runtime,
      'Genre': genre,
      'Language': language,
      'Country': country,
      'Plot': plot,
    };
  }

  static CineType _parseType(String? typeStr) {
    if (typeStr == 'movie') return CineType.movie;
    if (typeStr == 'series') return CineType.series;
    if (typeStr == 'episode') return CineType.episode;
    return CineType.movie;
  }
}
