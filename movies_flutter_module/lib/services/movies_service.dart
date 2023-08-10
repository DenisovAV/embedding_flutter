import 'package:movies_flutter_module/domain/movie.dart';

abstract class MoviesService {
  Future<List<Movie>> getMovies();
  Future<Movie> getMovie(String name);
}
