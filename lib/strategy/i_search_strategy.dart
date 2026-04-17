import 'package:cine_vault/entity/cine_item.dart';
import 'package:cine_vault/strategy/i_remote_data_source.dart';

abstract class ISearchStrategy {
  Future<List<CineItem>> search(String query, IRemoteDataSource api);
}
