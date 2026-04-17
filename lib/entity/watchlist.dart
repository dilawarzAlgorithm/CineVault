import 'package:cine_vault/entity/cine_item.dart';

class Watchlist {
  Watchlist({required this.listId, required this.name, required this.items});

  final String listId;
  final String name;
  List<CineItem> items;
}
