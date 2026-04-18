import 'package:cine_vault/model/cine_item.dart';
import 'package:cine_vault/strategy/i_remote_data_source.dart';
import 'package:cine_vault/strategy/i_search_strategy.dart';

class IdSearchStrategy extends ISearchStrategy {
  @override
  Future<List<CineItem>> search(String query, IRemoteDataSource api) async {
    return <CineItem>[];
  }
}
