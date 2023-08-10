import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter_module/domain/movie.dart';
import 'package:movies_flutter_module/services/platform_service.dart';
import 'package:movies_flutter_module/services/services.dart';
import 'package:movies_flutter_module/ui/widgets/movie_details.dart';
import 'package:movies_flutter_module/util.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Mode mode;
  final BuildContext context;
  final platformService = PlatformService();

  MoviesBloc({required this.context, this.mode = Mode.standalone}) : super(MoviesInitialState()) {
    if (mode == Mode.module_details) {
      platformService.getStream().listen((event) async {
        final movie = await getMoviesService().getMovie(event);
        add(MoviesOpenDetailsEvent(movie: movie));
      });
    }
  }

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    switch (event) {
      case MoviesInitialEvent _:
        {
          final movies = await getMoviesService().getMovies();
          yield MoviesLoadedState(movies: movies);
        }
      case MoviesOpenDetailsEvent oEvent:
        {
          switch (mode) {
            case Mode.standalone:
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetailsWidget(movie: oEvent.movie);
                    },
                  ),
                );
                break;
              }
            case Mode.module_list:
              {
                platformService.openMovieDetails(oEvent.movie.name);
                break;
              }
            case Mode.module_details:
              {
                yield MoviesOpenedState(movie: oEvent.movie);
                break;
              }
          }
        }
    }
  }
}

abstract class MoviesEvent {}

class MoviesInitialEvent extends MoviesEvent {}

class MoviesOpenDetailsEvent extends MoviesEvent {
  final Movie movie;

  MoviesOpenDetailsEvent({required this.movie});
}

abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState({this.movies = const []});
}

class MoviesOpenedState extends MoviesState {
  final Movie movie;

  MoviesOpenedState({required this.movie});
}
