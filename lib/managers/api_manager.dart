import 'dart:convert';
import 'package:cine_vault/model/cine_episode.dart';
import 'package:cine_vault/model/cine_item.dart';
import 'package:cine_vault/strategy/i_remote_data_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String get _apiKey => dotenv.env['OMDB_API_KEY'] ?? '';
final String _baseUrl = 'http://www.omdbapi.com/';

class ApiManager extends IRemoteDataSource {
  @override
  Future<List<CineItem>> fetchData(String query) async {
    final url = Uri.parse('$_baseUrl?apikey=$_apiKey&$query');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['Response'] == 'True') {
          // If Search List (query was ?s=...)
          if (data['Search'] != null) {
            final List results = data['Search'];
            return results.map((json) => CineItem.fromJson(json)).toList();
          }
          // If Single Item (query was ?i=... or ?t=...)
          else {
            return [CineItem.fromJson(data)];
          }
        } else {
          throw Exception(data['Error']);
        }
      } else {
        throw Exception('Failed to connect to OMDB API');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CineEpisode>> fetchSeasonEpisodes(
    String seriesId,
    int season,
  ) async {
    final url = Uri.parse(
      '$_baseUrl?apikey=$_apiKey&i=$seriesId&Season=$season',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['Response'] == 'True') {
        if (data['Episodes'] != null) {
          final List episodes = data['Episodes'];
          return episodes.map((json) => CineEpisode.fromJson(json)).toList();
        }
      }
      return <CineEpisode>[];
    } catch (e) {
      rethrow;
    }
  }
}
