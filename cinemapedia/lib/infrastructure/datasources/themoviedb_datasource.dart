import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/themoviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbApiKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final themovieDbResponse = TheMovieDbResponse.fromJson(json);

    final List<Movie> movies = themovieDbResponse.results
        .where((themoviedb) => themoviedb.posterPath != 'no-poster')
        .map((themoviedb) => MovieMapper.themoviedbToEntity(themoviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id $id not found');
    }
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
}
