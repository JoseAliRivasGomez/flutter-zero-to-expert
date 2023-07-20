import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {
  static Movie themoviedbToEntity(MovieTheMovieDB themoviedb) => Movie(
      adult: themoviedb.adult,
      backdropPath: themoviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${themoviedb.backdropPath}'
          : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
      genreIds: themoviedb.genreIds.map((e) => e.toString()).toList(),
      id: themoviedb.id,
      originalLanguage: themoviedb.originalLanguage,
      originalTitle: themoviedb.originalTitle,
      overview: themoviedb.overview,
      popularity: themoviedb.popularity,
      posterPath: themoviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${themoviedb.posterPath}'
          : 'https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png', //no-poster or https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png
      posterPath2: themoviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${themoviedb.posterPath}'
          : 'https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png', //no-poster or https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png
      releaseDate: themoviedb.releaseDate == null ? DateTime.now() : themoviedb.releaseDate!,
      title: themoviedb.title,
      video: themoviedb.video,
      voteAverage: themoviedb.voteAverage,
      voteCount: themoviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
      adult: movie.adult,
      backdropPath: movie.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
          : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
      genreIds: movie.genres.map((e) => e.name).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: movie.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
          : 'https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png', //no-poster or https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png
      posterPath2: movie.posterPath != ''
          ? 'https://www.themoviedb.org/t/p/original${movie.posterPath}'
          : 'https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png', //no-poster or https://sd.keepcalms.com/i-w500/keep-calm-poster-not-found.png
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount);
}
