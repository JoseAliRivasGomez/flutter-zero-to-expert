import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_details_provider.dart';
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
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Imagen
              SizedBox(
                width: size.width * 0.3,
                height: size.height * 0.2,
                child: ClipRRect(
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
              ),
              const SizedBox(width: 10),

              //Descripcion
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                        style: textStyles.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(movie.overview, style: textStyles.bodyMedium),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((genre) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(genre),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //print(movie.posterPath);
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        title: const SizedBox(
          width: double.infinity,
          // child: Text(
          //   movie.title,
          //   style: const TextStyle(fontSize: 14),
          //   textAlign: TextAlign.center,
          // ),
        ),
        background: Stack(
          children: [
            // SizedBox.expand(
            //   child: Image.network(
            //     movie.posterPath,
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
                placeholder: NetworkImage(movie.posterPath), // URL de la imagen de placeholder
                image: NetworkImage(movie.posterPath2),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 1),
                fadeOutDuration: const Duration(milliseconds: 1),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.network('https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg'); // URL de la imagen de error en caso de fallo de carga
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.75, 1.0],
                        colors: [Colors.transparent, Colors.black87])),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, stops: [
                  0.0,
                  0.25
                ], colors: [
                  Colors.black87,
                  Colors.transparent,
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
