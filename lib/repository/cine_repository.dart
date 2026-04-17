import 'package:cine_vault/entity/cine_item.dart';
import 'package:cine_vault/entity/watchlist.dart';
import 'package:cine_vault/strategy/i_local_data_source.dart';
import 'package:cine_vault/strategy/i_remote_data_source.dart';
import 'package:cine_vault/strategy/i_search_strategy.dart';

class CineRepository {
  CineRepository({
    required this.api,
    required this.db,
    required this.searchStrategy,
  });

  final IRemoteDataSource api;
  final ILocalDataSource db;
  ISearchStrategy searchStrategy;

  void setSearchStrategy(ISearchStrategy strategy) {
    searchStrategy = strategy;
  }

  Future<List<CineItem>> executeSearch(String query) async {
    return searchStrategy.search(query, api);
  }

  void saveWatchlist(Watchlist list) {
    db.saveList(list);
  }

  Watchlist loadWatchlist(String listId) {
    return db.loadList(listId);
  }
}
