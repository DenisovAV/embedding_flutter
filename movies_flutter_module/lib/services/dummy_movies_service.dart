import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:movies_flutter_module/domain/movie.dart';
import 'package:movies_flutter_module/domain/movies_list.dart';
import 'package:movies_flutter_module/services/movies_service.dart';

class DummyMoviesService implements MoviesService {
  @override
  Future<List<Movie>> getMovies() async {
    return MoviesList.fromJson(await rootBundle
            .loadString('assets/service.json')
            .then((movies) => json.decode(movies)))
        .movies;
  }

  @override
  Future<Movie> getMovie(String name) async {
    final list = MoviesList.fromJson(await rootBundle
            .loadString('assets/service.json')
            .then((movies) => json.decode(movies)))
        .movies;
    return list.firstWhere((element) => element.name == name);
  }
}
