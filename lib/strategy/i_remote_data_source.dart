import 'package:cine_vault/entity/cine_item.dart';

abstract class IRemoteDataSource {
  Future<List<CineItem>> fetchData(String query);
}
