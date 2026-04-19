import 'package:cine_vault/model/cine_item.dart';
import 'package:cine_vault/model/watchlist.dart';
import 'package:cine_vault/providers/provider.dart';
import 'package:cine_vault/repository/cine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchlistManager extends Notifier<Watchlist> {
  CineRepository get _repository => ref.read(cineRepositoryProvider);

  @override
  Watchlist build() {
    _loadFromDisk();
    return Watchlist(listId: 'default_list', name: 'My Vault', items: []);
  }

  Future<void> _loadFromDisk() async {
    final savedList = await _repository.loadWatchlist('default_list');

    if (savedList != null) {
      state = savedList;
    }
  }

  void addCineItem(CineItem item) {
    if (state.items.any((existingItem) => existingItem.id == item.id)) {
      return;
    }

    final updatedList = [...state.items, item];

    state = Watchlist(
      listId: state.listId,
      name: state.name,
      items: updatedList,
    );

    _repository.saveWatchlist(state);
  }

  void removeCineItem(CineItem item) {
    final updatedList = List<CineItem>.from(state.items)
      ..removeWhere((existingItem) => existingItem.id == item.id);

    state = Watchlist(
      listId: state.listId,
      name: state.name,
      items: updatedList,
    );

    _repository.saveWatchlist(state);
  }
}
