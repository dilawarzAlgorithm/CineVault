import 'package:cine_vault/model/watchlist.dart';

abstract class ILocalDataSource {
  Future<void> saveList(Watchlist list);

  Future<Watchlist?> loadList(String id);
}
