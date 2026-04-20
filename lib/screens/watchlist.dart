import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_vault/providers/provider.dart';
import 'package:cine_vault/widgets/cine_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    return Scaffold(
      body: watchlist.items.isEmpty
          ? Center(
              child: Text(
                'Your Watchlist is Empty.\nSearch for movies to add!',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: watchlist.items.length,
              itemBuilder: (context, index) {
                final movie = watchlist.items[index];

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return CineDetail(id: movie.id);
                      },
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          width: 50,
                          height: 75,
                          child:
                              movie.posterUrl != 'N/A' &&
                                  movie.posterUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: movie.posterUrl,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey.shade800,
                                  child: const Icon(
                                    Icons.movie,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),
                      title: Text(
                        movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${movie.year} • ${movie.type.name.toUpperCase()}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          ref
                              .read(watchlistProvider.notifier)
                              .removeCineItem(movie);

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed "${movie.title}".'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
