import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_vault/model/cine_item.dart';
import 'package:cine_vault/providers/provider.dart';
import 'package:cine_vault/widgets/cine_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            if (watchlist.items.isNotEmpty) ...[
              const _SectionHeader(
                title: 'From Your Vault',
                isVaultHeader: true,
              ),
              _HorizontalCarousel(movies: watchlist.items),
              const SizedBox(height: 30),
            ],

            const _CuratedRow(title: 'Marvel Universe', query: 'Marvel'),
            const SizedBox(height: 30),
            const _CuratedRow(title: 'Sci-Fi Classics', query: 'Star Wars'),
            const SizedBox(height: 30),
            const _CuratedRow(title: 'Pixar Animation', query: 'Pixar'),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title, this.isVaultHeader = false});

  final bool isVaultHeader;

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: 18,
      letterSpacing: 1.5,
      color: Colors.white70,
    );

    if (isVaultHeader) {
      style = Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 20,
        letterSpacing: 1.5,
        color: const Color.fromARGB(238, 218, 116, 116),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(title.toUpperCase(), style: style),
    );
  }
}

class _CuratedRow extends ConsumerWidget {
  final String title;
  final String query;

  const _CuratedRow({required this.title, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovies = ref.watch(curatedMoviesProvider(query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title),
        SizedBox(
          height: 200,
          child: asyncMovies.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                const Center(child: Text('Failed to load items')),
            data: (movies) => _HorizontalCarousel(movies: movies),
          ),
        ),
      ],
    );
  }
}

class _HorizontalCarousel extends StatelessWidget {
  final List<CineItem> movies;
  const _HorizontalCarousel({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => CineDetail(id: movie.id),
              );
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:
                          movie.posterUrl != 'N/A' && movie.posterUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: movie.posterUrl,
                              fit: BoxFit.cover,
                              width: 130,
                              placeholder: (context, url) =>
                                  Container(color: Colors.black26),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image),
                            )
                          : Container(
                              color: Colors.grey[900],
                              child: const Icon(Icons.movie, size: 40),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    movie.year,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
