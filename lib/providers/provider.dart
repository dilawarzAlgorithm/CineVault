import 'package:cine_vault/managers/api_manager.dart';
import 'package:cine_vault/managers/persistence_manager.dart';
import 'package:cine_vault/repository/cine_repository.dart';
import 'package:cine_vault/strategy/title_search_strategy.dart';
import 'package:cine_vault/model/cine_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider((ref) => ApiManager());
final dbProvider = Provider((ref) => PersistenceManager());
final titleSearchProvider = Provider((ref) => TitleSearchStrategy());

final cineRepositoryProvider = Provider((ref) {
  return CineRepository(
    api: ref.read(apiProvider),
    db: ref.read(dbProvider),
    searchStrategy: ref.read(titleSearchProvider),
  );
});

// Used AsyncValue to automatically handle Loading, Success, and Error states!
class SearchNotifier extends AsyncNotifier<List<CineItem>> {
  CineRepository get _repository => ref.read(cineRepositoryProvider);

  @override
  Future<List<CineItem>> build() async {
    return <CineItem>[];
  }

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _repository.executeSearch(query);
    });
  }
}

final searchProvider = AsyncNotifierProvider<SearchNotifier, List<CineItem>>(
  () {
    return SearchNotifier();
  },
);
