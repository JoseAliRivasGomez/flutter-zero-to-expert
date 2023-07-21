import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/actors/actors_by_movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_rating.dart';
import 'package:cinemapedia/presentation/widgets/movies/similar_movies.dart';
import 'package:cinemapedia/presentation/widgets/videos/videos_from_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MovieDetails(movie: movie),
                childCount: 1),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        //* Titulo, OverView y Rating
        _TitleAndOverview(movie: movie, size: size, textStyles: textStyles),

        //* Generos de la película
        _Genres(movie: movie),


        //* Actores de la película
        ActorsByMovie(movieId: movie.id.toString() ),

        //* Películas similares
        SimilarMovies(movieId: movie.id ),

        //* Videos de la película (si tiene)
        VideosFromMovie( movieId: movie.id ),

      ],
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map((gender) => Container(
              margin: const EdgeInsets.only( right: 10),
              child: Chip(
                label: Text( gender ),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }
                return FadeIn(child: child);
              },
            ),
          ),

          const SizedBox( width: 10 ),

          // Descripción
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title, style: textStyles.titleLarge ),
                Text( movie.overview ),

                const SizedBox(height: 10 ),
                
                MovieRating(voteAverage: movie.voteAverage, popularity: movie.popularity),

                Row(
                  children: [
                    const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5 ),
                    Text(HumanFormats.shortDate(movie.releaseDate))
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    //print(movie.posterPath);
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            // ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
            await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    shadows: [
                      Shadow(
                          blurRadius: 1,
                          color: Colors.black,
                          offset: Offset(1, 1))
                    ],
                  )
                : const Icon(
                    Icons.favorite_border,
                    shadows: [
                      Shadow(
                          blurRadius: 1,
                          color: Colors.black,
                          offset: Offset(1, 1))
                    ],
                  ),
            error: (_, __) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        // title: SizedBox(
        //   width: double.infinity,
        //   child: Text(
        //     movie.title,
        //     style: const TextStyle(fontSize: 14),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        background: Stack(
          children: [
            // SizedBox.expand(
            //   child: Image.network(
            //     movie.posterPath2,
            //     fit: BoxFit.cover,
            //     loadingBuilder: (context, child, loadingProgress) {
            //       if (loadingProgress != null) {
            //         return const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Center(
            //               child: CircularProgressIndicator(strokeWidth: 2)),
            //         );
            //       }
            //       return FadeIn(child: child);
            //     },
            //   ),
            // ),
            SizedBox.expand(
              child: FadeInImage(
                placeholder: NetworkImage(
                    movie.posterPath), // URL de la imagen de placeholder
                image: NetworkImage(movie.posterPath2),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 1),
                fadeOutDuration: const Duration(milliseconds: 1),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.network(
                      'https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg'); // URL de la imagen de error en caso de fallo de carga
                },
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),
            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              stops: [0, 0.25],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
