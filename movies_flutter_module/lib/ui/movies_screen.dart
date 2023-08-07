import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter_module/business/movies_bloc.dart';
import 'package:movies_flutter_module/ui/widgets/movie_details.dart';
import 'package:movies_flutter_module/ui/widgets/movie_grid.dart';
import 'package:movies_flutter_module/ui/widgets/platform.dart';

class MoviesCard extends StatefulWidget {
  const MoviesCard({required int index, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesScreenState();
}


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Movies',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moviesScreen = Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //_buildTitle(),
        MoviesGrid(),
      ],
    );
    return Scaffold(
      body: MyPlatform.isTv ? moviesScreen : SafeArea(child: moviesScreen),
    );
  }
}

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return MovieGridWidget(
            movies: state.movies,
            onTapMovie: (movie) =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return MovieDetailsWidget(movie: movie);
                })),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return  MovieDetailsWidget(movie: state.movies[0]);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
  }
}

