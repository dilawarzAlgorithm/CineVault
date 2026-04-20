import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_vault/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CineDetail extends ConsumerWidget {
  const CineDetail({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailProvider(id));
    final watchlist = ref.watch(watchlistProvider);
    final isInWatchlist = watchlist.items.any((item) => item.id == id);

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.95,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: movieAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.red)),
        error: (err, stack) =>
            Center(child: Text('Failed to load movie details.')),
        data: (movie) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            movie.posterUrl != 'N/A' &&
                                movie.posterUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: movie.posterUrl,
                                height: 180,
                                width: 120,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(
                                  height: 180,
                                  width: 120,
                                  color: Colors.grey.shade800,
                                  child: const Icon(Icons.movie, size: 50),
                                ),
                              )
                            : Container(
                                height: 180,
                                width: 120,
                                color: Colors.grey.shade800,
                                child: const Icon(Icons.movie, size: 50),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 200,
                                    ),
                                    child: Text(
                                      movie.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.close_fullscreen,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${movie.year}  •  ${movie.runtime}',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${movie.rating} / 10',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: movie.genre.split(', ').map((g) {
                                return Chip(
                                  label: Text(
                                    g,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                  side: BorderSide.none,
                                  padding: EdgeInsets.zero,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isInWatchlist
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(isInWatchlist ? Icons.check : Icons.add),
                      label: Text(
                        isInWatchlist
                            ? 'Added to Watchlist'
                            : 'Add to Watchlist',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (isInWatchlist) {
                          ref
                              .read(watchlistProvider.notifier)
                              .removeCineItem(movie);
                        } else {
                          ref
                              .read(watchlistProvider.notifier)
                              .addCineItem(movie);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Storyline',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    movie.plot != 'N/A' ? movie.plot : 'No plot available.',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
