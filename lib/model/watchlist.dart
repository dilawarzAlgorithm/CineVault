import 'package:cine_vault/model/cine_item.dart';

class Watchlist {
  Watchlist({required this.listId, required this.name, required this.items});

  final String listId;
  final String name;
  List<CineItem> items;

  factory Watchlist.fromJson(Map<String, dynamic> json) {
    return Watchlist(
      listId: json['listId'] ?? '',
      name: json['name'] ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => CineItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listId': listId,
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
