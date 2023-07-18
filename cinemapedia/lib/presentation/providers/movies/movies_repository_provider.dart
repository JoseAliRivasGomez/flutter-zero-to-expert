import 'package:cinemapedia/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//read-only
final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(TheMovieDbDatasource());
});
