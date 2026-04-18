import 'package:cine_vault/model/cine_item.dart';

abstract class IRemoteDataSource {
  Future<List<CineItem>> fetchData(String query);
}
