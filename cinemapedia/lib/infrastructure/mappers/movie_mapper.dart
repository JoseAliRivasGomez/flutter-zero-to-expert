import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {
  static Movie themoviedbToEntity(MovieTheMovieDB themoviedb) => Movie(
      adult: themoviedb.adult,
      backdropPath: themoviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${themoviedb.backdropPath}'
          : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
      genreIds: themoviedb.genreIds.map((e) => e.toString()).toList(),
      id: themoviedb.id,
      originalLanguage: themoviedb.originalLanguage,
      originalTitle: themoviedb.originalTitle,
      overview: themoviedb.overview,
      popularity: themoviedb.popularity,
      posterPath: themoviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500/${themoviedb.posterPath}'
          : 'no-poster', //no-poster or https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png
      releaseDate: themoviedb.releaseDate,
      title: themoviedb.title,
      video: themoviedb.video,
      voteAverage: themoviedb.voteAverage,
      voteCount: themoviedb.voteCount);
}
