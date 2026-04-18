import 'dart:convert';
import 'package:cine_vault/model/cine_item.dart';
import 'package:cine_vault/strategy/i_remote_data_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final _baseUrl = dotenv.env['DATA_BASE_URL'] ?? '';

class ApiManager extends IRemoteDataSource {
  @override
  Future<List<CineItem>> fetchData(String query) async {
    final url = Uri.parse('$_baseUrl&$query');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
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
        }
      }
      return <CineItem>[];
    } catch (e) {
      return <CineItem>[];
    }
  }
}
