import 'package:cine_vault/entity/watchlist.dart';

abstract class ILocalDataSource {
  void saveList(Watchlist list);

  Watchlist loadList(String id);
}
