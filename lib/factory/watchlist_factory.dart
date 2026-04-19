import 'package:cine_vault/model/watchlist.dart';

class WatchlistFactory {
  const WatchlistFactory({required this.id, required this.name});

  final String name;
  final String id;

  Watchlist createWatchlist() {
    return Watchlist(listId: id, name: name, items: []);
  }
}
