import 'package:movies_flutter_module/services/dummy_movies_service.dart';
import 'package:movies_flutter_module/services/movies_service.dart';

MoviesService getMoviesService() {
  return DummyMoviesService();
}
