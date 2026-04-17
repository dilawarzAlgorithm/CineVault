import 'package:cine_vault/entity/cine_item.dart';
import 'package:cine_vault/entity/watchlist.dart';
import 'package:cine_vault/repository/cine_repository.dart';

class WatchlistManager {
  WatchlistManager({required this.repository, required this.currentWatchlist});
  final CineRepository repository;
  Watchlist currentWatchlist;

  void loadWatchlist(String id) {
    currentWatchlist = repository.loadWatchlist(id);
  }

  void addCineItem(CineItem item) {
    //perform check
    currentWatchlist.items.add(item);
    repository.saveWatchlist(currentWatchlist);
  }

  void removeCineItem(CineItem item) {
    //perform check
    currentWatchlist.items.remove(item);
    repository.saveWatchlist(currentWatchlist);
  }

  void searchNetwork(String query) {
    repository.executeSearch(query);
  }
}
