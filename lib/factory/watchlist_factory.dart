import 'package:cine_vault/model/watchlist.dart';
import 'package:uuid/uuid.dart';

class WatchlistFactory {
  const WatchlistFactory({required this.name});

  final String name;

  Watchlist createWatchlist() {
    return Watchlist(listId: Uuid().v4(), name: name, items: []);
  }
}
