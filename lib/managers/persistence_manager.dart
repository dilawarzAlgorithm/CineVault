import 'package:cine_vault/entity/watchlist.dart';
import 'package:cine_vault/strategy/i_local_data_source.dart';

class PersistenceManager extends ILocalDataSource {
  @override
  void saveList(Watchlist list) {}

  @override
  Watchlist loadList(String id) {
    return Watchlist(listId: id, name: 'name', items: []);
  }
}
