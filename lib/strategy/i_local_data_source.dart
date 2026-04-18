import 'package:cine_vault/model/watchlist.dart';

abstract class ILocalDataSource {
  void saveList(Watchlist list);

  Watchlist loadList(String id);
}
